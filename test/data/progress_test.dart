import 'package:dmv_practice_test/data/models/progress.dart';
import 'package:dmv_practice_test/data/progress_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('mistake rule', () {
    test('a wrong answer adds the question and counts misses', () {
      final p = const StateProgress()
          .recordAnswer('q1', correct: false)
          .recordAnswer('q1', correct: false);
      expect(p.mistakes['q1']!.missed, 2);
      expect(p.seen, {'q1'});
    });

    test('two correct answers in a row clear the mistake', () {
      var p = const StateProgress().recordAnswer('q1', correct: false);
      p = p.recordAnswer('q1', correct: true);
      expect(p.mistakes, contains('q1'));
      p = p.recordAnswer('q1', correct: true);
      expect(p.mistakes, isNot(contains('q1')));
    });

    test('a wrong answer resets the correct streak', () {
      final p = const StateProgress()
          .recordAnswer('q1', correct: false)
          .recordAnswer('q1', correct: true)
          .recordAnswer('q1', correct: false)
          .recordAnswer('q1', correct: true);
      expect(p.mistakes['q1']!.missed, 2);
      expect(p.mistakes['q1']!.correctStreak, 1);
    });

    test('correct answers on new questions do not create mistakes', () {
      final p = const StateProgress().recordAnswer('q1', correct: true);
      expect(p.mistakes, isEmpty);
      expect(p.seen, {'q1'});
    });
  });

  test('progress is stored per state and survives a reload', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final store = ProgressStore(prefs);
    final progress = const StateProgress()
        .recordAnswer('ca-1', correct: false)
        .copyWith(
          exams: [
            ExamRecord(
              correct: 30,
              total: 36,
              passed: true,
              takenAt: DateTime.utc(2026, 11, 27),
              durationSeconds: 900,
            ),
          ],
        );
    await store.saveProgress('CA', progress);

    final reloaded = ProgressStore(prefs).loadProgress('CA');
    expect(reloaded.seen, {'ca-1'});
    expect(reloaded.mistakes['ca-1']!.missed, 1);
    expect(reloaded.exams.single.correct, 30);
    expect(reloaded.exams.single.takenAt, DateTime.utc(2026, 11, 27));
    expect(ProgressStore(prefs).loadProgress('TX').seen, isEmpty);
  });
}
