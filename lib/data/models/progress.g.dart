// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MistakeEntry _$MistakeEntryFromJson(Map<String, dynamic> json) => MistakeEntry(
  missed: (json['missed'] as num).toInt(),
  correctStreak: (json['correctStreak'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MistakeEntryToJson(MistakeEntry instance) =>
    <String, dynamic>{
      'missed': instance.missed,
      'correctStreak': instance.correctStreak,
    };

ExamRecord _$ExamRecordFromJson(Map<String, dynamic> json) => ExamRecord(
  correct: (json['correct'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  passed: json['passed'] as bool,
  takenAt: DateTime.parse(json['takenAt'] as String),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
);

Map<String, dynamic> _$ExamRecordToJson(ExamRecord instance) =>
    <String, dynamic>{
      'correct': instance.correct,
      'total': instance.total,
      'passed': instance.passed,
      'takenAt': instance.takenAt.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
    };
