import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../localization/locale_keys.g.dart';

class ErrorRetryView extends StatelessWidget {
  const ErrorRetryView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.common_error_generic.tr(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: Text(LocaleKeys.common_retry.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
