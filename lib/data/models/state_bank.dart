import 'question.dart';

class ExamConfig {
  const ExamConfig({required this.questionCount, required this.passMark});

  final int questionCount;
  final int passMark;

  double get passRatio => passMark / questionCount;

  /// Pass mark for an exam that had to be shortened because the bank holds
  /// fewer questions than the official test.
  int passMarkFor(int total) =>
      total >= questionCount ? passMark : (total * passRatio).ceil();
}

class StateBank {
  const StateBank({
    required this.code,
    required this.name,
    required this.version,
    required this.exam,
    required this.topics,
    required this.questions,
  });

  final String code;
  final String name;
  final int version;
  final ExamConfig exam;
  final List<String> topics;
  final List<Question> questions;

  List<Question> byTopic(String topic) =>
      questions.where((q) => q.topic == topic).toList(growable: false);

  List<Question> byType(QuestionType type) =>
      questions.where((q) => q.type == type).toList(growable: false);
}
