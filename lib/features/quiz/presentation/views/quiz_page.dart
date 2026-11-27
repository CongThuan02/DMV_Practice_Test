import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/error_retry_view.dart';
import '../../../../data/topic_catalog.dart';
import '../view_models/quiz_state.dart';
import '../view_models/quiz_view_model.dart';
import '../widgets/exam_timer.dart';
import '../widgets/explanation_panel.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_result_view.dart';

class QuizPage extends ConsumerWidget {
  const QuizPage({super.key, required this.mode, this.topic});

  final QuizMode mode;
  final String? topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = quizViewModelProvider(mode, topic);
    return ref
        .watch(provider)
        .when(
          loading: () => Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Scaffold(
            appBar: AppBar(),
            body: error is EmptyQuizException
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        LocaleKeys.quiz_empty.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ErrorRetryView(onRetry: () => ref.invalidate(provider)),
          ),
          data: (state) => state.finished
              ? QuizResultView(
                  state: state,
                  onRetry: ref.read(provider.notifier).restart,
                )
              : _QuizRunning(
                  state: state,
                  notifier: ref.read(provider.notifier),
                ),
        );
  }
}

class _QuizRunning extends StatelessWidget {
  const _QuizRunning({required this.state, required this.notifier});

  final QuizState state;
  final QuizViewModel notifier;

  String get _modeLabel => switch (state.mode) {
    QuizMode.mock => LocaleKeys.quiz_mode_mock.tr(),
    QuizMode.mistakes => LocaleKeys.quiz_mode_mistakes.tr(),
    QuizMode.practice =>
      state.topic == null
          ? LocaleKeys.quiz_mode_practice.tr()
          : TopicCatalog.of(state.topic!).title,
  };

  Future<void> _confirmExit(BuildContext context) async {
    final leave = await showConfirmDialog(
      context,
      title: LocaleKeys.quiz_exit_title.tr(),
      message: LocaleKeys.quiz_exit_message.tr(),
      confirmLabel: LocaleKeys.quiz_exit_confirm.tr(),
    );
    if (leave && context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final mutedStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    final answer = state.currentAnswer;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.quiz_progress.tr(
                  args: ['${state.index + 1}', '${state.total}'],
                ),
              ),
              Text(_modeLabel, style: mutedStyle),
            ],
          ),
          actions: [
            if (state.isTimed) ...[
              Center(child: ExamTimer(state: state)),
              IconButton(
                tooltip: state.isPaused
                    ? LocaleKeys.quiz_resume.tr()
                    : LocaleKeys.quiz_pause.tr(),
                icon: Icon(state.isPaused ? Icons.play_arrow : Icons.pause),
                onPressed: state.isPaused ? notifier.resume : notifier.pause,
              ),
            ],
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: LinearProgressIndicator(
              value: (state.index + 1) / state.total,
            ),
          ),
        ),
        body: state.isPaused
            ? _PausedView(onResume: notifier.resume)
            : ListView(
                key: ValueKey(state.index),
                padding: const EdgeInsets.all(16),
                children: [
                  QuestionCard(
                    question: state.current,
                    selected: answer,
                    reveal: state.revealsAnswers,
                    onPick: state.revealsAnswers && answer != null
                        ? null
                        : notifier.answer,
                  ),
                  if (state.revealsAnswers && answer != null) ...[
                    const SizedBox(height: 16),
                    ExplanationPanel(
                      question: state.current,
                      selected: answer,
                      unlocked: state.unlockedExplanations.contains(
                        state.index,
                      ),
                      onUnlocked: () => notifier.unlockExplanation(state.index),
                    ),
                  ],
                ],
              ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              top: false,
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: FilledButton(
                  onPressed: state.isAnswered && !state.isPaused
                      ? notifier.next
                      : null,
                  child: Text(
                    state.isLast
                        ? LocaleKeys.quiz_finish.tr()
                        : LocaleKeys.quiz_next.tr(),
                  ),
                ),
              ),
            ),
            const AdBanner(),
          ],
        ),
      ),
    );
  }
}

class _PausedView extends StatelessWidget {
  const _PausedView({required this.onResume});

  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pause_circle_outline, size: 64),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.quiz_paused.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onResume,
              child: Text(LocaleKeys.quiz_resume.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
