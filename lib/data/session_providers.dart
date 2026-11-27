import 'dart:math';

import 'package:flutter/material.dart' show ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'models/progress.dart';
import 'models/state_bank.dart';
import 'progress_store.dart';
import 'question_repository.dart';

part 'session_providers.g.dart';

@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;

@Riverpod(keepAlive: true)
Random random(Ref ref) => Random();

@Riverpod(keepAlive: true)
class SelectedState extends _$SelectedState {
  @override
  String? build() => ref.watch(progressStoreProvider).selectedState;

  Future<void> select(String code) {
    state = code;
    return ref.read(progressStoreProvider).setSelectedState(code);
  }
}

@Riverpod(keepAlive: true)
Future<Set<String>> availableStates(Ref ref) =>
    ref.watch(questionRepositoryProvider).availableStates();

@Riverpod(keepAlive: true)
Future<StateBank> stateBank(Ref ref) {
  final code = ref.watch(selectedStateProvider);
  if (code == null) throw StateError('No state selected');
  return ref.watch(questionRepositoryProvider).load(code);
}

@Riverpod(keepAlive: true)
class Progress extends _$Progress {
  @override
  StateProgress build(String stateCode) =>
      ref.watch(progressStoreProvider).loadProgress(stateCode);

  Future<void> recordAnswer(String questionId, {required bool correct}) =>
      _save(state.recordAnswer(questionId, correct: correct));

  Future<void> addExam(ExamRecord record) =>
      _save(state.copyWith(exams: [record, ...state.exams]));

  Future<void> _save(StateProgress updated) {
    state = updated;
    return ref.read(progressStoreProvider).saveProgress(stateCode, updated);
  }
}

@Riverpod(keepAlive: true)
class ProStatus extends _$ProStatus {
  @override
  bool build() => ref.watch(progressStoreProvider).proUnlocked;

  Future<void> unlock() async {
    if (state) return;
    state = true;
    await ref.read(progressStoreProvider).setProUnlocked(true);
  }
}

@Riverpod(keepAlive: true)
class ThemeModeSetting extends _$ThemeModeSetting {
  @override
  ThemeMode build() => ref.watch(progressStoreProvider).themeMode;

  Future<void> set(ThemeMode mode) {
    state = mode;
    return ref.read(progressStoreProvider).setThemeMode(mode);
  }
}
