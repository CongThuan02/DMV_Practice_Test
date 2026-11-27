import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/disclaimer_text.dart';
import '../../../../core/widgets/error_retry_view.dart';
import '../../../../core/widgets/menu_card.dart';
import '../../../../data/models/question.dart';
import '../../../../data/models/state_bank.dart';
import '../../../../data/session_providers.dart';
import '../../../../data/topic_catalog.dart';
import '../../../quiz/presentation/view_models/quiz_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bank = ref.watch(stateBankProvider);
    final isPro = ref.watch(proStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: bank.maybeWhen(
          data: (b) => _Title(name: b.name),
          orElse: () => const SizedBox.shrink(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: LocaleKeys.home_change_state.tr(),
            onPressed: () => context.push(AppRoutes.states),
          ),
          if (!isPro)
            IconButton(
              icon: const Icon(Icons.star_outline),
              tooltip: LocaleKeys.pro_title.tr(),
              onPressed: () => context.push(AppRoutes.pro),
            ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: LocaleKeys.settings_title.tr(),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: bank.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            ErrorRetryView(onRetry: () => ref.invalidate(stateBankProvider)),
        data: (b) => _HomeBody(bank: b),
      ),
      bottomNavigationBar: const AdBanner(),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
        Text(
          LocaleKeys.home_subtitle.tr(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.bank});

  final StateBank bank;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider(bank.code));
    final ids = {for (final q in bank.questions) q.id};
    final seen = progress.seen.where(ids.contains).length;
    final mistakes = progress.mistakes.keys.where(ids.contains).length;
    final total = bank.questions.length;
    final signCount = bank.byType(QuestionType.sign).length;
    final topicPreview = bank.topics
        .take(4)
        .map((t) => TopicCatalog.of(t).title)
        .join(', ');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.home_progress.tr(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.home_seen.tr(args: ['$seen', '$total']),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: total == 0 ? 0 : seen / total,
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        MenuCard(
          leading: '📝',
          title: LocaleKeys.home_mock_exam.tr(),
          subtitle: LocaleKeys.home_mock_exam_subtitle.tr(
            args: ['${bank.exam.questionCount}'],
          ),
          onTap: () => context.push(AppRoutes.mockIntro),
        ),
        const SizedBox(height: 8),
        MenuCard(
          leading: '📚',
          title: LocaleKeys.home_practice_topic.tr(),
          subtitle: topicPreview,
          onTap: () => context.push(AppRoutes.topics),
        ),
        const SizedBox(height: 8),
        MenuCard(
          leading: '🚧',
          title: LocaleKeys.home_road_signs.tr(),
          subtitle: LocaleKeys.home_road_signs_subtitle.tr(
            args: ['$signCount'],
          ),
          onTap: signCount == 0 ? null : () => context.push(AppRoutes.signs),
        ),
        const SizedBox(height: 8),
        MenuCard(
          leading: '❗',
          title: LocaleKeys.home_review_mistakes.tr(),
          subtitle: LocaleKeys.mistakes_count.plural(mistakes),
          onTap: () => context.push(AppRoutes.mistakes),
        ),
        const SizedBox(height: 8),
        MenuCard(
          leading: '🎲',
          title: LocaleKeys.home_practice_all.tr(),
          subtitle: LocaleKeys.home_practice_all_subtitle.plural(total),
          onTap: () => context.push(AppRoutes.quiz(QuizMode.practice)),
        ),
        const SizedBox(height: 24),
        const DisclaimerText(),
      ],
    );
  }
}
