import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'consent_service.g.dart';

/// Google UMP consent: must run before any ad request (required for EU/UK).
class ConsentService {
  Future<void> gatherConsent() {
    final done = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () => ConsentForm.loadAndShowConsentFormIfRequired((_) {
        if (!done.isCompleted) done.complete();
      }),
      (_) {
        if (!done.isCompleted) done.complete();
      },
    );
    return done.future;
  }

  Future<bool> canRequestAds() => ConsentInformation.instance.canRequestAds();

  Future<bool> isPrivacyOptionsRequired() async =>
      await ConsentInformation.instance.getPrivacyOptionsRequirementStatus() ==
      PrivacyOptionsRequirementStatus.required;

  Future<void> showPrivacyOptions() {
    final done = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((_) => done.complete());
    return done.future;
  }
}

@Riverpod(keepAlive: true)
ConsentService consentService(Ref ref) => ConsentService();

@riverpod
Future<bool> privacyOptionsRequired(Ref ref) =>
    ref.watch(consentServiceProvider).isPrivacyOptionsRequired();
