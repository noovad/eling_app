import 'package:eling_app/presentation/pages/todo_section/widget/todo_tabs.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [GoRoute(path: '/', builder: (_, __) => const TodoTabs())],
  );
}
