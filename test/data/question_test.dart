import 'dart:math';

import 'package:dmv_practice_test/data/models/question.dart';
import 'package:dmv_practice_test/data/models/state_bank.dart';
import 'package:dmv_practice_test/data/models/state_bank_dto.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  test('parses all option shapes and question types', () {
    final bank = bankFrom(
      bankJson([
        questionJson('t1'),
        questionJson(
          'c1',
          type: 'image_options',
          answer: 1,
          options: [
            {'label': 'Yellow', 'color': '#f9a825'},
            {'label': 'Red', 'color': '#c62828'},
          ],
        ),
        questionJson(
          'i1',
          type: 'image_options',
          options: [
            {'label': 'Stop', 'image': 'assets/images/signs/stop.svg'},
            'Yield',
          ],
        ),
        questionJson('n1', type: 'number_fill', q: 'Signal ___ feet.'),
      ]),
    );

    expect(bank.questions.map((q) => q.type), [
      QuestionType.text,
      QuestionType.imageOptions,
      QuestionType.imageOptions,
      QuestionType.numberFill,
    ]);
    final red = bank.questions[1].correctOption;
    expect(red.label, 'Red');
    expect(red.color, const Color(0xFFC62828));
    expect(
      bank.questions[2].options.first.image,
      'assets/images/signs/stop.svg',
    );
    expect(bank.questions[2].options.last.label, 'Yield');
  });

  test('release builds drop questions that still need verification', () {
    final json = bankJson([
      questionJson('ok'),
      questionJson('pending', verify: true),
    ]);
    final release = StateBankDto.fromJson(
      json,
    ).toDomain(includeUnverified: false);
    expect(release.questions.map((q) => q.id), ['ok']);
  });

  test('shuffling options keeps the same correct answer', () {
    const q = Question(
      id: 'q',
      type: QuestionType.text,
      topic: 'signs',
      difficulty: 1,
      text: 'Pick C',
      options: [
        AnswerOption(label: 'A'),
        AnswerOption(label: 'B'),
        AnswerOption(label: 'C'),
        AnswerOption(label: 'D'),
      ],
      answer: 2,
      explain: '',
      source: '',
    );
    for (var seed = 0; seed < 20; seed++) {
      final shuffled = q.withShuffledOptions(Random(seed));
      expect(shuffled.correctOption.label, 'C');
      expect(shuffled.options.map((o) => o.label).toSet(), {
        'A',
        'B',
        'C',
        'D',
      });
    }
  });

  test('number-fill options are sorted numerically, answer follows', () {
    const q = Question(
      id: 'n',
      type: QuestionType.numberFill,
      topic: 'speed',
      difficulty: 1,
      text: '___ feet',
      options: [
        AnswerOption(label: '100'),
        AnswerOption(label: '25'),
        AnswerOption(label: '50'),
      ],
      answer: 0,
      explain: '',
      source: '',
    );
    final sorted = q.withShuffledOptions(Random(1));
    expect(sorted.options.map((o) => o.label), ['25', '50', '100']);
    expect(sorted.correctOption.label, '100');
  });

  test('pass mark scales down when the bank is smaller than the exam', () {
    const exam = ExamConfig(questionCount: 36, passMark: 30);
    expect(exam.passMarkFor(36), 30);
    expect(exam.passMarkFor(40), 30);
    expect(exam.passMarkFor(18), 15);
    expect(exam.passMarkFor(10), 9);
  });
}
