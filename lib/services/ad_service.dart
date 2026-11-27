import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/progress_store.dart';
import '../data/session_providers.dart';
import 'ad_config.dart';

part 'ad_service.g.dart';

enum RewardResult { earned, dismissed, unavailable }

/// Owns the full-screen ad formats. Banners are created per screen by
/// `AdBanner`. Ads are off until [AdsReady] is set after consent.
class AdService {
  AdService(this._ref);

  final Ref _ref;
  InterstitialAd? _interstitial;
  RewardedAd? _rewarded;
  int _quizzesSinceInterstitial = 0;

  bool get _enabled =>
      _ref.read(adsReadyProvider) && !_ref.read(proStatusProvider);

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    _loadInterstitial();
    _loadRewarded();
  }

  void onQuizFinished() => _quizzesSinceInterstitial++;

  /// Called when the user leaves a result screen; never during a quiz.
  Future<void> maybeShowInterstitial() async {
    final ad = _interstitial;
    if (!_enabled || ad == null) return;
    if (_quizzesSinceInterstitial < AdConfig.interstitialEveryQuizzes) return;

    final store = _ref.read(progressStoreProvider);
    final now = _ref.read(clockProvider)();
    final last = store.lastInterstitialAt;
    if (last != null && now.difference(last) < AdConfig.interstitialCooldown) {
      return;
    }

    final closed = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        closed.complete();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        closed.complete();
      },
    );
    _interstitial = null;
    _quizzesSinceInterstitial = 0;
    await store.setLastInterstitialAt(now);
    await ad.show();
    await closed.future;
    _loadInterstitial();
  }

  /// `unavailable` (offline, no fill) should not block the user.
  Future<RewardResult> showRewarded() async {
    final ad = _rewarded;
    if (!_enabled || ad == null) return RewardResult.unavailable;

    var earned = false;
    final closed = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        closed.complete();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        closed.complete();
      },
    );
    _rewarded = null;
    await ad.show(onUserEarnedReward: (_, _) => earned = true);
    await closed.future;
    _loadRewarded();
    return earned ? RewardResult.earned : RewardResult.dismissed;
  }

  void _loadInterstitial() {
    if (!_enabled) return;
    InterstitialAd.load(
      adUnitId: AdConfig.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitial = ad,
        onAdFailedToLoad: (_) => _interstitial = null,
      ),
    );
  }

  void _loadRewarded() {
    if (!_enabled) return;
    RewardedAd.load(
      adUnitId: AdConfig.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewarded = ad,
        onAdFailedToLoad: (_) => _rewarded = null,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
class AdsReady extends _$AdsReady {
  @override
  bool build() => false;

  void markReady() => state = true;
}

@Riverpod(keepAlive: true)
AdService adService(Ref ref) => AdService(ref);

@riverpod
bool showAds(Ref ref) =>
    ref.watch(adsReadyProvider) && !ref.watch(proStatusProvider);
