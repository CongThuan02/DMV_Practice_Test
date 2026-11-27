import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/progress.dart';
import '../../../../data/models/question.dart';
import '../../../../data/session_providers.dart';
import '../../../../services/ad_service.dart';
import 'quiz_state.dart';

part 'quiz_view_model.g.dart';

Duration? _retryUnlessEmpty(int retryCount, Object error) =>
    error is EmptyQuizException || retryCount >= 3
    ? null
    : Duration(milliseconds: 200 * (retryCount + 1));

@Riverpod(retry: _retryUnlessEmpty)
class QuizViewModel extends _$QuizViewModel {
  @override
  Future<QuizState> build(QuizMode mode, String? topic) async {
    final bank = await ref.watch(stateBankProvider.future);
    final random = ref.read(randomProvider);
    final progress = ref.read(progressProvider(bank.code));

    final pool = switch (mode) {
      QuizMode.practice => [
        ...(topic == null ? bank.questions : bank.byTopic(topic)),
      ],
      QuizMode.mock => [...bank.questions],
      QuizMode.mistakes => [
        for (final q in bank.questions)
          if (progress.mistakes.containsKey(q.id)) q,
      ],
    }..shuffle(random);

    final selected = mode == QuizMode.mock
        ? pool.take(bank.exam.questionCount).toList()
        : pool;
    if (selected.isEmpty) throw const EmptyQuizException();

    return QuizState(
      mode: mode,
      stateCode: bank.code,
      topic: topic,
      questions: [for (final q in selected) q.withShuffledOptions(random)],
      passMark: bank.exam.passMarkFor(selected.length),
      runningSince: mode == QuizMode.mock ? _now() : null,
    );
  }

  DateTime _now() => ref.read(clockProvider)();

  ProgressProvider get _progress =>
      progressProvider(state.requireValue.stateCode);

  /// Practice locks the first pick and records it immediately. Mock exams let
  /// the user change the pick until moving on.
  Future<void> answer(int option) async {
    final current = state.value;
    if (current == null || current.finished || current.isPaused) return;
    if (current.revealsAnswers && current.isAnswered) return;

    state = AsyncData(
      current.copyWith(answers: {...current.answers, current.index: option}),
    );
    if (current.revealsAnswers) {
      await _record(current.current, option);
    }
  }

  Future<void> next() async {
    final current = state.value;
    if (current == null || current.finished || !current.isAnswered) return;
    if (!current.revealsAnswers) {
      await _record(current.current, current.currentAnswer!);
    }
    if (!ref.mounted) return;
    if (!current.isLast) {
      state = AsyncData(current.copyWith(index: current.index + 1));
      return;
    }
    await _finish(current);
  }

  void pause() {
    final current = state.value;
    if (current == null || !current.isTimed || current.isPaused) return;
    if (current.finished) return;
    state = AsyncData(
      current.copyWith(
        elapsedBefore: current.elapsedAt(_now()),
        runningSince: null,
      ),
    );
  }

  void resume() {
    final current = state.value;
    if (current == null || !current.isPaused) return;
    state = AsyncData(current.copyWith(runningSince: _now()));
  }

  void unlockExplanation(int index) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        unlockedExplanations: {...current.unlockedExplanations, index},
      ),
    );
  }

  void restart() => ref.invalidateSelf();

  Future<void> _record(Question question, int option) => ref
      .read(_progress.notifier)
      .recordAnswer(question.id, correct: option == question.answer);

  Future<void> _finish(QuizState current) async {
    final now = _now();
    final finished = current.copyWith(
      finished: true,
      elapsedBefore: current.elapsedAt(now),
      runningSince: null,
    );
    state = AsyncData(finished);
    ref.read(adServiceProvider).onQuizFinished();
    if (current.mode == QuizMode.mock) {
      await ref
          .read(_progress.notifier)
          .addExam(
            ExamRecord(
              correct: finished.correctCount,
              total: finished.total,
              passed: finished.passed,
              takenAt: now,
              durationSeconds: finished.elapsedBefore.inSeconds,
            ),
          );
    }
  }
}
