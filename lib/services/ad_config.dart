import 'dart:io' show Platform;

/// Google's public test ad units are the defaults. Release builds pass the
/// real units with `--dart-define=ADMOB_BANNER=...` etc. The AdMob *app* ID
/// lives in AndroidManifest.xml / Info.plist and must be swapped there too.
abstract class AdConfig {
  static String get banner => _pick(
    const String.fromEnvironment('ADMOB_BANNER'),
    android: 'ca-app-pub-3940256099942544/6300978111',
    ios: 'ca-app-pub-3940256099942544/2934735716',
  );

  static String get interstitial => _pick(
    const String.fromEnvironment('ADMOB_INTERSTITIAL'),
    android: 'ca-app-pub-3940256099942544/1033173712',
    ios: 'ca-app-pub-3940256099942544/4411468910',
  );

  static String get rewarded => _pick(
    const String.fromEnvironment('ADMOB_REWARDED'),
    android: 'ca-app-pub-3940256099942544/5224354917',
    ios: 'ca-app-pub-3940256099942544/1712485313',
  );

  /// Interstitials show at most once per this many finished quizzes...
  static const interstitialEveryQuizzes = 2;

  /// ...and never sooner than this after the previous one.
  static const interstitialCooldown = Duration(minutes: 3);

  static String _pick(
    String override, {
    required String android,
    required String ios,
  }) {
    if (override.isNotEmpty) return override;
    return Platform.isIOS ? ios : android;
  }
}
