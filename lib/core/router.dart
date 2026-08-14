import 'package:go_router/go_router.dart';

import '../features/home/home_screen.dart';
import '../features/study/study_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/study/:wordBookId',
      builder: (context, state) {
        final wordBookId = int.parse(state.pathParameters['wordBookId']!);
        return StudyScreen(wordBookId: wordBookId);
      },
    ),
  ],
);
