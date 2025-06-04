import 'package:eling_app/presentation/pages/finance/finance_page.dart';
import 'package:eling_app/presentation/pages/todoPage/todo_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/a', builder: (_, __) => const TodoPage()),
      GoRoute(path: '/', builder: (_, __) => const FinancePage()),
    ],
  );
}
