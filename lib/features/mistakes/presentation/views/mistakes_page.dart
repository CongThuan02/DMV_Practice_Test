import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_retry_view.dart';
import '../../../../data/models/state_bank.dart';
import '../../../../data/session_providers.dart';
import '../../../quiz/presentation/view_models/quiz_state.dart';

class MistakesPage extends ConsumerWidget {
  const MistakesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bank = ref.watch(stateBankProvider);
    return bank.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorRetryView(onRetry: () => ref.invalidate(stateBankProvider)),
      ),
      data: (b) => _MistakesView(bank: b),
    );
  }
}

class _MistakesView extends ConsumerWidget {
  const _MistakesView({required this.bank});

  final StateBank bank;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mistakes = ref.watch(progressProvider(bank.code)).mistakes;
    final entries = [
      for (final q in bank.questions)
        if (mistakes[q.id] case final entry?)
          (question: q, missed: entry.missed),
    ]..sort((a, b) => b.missed.compareTo(a.missed));
    final palette = AppPalette.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.home_review_mistakes.tr()),
            Text(
              LocaleKeys.mistakes_count.plural(entries.length),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: entries.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  LocaleKeys.mistakes_empty.tr(),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: entries.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    entry.question.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: palette.badBackground,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      LocaleKeys.mistakes_missed.tr(args: ['${entry.missed}']),
                      style: TextStyle(color: palette.bad, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: entries.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: () =>
                      context.push(AppRoutes.quiz(QuizMode.mistakes)),
                  child: Text(
                    LocaleKeys.mistakes_practice.tr(
                      args: ['${entries.length}'],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
