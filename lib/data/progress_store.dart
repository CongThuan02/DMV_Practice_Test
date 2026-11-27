import 'dart:convert';

import 'package:flutter/material.dart' show ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/storage/shared_preferences_provider.dart';
import 'models/progress.dart';

part 'progress_store.g.dart';

class ProgressStore {
  ProgressStore(this._prefs);

  static const maxExamRecords = 20;

  static const _selectedStateKey = 'selectedState';
  static const _proUnlockedKey = 'proUnlocked';
  static const _lastInterstitialKey = 'lastInterstitialAt';
  static const _themeModeKey = 'themeMode';
  static String _seenKey(String state) => 'seen:$state';
  static String _wrongKey(String state) => 'wrong:$state';
  static String _historyKey(String state) => 'history:$state';

  final SharedPreferences _prefs;

  String? get selectedState => _prefs.getString(_selectedStateKey);
  Future<void> setSelectedState(String code) =>
      _prefs.setString(_selectedStateKey, code);

  bool get proUnlocked => _prefs.getBool(_proUnlockedKey) ?? false;
  Future<void> setProUnlocked(bool value) =>
      _prefs.setBool(_proUnlockedKey, value);

  DateTime? get lastInterstitialAt {
    final ms = _prefs.getInt(_lastInterstitialKey);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  Future<void> setLastInterstitialAt(DateTime value) =>
      _prefs.setInt(_lastInterstitialKey, value.millisecondsSinceEpoch);

  ThemeMode get themeMode {
    final name = _prefs.getString(_themeModeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(_themeModeKey, mode.name);

  StateProgress loadProgress(String state) {
    final wrongRaw = _prefs.getString(_wrongKey(state));
    final wrong = wrongRaw == null
        ? const <String, dynamic>{}
        : jsonDecode(wrongRaw) as Map<String, dynamic>;
    return StateProgress(
      seen: (_prefs.getStringList(_seenKey(state)) ?? const []).toSet(),
      mistakes: {
        for (final e in wrong.entries)
          e.key: MistakeEntry.fromJson(e.value as Map<String, dynamic>),
      },
      exams: [
        for (final raw in _prefs.getStringList(_historyKey(state)) ?? const [])
          ExamRecord.fromJson(jsonDecode(raw) as Map<String, dynamic>),
      ],
    );
  }

  Future<void> saveProgress(String state, StateProgress progress) async {
    await _prefs.setStringList(_seenKey(state), progress.seen.toList());
    await _prefs.setString(
      _wrongKey(state),
      jsonEncode({
        for (final e in progress.mistakes.entries) e.key: e.value.toJson(),
      }),
    );
    await _prefs.setStringList(_historyKey(state), [
      for (final record in progress.exams.take(maxExamRecords))
        jsonEncode(record.toJson()),
    ]);
  }
}

@Riverpod(keepAlive: true)
ProgressStore progressStore(Ref ref) =>
    ProgressStore(ref.watch(sharedPreferencesProvider));
