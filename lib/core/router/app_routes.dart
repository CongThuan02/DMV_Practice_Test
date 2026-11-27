import '../../features/quiz/presentation/view_models/quiz_state.dart';

abstract class AppRoutes {
  static const startup = '/';
  static const states = '/states';
  static const home = '/home';
  static const topics = '/home/topics';
  static const signs = '/home/signs';
  static const mockIntro = '/home/mock';
  static const mistakes = '/home/mistakes';
  static const pro = '/home/pro';
  static const settings = '/home/settings';

  static String quiz(QuizMode mode, {String? topic}) => Uri(
    path: '/home/quiz/${mode.name}',
    queryParameters: topic == null ? null : {'topic': topic},
  ).toString();
}
