import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/views/home_page.dart';
import '../../features/mistakes/presentation/views/mistakes_page.dart';
import '../../features/mock_exam/presentation/views/mock_intro_page.dart';
import '../../features/pro/presentation/views/pro_page.dart';
import '../../features/quiz/presentation/view_models/quiz_state.dart';
import '../../features/quiz/presentation/views/quiz_page.dart';
import '../../features/settings/presentation/views/settings_page.dart';
import '../../features/signs/presentation/views/sign_cards_page.dart';
import '../../features/startup/presentation/views/startup_page.dart';
import '../../features/state_picker/presentation/views/state_picker_page.dart';
import '../../features/topics/presentation/views/topics_page.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.startup,
    routes: [
      GoRoute(path: AppRoutes.startup, builder: (_, _) => const StartupPage()),
      GoRoute(
        path: AppRoutes.states,
        builder: (_, _) => const StatePickerPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, _) => const HomePage(),
        routes: [
          GoRoute(path: 'topics', builder: (_, _) => const TopicsPage()),
          GoRoute(path: 'signs', builder: (_, _) => const SignCardsPage()),
          GoRoute(path: 'mock', builder: (_, _) => const MockIntroPage()),
          GoRoute(path: 'mistakes', builder: (_, _) => const MistakesPage()),
          GoRoute(path: 'pro', builder: (_, _) => const ProPage()),
          GoRoute(path: 'settings', builder: (_, _) => const SettingsPage()),
          GoRoute(
            path: 'quiz/:mode',
            builder: (_, state) => QuizPage(
              mode: QuizMode.values.byName(state.pathParameters['mode']!),
              topic: state.uri.queryParameters['topic'],
            ),
          ),
        ],
      ),
    ],
  );
}
