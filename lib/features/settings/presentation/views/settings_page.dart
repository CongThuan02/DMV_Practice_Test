import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/disclaimer_text.dart';
import '../../../../data/session_providers.dart';
import '../../../../services/consent_service.dart';
import '../../../../services/purchase_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeSettingProvider);
    final privacyRequired =
        ref.watch(privacyOptionsRequiredProvider).value ?? false;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings_title.tr())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(LocaleKeys.settings_theme.tr(), style: textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text(LocaleKeys.settings_theme_system.tr()),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text(LocaleKeys.settings_theme_light.tr()),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text(LocaleKeys.settings_theme_dark.tr()),
              ),
            ],
            selected: {themeMode},
            onSelectionChanged: (s) =>
                ref.read(themeModeSettingProvider.notifier).set(s.first),
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.swap_horiz),
            title: Text(LocaleKeys.home_change_state.tr()),
            onTap: () => context.push(AppRoutes.states),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.restore),
            title: Text(LocaleKeys.pro_restore.tr()),
            onTap: () => ref.read(purchaseServiceProvider).restore(),
          ),
          if (privacyRequired)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(LocaleKeys.settings_privacy.tr()),
              onTap: () =>
                  ref.read(consentServiceProvider).showPrivacyOptions(),
            ),
          const SizedBox(height: 24),
          const DisclaimerText(textAlign: TextAlign.start),
        ],
      ),
    );
  }
}
