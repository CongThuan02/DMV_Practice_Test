import 'package:dmv_practice_test/core/storage/shared_preferences_provider.dart';
import 'package:dmv_practice_test/data/models/state_bank.dart';
import 'package:dmv_practice_test/data/models/state_bank_dto.dart';
import 'package:dmv_practice_test/data/session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> questionJson(
  String id, {
  String topic = 'signs',
  String type = 'text',
  int answer = 0,
  List<Object> options = const ['A', 'B', 'C'],
  String? image,
  bool verify = false,
  String q = 'Question?',
}) => {
  'id': id,
  'type': type,
  'topic': topic,
  'difficulty': 1,
  'q': q,
  'image': image,
  'options': options,
  'answer': answer,
  'explain': 'Because.',
  'source': 'Test Code § 1',
  'verify': verify,
};

Map<String, dynamic> bankJson(
  List<Map<String, dynamic>> questions, {
  int examQuestions = 4,
  int passMark = 3,
}) => {
  'state': 'CA',
  'stateName': 'California',
  'version': 1,
  'exam': {'questions': examQuestions, 'passMark': passMark},
  'topics': ['signs', 'speed'],
  'questions': questions,
};

StateBank bankFrom(Map<String, dynamic> json) =>
    StateBankDto.fromJson(json).toDomain(includeUnverified: true);

Future<ProviderContainer> makeContainer({
  StateBank? bank,
  DateTime Function()? clock,
  List<Override> overrides = const [],
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      if (bank != null) stateBankProvider.overrideWith((_) async => bank),
      if (clock != null) clockProvider.overrideWithValue(clock),
      ...overrides,
    ],
  );
}
