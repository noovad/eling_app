import 'package:eling_app/presentation/pages/note_section/note_section.dart';
import 'package:eling_app/presentation/pages/task/task_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [GoRoute(path: '/', builder: (_, __) => const TaskPage())],
  );
}
