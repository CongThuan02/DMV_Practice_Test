import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/question.dart';

part 'quiz_state.freezed.dart';

enum QuizMode { practice, mock, mistakes }

class EmptyQuizException implements Exception {
  const EmptyQuizException();
}

@freezed
abstract class QuizState with _$QuizState {
  const QuizState._();

  const factory QuizState({
    required QuizMode mode,
    required String stateCode,
    String? topic,
    required List<Question> questions,
    required int passMark,
    @Default(0) int index,
    @Default(<int, int>{}) Map<int, int> answers,
    @Default(<int>{}) Set<int> unlockedExplanations,
    @Default(false) bool finished,
    @Default(Duration.zero) Duration elapsedBefore,
    DateTime? runningSince,
  }) = _QuizState;

  Question get current => questions[index];
  int? get currentAnswer => answers[index];
  bool get isAnswered => currentAnswer != null;
  bool get isLast => index == questions.length - 1;
  int get total => questions.length;

  /// Mock exams hide correctness and explanations until the end.
  bool get revealsAnswers => mode != QuizMode.mock;
  bool get isTimed => mode == QuizMode.mock;
  bool get isPaused => isTimed && !finished && runningSince == null;

  int get correctCount =>
      answers.entries.where((e) => questions[e.key].answer == e.value).length;

  bool get passed => correctCount >= passMark;
  int get scorePercent => total == 0 ? 0 : (correctCount * 100 / total).round();

  List<int> get wrongIndexes => [
    for (var i = 0; i < total; i++)
      if (answers[i] != questions[i].answer) i,
  ];

  Duration elapsedAt(DateTime now) =>
      elapsedBefore +
      (runningSince == null ? Duration.zero : now.difference(runningSince!));
}
