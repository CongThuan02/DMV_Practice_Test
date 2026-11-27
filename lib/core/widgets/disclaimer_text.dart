import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../localization/locale_keys.g.dart';

class DisclaimerText extends StatelessWidget {
  const DisclaimerText({super.key, this.textAlign = TextAlign.center});

  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${LocaleKeys.common_not_affiliated.tr()} '
      '${LocaleKeys.common_reference_only.tr()}',
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
