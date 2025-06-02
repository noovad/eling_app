import 'package:eling_app/presentation/pages/finance/finance_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [GoRoute(path: '/', builder: (_, __) => const FinancePage())],
  );
}
