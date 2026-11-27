import 'package:flutter/material.dart';

abstract class AppTheme {
  static const _seed = Color(0xFF1565C0);

  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seed),
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ),
  );
}
