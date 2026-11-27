import 'dart:convert';
import 'dart:io';

import 'package:dmv_practice_test/data/models/state_bank_dto.dart';
import 'package:dmv_practice_test/data/question_validator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  final validator = QuestionValidator(
    assetExists: (path) => File(path).existsSync(),
  );

  group('shipped question banks', () {
    final files = Directory(
      'assets/questions',
    ).listSync().whereType<File>().where((f) => f.path.endsWith('.json'));

    test('at least one state is bundled', () => expect(files, isNotEmpty));

    for (final file in files) {
      test('${file.path} is valid and parses', () {
        final json =
            jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        expect(validator.validate(json), isEmpty);
        final bank = StateBankDto.fromJson(
          json,
        ).toDomain(includeUnverified: true);
        expect(bank.questions, isNotEmpty);
        for (final topic in bank.topics) {
          expect(bank.byTopic(topic), isNotEmpty, reason: topic);
        }
      });
    }
  });

  group('validator catches', () {
    List<String> errorsFor(Map<String, dynamic> question) =>
        validator.validate(bankJson([question]));

    test('an answer outside the options', () {
      expect(errorsFor(questionJson('a', answer: 3)), [contains('answer')]);
    });

    test('a missing source', () {
      expect(errorsFor(questionJson('a')..['source'] = ''), [
        contains('source'),
      ]);
    });

    test('duplicate ids', () {
      expect(
        validator.validate(bankJson([questionJson('a'), questionJson('a')])),
        [contains('duplicate id')],
      );
    });

    test('a sign question without an existing image', () {
      expect(errorsFor(questionJson('a', type: 'sign')), [
        contains('needs an image'),
      ]);
      expect(
        errorsFor(
          questionJson(
            'b',
            type: 'sign',
            image: 'assets/images/signs/nope.svg',
          ),
        ),
        [contains('not found')],
      );
    });

    test('a number_fill without exactly one blank or with non-numbers', () {
      expect(errorsFor(questionJson('a', type: 'number_fill', q: 'No blank')), [
        contains('___'),
        contains('numbers'),
      ]);
    });

    test('a topic not declared by the state', () {
      expect(errorsFor(questionJson('a', topic: 'boats')), [contains('topic')]);
    });
  });
}
