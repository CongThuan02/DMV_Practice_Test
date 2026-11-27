// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_bank_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateBankDto _$StateBankDtoFromJson(Map<String, dynamic> json) => StateBankDto(
  state: json['state'] as String,
  stateName: json['stateName'] as String,
  version: (json['version'] as num).toInt(),
  exam: ExamDto.fromJson(json['exam'] as Map<String, dynamic>),
  topics: (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
  questions: (json['questions'] as List<dynamic>)
      .map((e) => QuestionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

ExamDto _$ExamDtoFromJson(Map<String, dynamic> json) => ExamDto(
  questions: (json['questions'] as num).toInt(),
  passMark: (json['passMark'] as num).toInt(),
);

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
  id: json['id'] as String,
  type: json['type'] as String,
  topic: json['topic'] as String,
  q: json['q'] as String,
  options: _optionsFromJson(json['options'] as List),
  answer: (json['answer'] as num).toInt(),
  source: json['source'] as String,
  difficulty: (json['difficulty'] as num?)?.toInt() ?? 1,
  image: json['image'] as String?,
  explain: json['explain'] as String? ?? '',
  sourceUrl: json['sourceUrl'] as String?,
  verify: json['verify'] as bool? ?? true,
);
