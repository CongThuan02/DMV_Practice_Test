import 'dart:math';
import 'dart:ui' show Color;

enum QuestionType {
  text,
  numberFill,
  scenario,
  sign,
  marking,
  imageOptions;

  static QuestionType parse(String value) => switch (value) {
    'number_fill' => numberFill,
    'scenario' => scenario,
    'sign' => sign,
    'marking' => marking,
    'image_options' => imageOptions,
    _ => text,
  };
}

class AnswerOption {
  const AnswerOption({required this.label, this.color, this.image});

  final String label;
  final Color? color;
  final String? image;
}

class Question {
  const Question({
    required this.id,
    required this.type,
    required this.topic,
    required this.difficulty,
    required this.text,
    required this.options,
    required this.answer,
    required this.explain,
    required this.source,
    this.image,
  });

  final String id;
  final QuestionType type;
  final String topic;
  final int difficulty;
  final String text;
  final String? image;
  final List<AnswerOption> options;
  final int answer;
  final String explain;
  final String source;

  AnswerOption get correctOption => options[answer];

  /// Number-fill options read best in ascending order, so they are sorted
  /// instead of shuffled.
  Question withShuffledOptions(Random random) {
    final order = List<int>.generate(options.length, (i) => i);
    if (type == QuestionType.numberFill) {
      order.sort(
        (a, b) => (num.tryParse(options[a].label) ?? 0).compareTo(
          num.tryParse(options[b].label) ?? 0,
        ),
      );
    } else {
      order.shuffle(random);
    }
    return Question(
      id: id,
      type: type,
      topic: topic,
      difficulty: difficulty,
      text: text,
      image: image,
      options: [for (final i in order) options[i]],
      answer: order.indexOf(answer),
      explain: explain,
      source: source,
    );
  }
}
