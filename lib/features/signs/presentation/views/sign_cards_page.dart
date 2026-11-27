import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/widgets/asset_svg.dart';
import '../../../../core/widgets/error_retry_view.dart';
import '../../../quiz/presentation/widgets/explanation_panel.dart';
import '../view_models/sign_deck_view_model.dart';

class SignCardsPage extends ConsumerWidget {
  const SignCardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deck = ref.watch(signDeckViewModelProvider);
    final notifier = ref.read(signDeckViewModelProvider.notifier);
    final muted = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.home_road_signs.tr()),
            if (deck.value case final s? when !s.isDone)
              Text(
                LocaleKeys.signs_card_of.tr(
                  args: ['${s.learned + 1}', '${s.total}'],
                ),
                style: muted,
              ),
          ],
        ),
      ),
      body: deck.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => ErrorRetryView(
          onRetry: () => ref.invalidate(signDeckViewModelProvider),
        ),
        data: (s) => s.isDone
            ? _DoneView(onRestart: notifier.restart)
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: notifier.flip,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Card(
                            key: ValueKey('${s.current.id}-${s.flipped}'),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: s.flipped
                                  ? _CardBack(state: s)
                                  : _CardFront(path: s.current.image!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: notifier.stillLearning,
                            child: Text(LocaleKeys.signs_still_learning.tr()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: notifier.gotIt,
                            child: Text(LocaleKeys.signs_got_it.tr()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AssetSvg(path, height: 180),
        const SizedBox(height: 24),
        Text(
          LocaleKeys.signs_tap_to_flip.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          LocaleKeys.signs_tap_hint.tr(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({required this.state});

  final SignDeckState state;

  @override
  Widget build(BuildContext context) {
    final q = state.current;
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: AssetSvg(q.image!, height: 90)),
          const SizedBox(height: 16),
          Text(q.text, style: textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text(
            q.correctOption.label,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ExplanationText(question: q),
        ],
      ),
    );
  }
}

class _DoneView extends StatelessWidget {
  const _DoneView({required this.onRestart});

  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.signs_done.tr(),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRestart,
              child: Text(LocaleKeys.signs_restart.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
