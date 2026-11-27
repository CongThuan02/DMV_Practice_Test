import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_retry_view.dart';
import '../../../../core/widgets/menu_card.dart';
import '../../../../data/models/state_bank.dart';
import '../../../../data/session_providers.dart';
import '../../../quiz/presentation/view_models/quiz_state.dart';

class MockIntroPage extends ConsumerWidget {
  const MockIntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bank = ref.watch(stateBankProvider);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.mock_title.tr()),
            Text(
              LocaleKeys.mock_subtitle.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: bank.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            ErrorRetryView(onRetry: () => ref.invalidate(stateBankProvider)),
        data: (b) => _MockIntroBody(bank: b),
      ),
    );
  }
}

class _MockIntroBody extends ConsumerWidget {
  const _MockIntroBody({required this.bank});

  final StateBank bank;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exam = bank.exam;
    final count = bank.questions.length < exam.questionCount
        ? bank.questions.length
        : exam.questionCount;
    final passMark = exam.passMarkFor(count);
    final recent = ref.watch(progressProvider(bank.code)).exams.take(3);
    final palette = AppPalette.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        MenuCard(
          leading: '❓',
          title: LocaleKeys.mock_questions.plural(count),
          subtitle: count < exam.questionCount
              ? LocaleKeys.mock_shortened.tr(args: ['${exam.questionCount}'])
              : LocaleKeys.mock_same_length.tr(args: [bank.name]),
        ),
        const SizedBox(height: 8),
        MenuCard(
          leading: '🎯',
          title: LocaleKeys.mock_pass_mark.tr(),
          subtitle: LocaleKeys.mock_pass_mark_value.tr(
            args: ['$passMark', '$count'],
          ),
        ),
        const SizedBox(height: 8),
        MenuCard(
          leading: '🤫',
          title: LocaleKeys.mock_no_hints.tr(),
          subtitle: LocaleKeys.mock_no_hints_subtitle.tr(),
        ),
        const SizedBox(height: 8),
        MenuCard(
          leading: '⏱',
          title: LocaleKeys.mock_timer.tr(),
          subtitle: LocaleKeys.mock_timer_subtitle.tr(),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => context.push(AppRoutes.quiz(QuizMode.mock)),
          child: Text(LocaleKeys.mock_start.tr()),
        ),
        if (recent.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text(
            LocaleKeys.mock_recent.tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          for (final record in recent)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('${record.correct}/${record.total}'),
              subtitle: Text(
                DateFormat.yMMMd().add_jm().format(record.takenAt),
              ),
              trailing: Text(
                record.passed
                    ? LocaleKeys.mock_passed_short.tr()
                    : LocaleKeys.mock_failed_short.tr(),
                style: TextStyle(
                  color: record.passed ? palette.ok : palette.bad,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ],
    );
  }
}
