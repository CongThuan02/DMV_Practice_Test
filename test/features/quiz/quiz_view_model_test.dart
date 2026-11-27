import 'package:dmv_practice_test/data/session_providers.dart';
import 'package:dmv_practice_test/features/quiz/presentation/view_models/quiz_state.dart';
import 'package:dmv_practice_test/features/quiz/presentation/view_models/quiz_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers.dart';

void main() {
  final bank = bankFrom(
    bankJson(
      [
        for (var i = 0; i < 6; i++)
          questionJson('s$i', answer: i % 3, q: 'Sign $i'),
        for (var i = 0; i < 2; i++)
          questionJson('v$i', topic: 'speed', answer: 1, q: 'Speed $i'),
      ],
      examQuestions: 4,
      passMark: 3,
    ),
  );

  late ProviderContainer container;
  var now = DateTime(2026, 1, 1, 10);

  Future<QuizViewModel> start(QuizMode mode, {String? topic}) async {
    final provider = quizViewModelProvider(mode, topic);
    container.listen(provider, (_, _) {});
    await container.read(provider.future);
    return container.read(provider.notifier);
  }

  QuizState stateOf(QuizMode mode, {String? topic}) =>
      container.read(quizViewModelProvider(mode, topic)).requireValue;

  int wrong(QuizState s) => (s.current.answer + 1) % s.current.options.length;

  setUp(() async {
    now = DateTime(2026, 1, 1, 10);
    container = await makeContainer(bank: bank, clock: () => now);
    addTearDown(container.dispose);
  });

  test('practice by topic only uses that topic', () async {
    await start(QuizMode.practice, topic: 'speed');
    final s = stateOf(QuizMode.practice, topic: 'speed');
    expect(s.total, 2);
    expect(s.questions.every((q) => q.topic == 'speed'), isTrue);
  });

  test('practice locks the first pick and records mistakes', () async {
    final vm = await start(QuizMode.practice, topic: 'speed');
    final first = stateOf(QuizMode.practice, topic: 'speed');
    await vm.answer(wrong(first));
    await vm.answer(first.current.answer);

    final s = stateOf(QuizMode.practice, topic: 'speed');
    expect(s.currentAnswer, wrong(first));
    final progress = container.read(progressProvider('CA'));
    expect(progress.mistakes[first.current.id]!.missed, 1);
  });

  test('mock exam allows changing the pick and scores pass/fail', () async {
    final vm = await start(QuizMode.mock);
    expect(stateOf(QuizMode.mock).total, 4);

    for (var i = 0; i < 4; i++) {
      final s = stateOf(QuizMode.mock);
      await vm.answer(s.current.answer);
      if (i == 3) await vm.answer(wrong(s));
      now = now.add(const Duration(seconds: 30));
      await vm.next();
    }

    final s = stateOf(QuizMode.mock);
    expect(s.finished, isTrue);
    expect(s.correctCount, 3);
    expect(s.passed, isTrue);
    expect(s.wrongIndexes, [3]);
    expect(s.elapsedBefore, const Duration(minutes: 2));

    final exam = container.read(progressProvider('CA')).exams.single;
    expect((exam.correct, exam.total, exam.passed), (3, 4, true));
    expect(exam.durationSeconds, 120);
  });

  test('mock exam below the pass mark fails', () async {
    final vm = await start(QuizMode.mock);
    for (var i = 0; i < 4; i++) {
      final s = stateOf(QuizMode.mock);
      await vm.answer(i < 2 ? s.current.answer : wrong(s));
      await vm.next();
    }
    expect(stateOf(QuizMode.mock).passed, isFalse);
  });

  test('paused time is not counted and answers are blocked', () async {
    final vm = await start(QuizMode.mock);
    now = now.add(const Duration(seconds: 10));
    vm.pause();
    now = now.add(const Duration(minutes: 5));
    await vm.answer(0);
    expect(stateOf(QuizMode.mock).isAnswered, isFalse);

    vm.resume();
    now = now.add(const Duration(seconds: 5));
    expect(stateOf(QuizMode.mock).elapsedAt(now), const Duration(seconds: 15));
  });

  test('review mode only contains questions answered wrong', () async {
    final vm = await start(QuizMode.practice, topic: 'speed');
    final s = stateOf(QuizMode.practice, topic: 'speed');
    await vm.answer(wrong(s));

    await start(QuizMode.mistakes);
    final review = stateOf(QuizMode.mistakes);
    expect(review.questions.map((q) => q.id), [s.current.id]);
  });

  test('review mode with no mistakes reports an empty quiz', () async {
    final provider = quizViewModelProvider(QuizMode.mistakes, null);
    container.listen(provider, (_, _) {});
    await expectLater(
      container.read(provider.future),
      throwsA(isA<EmptyQuizException>()),
    );
  });
}
