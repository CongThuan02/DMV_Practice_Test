// Builds assets/questions/<state>.json from content/<state>/ and validates it.
//
//   dart run tool/build_question_bank.dart            # all states
//   dart run tool/build_question_bank.dart ca tx      # selected states
//
// content/<state>/header.json holds state, stateName, version, exam, topics.
// Every other *.json in that folder is an array of questions. Exits non-zero
// on any validation error, so it can run in CI.
import 'dart:convert';
import 'dart:io';

import 'package:dmv_practice_test/data/question_validator.dart';

void main(List<String> args) {
  final contentDir = Directory('content');
  final states = args.isNotEmpty
      ? args.map((s) => s.toLowerCase()).toList()
      : contentDir
            .listSync()
            .whereType<Directory>()
            .map((d) => d.uri.pathSegments.where((s) => s.isNotEmpty).last)
            .toList();

  final validator = QuestionValidator(
    assetExists: (path) => File(path).existsSync(),
  );
  var failed = false;

  for (final state in states..sort()) {
    final dir = Directory('content/$state');
    final header =
        jsonDecode(File('${dir.path}/header.json').readAsStringSync())
            as Map<String, dynamic>;
    final parts =
        dir
            .listSync()
            .whereType<File>()
            .where(
              (f) =>
                  f.path.endsWith('.json') && !f.path.endsWith('header.json'),
            )
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));

    final questions = [
      for (final part in parts)
        ...(jsonDecode(part.readAsStringSync()) as List),
    ];
    final bank = {...header, 'questions': questions};
    final errors = validator.validate(bank);

    final byTopic = <String, int>{};
    var unverified = 0;
    for (final q in questions.cast<Map<String, dynamic>>()) {
      byTopic.update(q['topic'] as String, (n) => n + 1, ifAbsent: () => 1);
      if (q['verify'] == true) unverified++;
    }

    stdout.writeln(
      '${state.toUpperCase()}: ${questions.length} questions '
      '($unverified still verify:true) ${jsonEncode(byTopic)}',
    );
    if (errors.isNotEmpty) {
      failed = true;
      for (final e in errors) {
        stderr.writeln('  ERROR $e');
      }
      continue;
    }
    File('assets/questions/$state.json').writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(bank)}\n',
    );
  }

  if (failed) exit(1);
}
