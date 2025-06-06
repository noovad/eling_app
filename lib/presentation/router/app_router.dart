import 'package:eling_app/presentation/pages/finance/finance_page.dart';
import 'package:eling_app/presentation/pages/todoPage/todo_page.dart';
import 'package:eling_app/presentation/router/app_routes.dart';
import 'package:eling_app/presentation/router/shell/app_shell.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppPage.todo.route,
    routes: [
      ShellRoute(
        builder:
            (context, state, child) => AppShell(state: state, child: child),
        routes: [
          GoRoute(
            path: AppPage.todo.route,
            builder: (context, state) => const TodoPage(),
          ),
          GoRoute(
            path: AppPage.finance.route,
            builder: (context, state) => const FinancePage(),
          ),
        ],
      ),
    ],
  );
}
