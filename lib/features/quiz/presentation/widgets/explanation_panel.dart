import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/question.dart';
import '../../../../data/session_providers.dart';
import '../../../../services/ad_service.dart';

/// Correct/incorrect verdict plus the explanation. Free users with ads
/// available unlock each explanation with a rewarded ad.
class ExplanationPanel extends ConsumerStatefulWidget {
  const ExplanationPanel({
    super.key,
    required this.question,
    required this.selected,
    required this.unlocked,
    required this.onUnlocked,
  });

  final Question question;
  final int selected;
  final bool unlocked;
  final VoidCallback onUnlocked;

  @override
  ConsumerState<ExplanationPanel> createState() => _ExplanationPanelState();
}

class _ExplanationPanelState extends ConsumerState<ExplanationPanel> {
  bool _loadingAd = false;

  Future<void> _watchAd() async {
    setState(() => _loadingAd = true);
    final result = await ref.read(adServiceProvider).showRewarded();
    if (!mounted) return;
    setState(() => _loadingAd = false);
    if (result != RewardResult.dismissed) widget.onUnlocked();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final textTheme = Theme.of(context).textTheme;
    final correct = widget.selected == widget.question.answer;
    final canSee =
        widget.unlocked ||
        ref.watch(proStatusProvider) ||
        !ref.watch(showAdsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          correct
              ? LocaleKeys.quiz_correct.tr()
              : LocaleKeys.quiz_incorrect.tr(),
          style: textTheme.titleSmall?.copyWith(
            color: correct ? palette.ok : palette.bad,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        if (canSee)
          ExplanationText(question: widget.question)
        else ...[
          OutlinedButton.icon(
            onPressed: _loadingAd ? null : _watchAd,
            icon: _loadingAd
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.play_circle_outline),
            label: Text(LocaleKeys.quiz_watch_ad.tr()),
          ),
          TextButton(
            onPressed: () => context.push(AppRoutes.pro),
            child: Text(LocaleKeys.quiz_go_pro.tr()),
          ),
        ],
      ],
    );
  }
}

class ExplanationText extends StatelessWidget {
  const ExplanationText({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: scheme.primary, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.explain, style: textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
            LocaleKeys.quiz_source.tr(args: [question.source]),
            style: textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
