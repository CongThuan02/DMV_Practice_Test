/// Pure-Dart checks on a raw state bank JSON map, shared by
/// `tool/build_question_bank.dart` and the asset tests.
class QuestionValidator {
  QuestionValidator({required this.assetExists});

  static const types = {
    'text',
    'number_fill',
    'scenario',
    'sign',
    'marking',
    'image_options',
  };
  static const imageTypes = {'scenario', 'sign', 'marking'};
  static const blank = '___';

  final bool Function(String assetPath) assetExists;

  List<String> validate(Map<String, dynamic> bank) {
    final errors = <String>[];
    final topics = (bank['topics'] as List?)?.cast<String>().toSet() ?? {};
    final exam = bank['exam'] as Map<String, dynamic>?;
    final examQuestions = exam?['questions'];
    final passMark = exam?['passMark'];
    if (examQuestions is! int || passMark is! int) {
      errors.add('exam.questions and exam.passMark must be integers');
    } else if (passMark <= 0 || passMark > examQuestions) {
      errors.add('exam.passMark must be between 1 and exam.questions');
    }
    if (topics.isEmpty) errors.add('topics must not be empty');

    final ids = <String>{};
    for (final raw in (bank['questions'] as List? ?? const [])) {
      final q = raw as Map<String, dynamic>;
      final id = q['id'] as String? ?? '<missing id>';
      void fail(String message) => errors.add('$id: $message');

      if (!ids.add(id)) fail('duplicate id');
      final type = q['type'];
      if (!types.contains(type)) fail('unknown type "$type"');
      if (!topics.contains(q['topic'])) {
        fail('topic "${q['topic']}" not in topics');
      }
      if ((q['q'] as String? ?? '').trim().isEmpty) fail('empty question text');
      if ((q['explain'] as String? ?? '').trim().isEmpty) {
        fail('missing explain');
      }
      if ((q['source'] as String? ?? '').trim().isEmpty) fail('missing source');
      if (q['verify'] is! bool) fail('verify must be true or false');

      final options = q['options'] as List? ?? const [];
      if (options.length < 2 || options.length > 4) {
        fail('needs 2-4 options, has ${options.length}');
      }
      final answer = q['answer'];
      if (answer is! int || answer < 0 || answer >= options.length) {
        fail('answer $answer is not a valid option index');
      }
      final labels = [for (final o in options) o is Map ? o['label'] : o];
      if (labels.toSet().length != labels.length) fail('duplicate options');

      final image = q['image'];
      if (imageTypes.contains(type)) {
        if (image is! String) {
          fail('type $type needs an image');
        } else if (!assetExists(image)) {
          fail('image not found: $image');
        }
      } else if (image is String && !assetExists(image)) {
        fail('image not found: $image');
      }

      if (type == 'number_fill') {
        final text = q['q'] as String? ?? '';
        if (blank.allMatches(text).length != 1) {
          fail('needs exactly one $blank');
        }
        if (labels.any((l) => l is! String || num.tryParse(l) == null)) {
          fail('number_fill options must be numbers');
        }
      }

      if (type == 'image_options') {
        for (final o in options) {
          if (o is! Map || o['label'] is! String) {
            fail('image_options options must be {label, color|image}');
            continue;
          }
          final color = o['color'];
          final optionImage = o['image'];
          if (color == null && optionImage == null) {
            fail('option "${o['label']}" needs a color or image');
          }
          if (color is String &&
              !RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(color)) {
            fail('bad color $color');
          }
          if (optionImage is String && !assetExists(optionImage)) {
            fail('image not found: $optionImage');
          }
        }
      } else if (options.any((o) => o is! String)) {
        fail('options must be plain strings for type $type');
      }
    }
    return errors;
  }
}
