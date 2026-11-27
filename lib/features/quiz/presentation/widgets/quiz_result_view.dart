import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/menu_card.dart';
import '../../../../data/session_providers.dart';
import '../../../../services/ad_service.dart';
import '../view_models/quiz_state.dart';
import 'exam_timer.dart';
import 'explanation_panel.dart';
import 'question_card.dart';

class QuizResultView extends ConsumerWidget {
  const QuizResultView({super.key, required this.state, required this.onRetry});

  final QuizState state;
  final VoidCallback onRetry;

  /// The interstitial may only appear when leaving the result screen.
  Future<void> _leave(
    BuildContext context,
    WidgetRef ref,
    VoidCallback go,
  ) async {
    await ref.read(adServiceProvider).maybeShowInterstitial();
    if (context.mounted) go();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = AppPalette.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isMock = state.mode == QuizMode.mock;
    final wrong = state.wrongIndexes;
    final isPro = ref.watch(proStatusProvider);
    final title = switch (state.mode) {
      QuizMode.mock => LocaleKeys.result_title_mock.tr(),
      QuizMode.practice => LocaleKeys.result_title_practice.tr(),
      QuizMode.mistakes => LocaleKeys.result_title_mistakes.tr(),
    };

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _leave(context, ref, () => context.pop());
      },
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              '${state.correctCount}/${state.total}',
              textAlign: TextAlign.center,
              style: textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            if (isMock)
              Text(
                state.passed
                    ? LocaleKeys.result_passed.tr()
                    : LocaleKeys.result_failed.tr(args: ['${state.passMark}']),
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  color: state.passed ? palette.ok : palette.bad,
                  fontWeight: FontWeight.w700,
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                _Stat(
                  value: '${state.scorePercent}%',
                  label: LocaleKeys.result_score.tr(),
                ),
                const SizedBox(width: 8),
                _Stat(
                  value: '${wrong.length}',
                  label: LocaleKeys.result_mistakes.tr(),
                ),
                if (isMock) ...[
                  const SizedBox(width: 8),
                  _Stat(
                    value: formatDuration(state.elapsedBefore),
                    label: LocaleKeys.result_time.tr(),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _leave(context, ref, onRetry),
              child: Text(LocaleKeys.result_try_again.tr()),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () =>
                  _leave(context, ref, () => context.go(AppRoutes.home)),
              child: Text(LocaleKeys.result_back_home.tr()),
            ),
            if (!isPro) ...[
              const SizedBox(height: 16),
              MenuCard(
                leading: '⭐',
                title: LocaleKeys.pro_remove_ads.tr(),
                subtitle: LocaleKeys.pro_one_time.tr(),
                onTap: () => context.push(AppRoutes.pro),
              ),
            ],
            if (wrong.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(LocaleKeys.result_review.tr(), style: textTheme.titleMedium),
              const SizedBox(height: 8),
              for (final i in wrong) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        QuestionCard(
                          question: state.questions[i],
                          selected: state.answers[i],
                          reveal: true,
                          onPick: null,
                        ),
                        const SizedBox(height: 12),
                        ExplanationText(question: state.questions[i]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
