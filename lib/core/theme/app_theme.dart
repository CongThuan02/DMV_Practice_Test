import 'package:flutter/material.dart';

/// Colors from the UI mockup (`DMV Practice Test – UI mockup.html`).
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.ok,
    required this.okBackground,
    required this.bad,
    required this.badBackground,
    required this.adBackground,
    required this.adForeground,
  });

  static const light = AppPalette(
    ok: Color(0xFF16A34A),
    okBackground: Color(0xFFDCFCE7),
    bad: Color(0xFFDC2626),
    badBackground: Color(0xFFFEE2E2),
    adBackground: Color(0xFFFEF3C7),
    adForeground: Color(0xFF92400E),
  );

  static const dark = AppPalette(
    ok: Color(0xFF22C55E),
    okBackground: Color(0xFF14532D),
    bad: Color(0xFFF87171),
    badBackground: Color(0xFF7F1D1D),
    adBackground: Color(0xFF422006),
    adForeground: Color(0xFFFCD34D),
  );

  final Color ok;
  final Color okBackground;
  final Color bad;
  final Color badBackground;
  final Color adBackground;
  final Color adForeground;

  static AppPalette of(BuildContext context) =>
      Theme.of(context).extension<AppPalette>()!;

  @override
  AppPalette copyWith({
    Color? ok,
    Color? okBackground,
    Color? bad,
    Color? badBackground,
    Color? adBackground,
    Color? adForeground,
  }) => AppPalette(
    ok: ok ?? this.ok,
    okBackground: okBackground ?? this.okBackground,
    bad: bad ?? this.bad,
    badBackground: badBackground ?? this.badBackground,
    adBackground: adBackground ?? this.adBackground,
    adForeground: adForeground ?? this.adForeground,
  );

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      ok: Color.lerp(ok, other.ok, t)!,
      okBackground: Color.lerp(okBackground, other.okBackground, t)!,
      bad: Color.lerp(bad, other.bad, t)!,
      badBackground: Color.lerp(badBackground, other.badBackground, t)!,
      adBackground: Color.lerp(adBackground, other.adBackground, t)!,
      adForeground: Color.lerp(adForeground, other.adForeground, t)!,
    );
  }
}

abstract class AppTheme {
  static final light = _build(
    brightness: Brightness.light,
    primary: const Color(0xFF2563EB),
    background: const Color(0xFFEEF2F9),
    surface: Colors.white,
    outline: const Color(0xFFE2E8F0),
    palette: AppPalette.light,
  );

  static final dark = _build(
    brightness: Brightness.dark,
    primary: const Color(0xFF60A5FA),
    background: const Color(0xFF0B1220),
    surface: const Color(0xFF162033),
    outline: const Color(0xFF27344D),
    palette: AppPalette.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color background,
    required Color surface,
    required Color outline,
    required AppPalette palette,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
      primary: primary,
      surface: surface,
      outlineVariant: outline,
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: outline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      extensions: [palette],
    );
  }
}
