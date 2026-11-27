import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../services/ad_service.dart';
import '../../../../services/consent_service.dart';
import '../../../../services/purchase_service.dart';

part 'startup_view_model.g.dart';

/// Consent first, then ads (UMP requirement). Failures never block the app:
/// it must keep working offline and without ads.
@Riverpod(keepAlive: true)
class StartupViewModel extends _$StartupViewModel {
  static const consentTimeout = Duration(seconds: 10);

  @override
  Future<void> build() async {
    unawaited(_startPurchases());
    try {
      final consent = ref.read(consentServiceProvider);
      await consent.gatherConsent().timeout(consentTimeout);
      if (await consent.canRequestAds()) {
        ref.read(adsReadyProvider.notifier).markReady();
        await ref.read(adServiceProvider).initialize();
      }
    } catch (error) {
      debugPrint('Ads disabled for this session: $error');
    }
  }

  Future<void> _startPurchases() async {
    try {
      await ref.read(purchaseServiceProvider).start();
    } catch (error) {
      debugPrint('Store unavailable: $error');
    }
  }
}
