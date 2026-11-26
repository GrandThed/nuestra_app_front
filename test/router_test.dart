import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';

/// Auth that does nothing: route matching does not need a session.
class _IdleAuth extends AuthNotifier {
  @override
  AuthState build() => const AuthState.unauthenticated();
}

/// Full path of the deepest route that [location] matches.
String _matchedPath(GoRouter router, String location) {
  final match = router.configuration.findMatch(Uri.parse(location));
  return match.fullPath;
}

void main() {
  late ProviderContainer container;
  late GoRouter router;

  setUp(() {
    container = ProviderContainer(
      overrides: [authProvider.overrideWith(_IdleAuth.new)],
    );
    router = container.read(routerProvider);
  });

  tearDown(() => container.dispose());

  // Regression: /expenses/:id used to be declared before these, so
  // Presupuestos/Tendencias/Recurrentes opened "Detalle de gasto" with
  // "Gasto no encontrado".
  for (final route in [
    AppRoutes.addExpense,
    AppRoutes.expenseSummary,
    AppRoutes.recurringExpenses,
    AppRoutes.budgetSetup,
    AppRoutes.expenseTrends,
  ]) {
    test('$route opens its own screen, not the expense detail', () {
      expect(_matchedPath(router, route), route);
    });
  }

  test('an expense id opens the detail screen', () {
    expect(_matchedPath(router, AppRoutes.expenseDetail('abc')), '/expenses/:id');
    expect(_matchedPath(router, AppRoutes.expenseEdit('abc')), '/expenses/:id/edit');
  });

  test('removed features are no longer routable', () {
    for (final old in ['/boards', '/recipes', '/menus', '/wishlists', '/calendar']) {
      expect(router.configuration.findMatch(Uri.parse(old)).matches, isEmpty,
          reason: old);
    }
  });

  test('Gastos is the start screen', () {
    expect(AppRoutes.home, AppRoutes.expenses);
  });
}
