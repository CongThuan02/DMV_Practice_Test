import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

enum OptionStatus { idle, selected, correct, wrong, dimmed }

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.label,
    required this.status,
    required this.onTap,
    this.letter,
    this.leading,
    this.centered = false,
  });

  final String label;
  final String? letter;
  final Widget? leading;
  final OptionStatus status;
  final VoidCallback? onTap;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final scheme = Theme.of(context).colorScheme;
    final (background, border) = switch (status) {
      OptionStatus.correct => (palette.okBackground, palette.ok),
      OptionStatus.wrong => (palette.badBackground, palette.bad),
      OptionStatus.selected => (
        scheme.primary.withValues(alpha: 0.12),
        scheme.primary,
      ),
      OptionStatus.idle ||
      OptionStatus.dimmed => (Colors.transparent, scheme.outlineVariant),
    };
    final emphasized =
        status != OptionStatus.idle && status != OptionStatus.dimmed;

    final text = Text(
      letter == null ? label : '$letter. $label',
      textAlign: centered ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        fontWeight: emphasized ? FontWeight.w600 : FontWeight.normal,
      ),
    );

    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: border, width: emphasized ? 1.6 : 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Opacity(
          opacity: status == OptionStatus.dimmed ? 0.6 : 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: centered
                ? Center(child: text)
                : Row(
                    children: [
                      if (leading != null) ...[
                        leading!,
                        const SizedBox(width: 12),
                      ],
                      Expanded(child: text),
                      if (status == OptionStatus.correct)
                        Icon(Icons.check_circle, color: palette.ok, size: 20),
                      if (status == OptionStatus.wrong)
                        Icon(Icons.cancel, color: palette.bad, size: 20),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
