import 'package:json_annotation/json_annotation.dart';

part 'progress.g.dart';

@JsonSerializable()
class MistakeEntry {
  const MistakeEntry({required this.missed, this.correctStreak = 0});

  factory MistakeEntry.fromJson(Map<String, dynamic> json) =>
      _$MistakeEntryFromJson(json);

  /// Answering correctly this many times in a row clears the mistake.
  static const streakToClear = 2;

  final int missed;
  final int correctStreak;

  Map<String, dynamic> toJson() => _$MistakeEntryToJson(this);
}

@JsonSerializable()
class ExamRecord {
  const ExamRecord({
    required this.correct,
    required this.total,
    required this.passed,
    required this.takenAt,
    required this.durationSeconds,
  });

  factory ExamRecord.fromJson(Map<String, dynamic> json) =>
      _$ExamRecordFromJson(json);

  final int correct;
  final int total;
  final bool passed;
  final DateTime takenAt;
  final int durationSeconds;

  Map<String, dynamic> toJson() => _$ExamRecordToJson(this);
}

class StateProgress {
  const StateProgress({
    this.seen = const {},
    this.mistakes = const {},
    this.exams = const [],
  });

  final Set<String> seen;
  final Map<String, MistakeEntry> mistakes;
  final List<ExamRecord> exams;

  StateProgress copyWith({
    Set<String>? seen,
    Map<String, MistakeEntry>? mistakes,
    List<ExamRecord>? exams,
  }) => StateProgress(
    seen: seen ?? this.seen,
    mistakes: mistakes ?? this.mistakes,
    exams: exams ?? this.exams,
  );

  StateProgress recordAnswer(String questionId, {required bool correct}) {
    final updated = Map<String, MistakeEntry>.of(mistakes);
    final entry = updated[questionId];
    if (!correct) {
      updated[questionId] = MistakeEntry(missed: (entry?.missed ?? 0) + 1);
    } else if (entry != null) {
      final streak = entry.correctStreak + 1;
      if (streak >= MistakeEntry.streakToClear) {
        updated.remove(questionId);
      } else {
        updated[questionId] = MistakeEntry(
          missed: entry.missed,
          correctStreak: streak,
        );
      }
    }
    return copyWith(seen: {...seen, questionId}, mistakes: updated);
  }
}
