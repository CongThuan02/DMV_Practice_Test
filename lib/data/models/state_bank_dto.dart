import 'dart:ui' show Color;

import 'package:json_annotation/json_annotation.dart';

import 'question.dart';
import 'state_bank.dart';

part 'state_bank_dto.g.dart';

@JsonSerializable(createToJson: false)
class StateBankDto {
  const StateBankDto({
    required this.state,
    required this.stateName,
    required this.version,
    required this.exam,
    required this.topics,
    required this.questions,
  });

  factory StateBankDto.fromJson(Map<String, dynamic> json) =>
      _$StateBankDtoFromJson(json);

  final String state;
  final String stateName;
  final int version;
  final ExamDto exam;
  final List<String> topics;
  final List<QuestionDto> questions;

  StateBank toDomain({required bool includeUnverified}) => StateBank(
    code: state,
    name: stateName,
    version: version,
    exam: ExamConfig(questionCount: exam.questions, passMark: exam.passMark),
    topics: topics,
    questions: [
      for (final q in questions)
        if (includeUnverified || !q.verify) q.toDomain(),
    ],
  );
}

@JsonSerializable(createToJson: false)
class ExamDto {
  const ExamDto({required this.questions, required this.passMark});

  factory ExamDto.fromJson(Map<String, dynamic> json) =>
      _$ExamDtoFromJson(json);

  final int questions;
  final int passMark;
}

@JsonSerializable(createToJson: false)
class QuestionDto {
  const QuestionDto({
    required this.id,
    required this.type,
    required this.topic,
    required this.q,
    required this.options,
    required this.answer,
    required this.source,
    this.difficulty = 1,
    this.image,
    this.explain = '',
    this.sourceUrl,
    this.verify = true,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  final String id;
  final String type;
  final String topic;
  final int difficulty;
  final String q;
  final String? image;
  @JsonKey(fromJson: _optionsFromJson)
  final List<OptionDto> options;
  final int answer;
  final String explain;
  final String source;
  final String? sourceUrl;
  final bool verify;

  Question toDomain() => Question(
    id: id,
    type: QuestionType.parse(type),
    topic: topic,
    difficulty: difficulty,
    text: q,
    image: image,
    options: [for (final o in options) o.toDomain()],
    answer: answer,
    explain: explain,
    source: source,
  );
}

class OptionDto {
  const OptionDto({required this.label, this.color, this.image});

  factory OptionDto.fromJson(Object json) => switch (json) {
    String label => OptionDto(label: label),
    Map<String, dynamic> map => OptionDto(
      label: map['label'] as String,
      color: map['color'] as String?,
      image: map['image'] as String?,
    ),
    _ => throw FormatException('Unsupported option: $json'),
  };

  final String label;
  final String? color;
  final String? image;

  AnswerOption toDomain() => AnswerOption(
    label: label,
    color: color == null ? null : _parseHexColor(color!),
    image: image,
  );
}

List<OptionDto> _optionsFromJson(List<dynamic> json) => [
  for (final o in json) OptionDto.fromJson(o as Object),
];

Color _parseHexColor(String hex) {
  final value = int.parse(hex.replaceFirst('#', ''), radix: 16);
  return Color(hex.length <= 7 ? 0xFF000000 | value : value);
}
