import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../../core/widgets/error_retry_view.dart';
import '../../../../core/widgets/menu_card.dart';
import '../../../../data/session_providers.dart';
import '../../../../data/topic_catalog.dart';
import '../../../quiz/presentation/view_models/quiz_state.dart';

class TopicsPage extends ConsumerWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bank = ref.watch(stateBankProvider);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.topics_title.tr()),
            Text(
              LocaleKeys.topics_subtitle.tr(),
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
        data: (b) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: b.topics.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final topic = TopicCatalog.of(b.topics[index]);
            final count = b.byTopic(topic.id).length;
            return MenuCard(
              leading: topic.emoji,
              title: topic.title,
              trailing: Text(
                '$count',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              onTap: count == 0
                  ? null
                  : () => context.push(
                      AppRoutes.quiz(QuizMode.practice, topic: topic.id),
                    ),
            );
          },
        ),
      ),
      bottomNavigationBar: const AdBanner(),
    );
  }
}
