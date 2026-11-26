import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/network/api_interceptor.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/auth/presentation/screens/login_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/household_setup_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/household_settings_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/join_by_invite_screen.dart';
import 'package:nuestra_app/shared/widgets/main_shell.dart';

// Feature screens
import 'package:nuestra_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/add_expense_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expense_detail_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expense_summary_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expense_form_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/recurring_expenses_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/budget_setup_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expense_trends_screen.dart';
import 'package:nuestra_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:nuestra_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:nuestra_app/features/activity/presentation/screens/activity_feed_screen.dart';
import 'package:nuestra_app/features/assistant/presentation/assistant_screen.dart';

/// Route names
class AppRoutes {
  AppRoutes._();

  // Auth
  static const String splash = '/splash';
  static const String login = '/login';

  // Household
  static const String householdSetup = '/household-setup';
  static const String householdSettings = '/household-settings';
  static const String joinByInvite = '/join/:code';

  // Main tabs
  static const String root = '/';
  static const String expenses = '/expenses';
  static const String chat = '/chat';

  /// The app's start screen. Gastos is the core feature.
  static const String home = expenses;

  // Expense routes
  static const String addExpense = '/expenses/new';
  static const String expenseSummary = '/expenses/summary';
  static const String recurringExpenses = '/expenses/recurring';
  static const String budgetSetup = '/expenses/budgets';
  static const String expenseTrends = '/expenses/trends';
  static const String _expenseDetail = '/expenses/:id';
  static String expenseDetail(String id) => '/expenses/$id';
  static const String _expenseEdit = '/expenses/:id/edit';
  static String expenseEdit(String id) => '/expenses/$id/edit';

  // Settings & Profile
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String activityFeed = '/activity';
}

/// Navigation key for accessing navigator from anywhere
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

/// Custom back button dispatcher that navigates to home
/// instead of closing the app when on a non-home shell route.
class ShellBackButtonDispatcher extends RootBackButtonDispatcher {
  late GoRouter _router;

  void attach(GoRouter router) => _router = router;

  @override
  Future<bool> didPopRoute() async {
    final path = _router.routeInformationProvider.value.uri.path;
    if (path != AppRoutes.home) {
      _router.go(AppRoutes.home);
      return true;
    }
    return super.didPopRoute();
  }
}

/// Singleton dispatcher shared between router provider and App widget.
final shellBackButtonDispatcher = ShellBackButtonDispatcher();

/// Listenable that notifies GoRouter when auth state changes
class AuthChangeNotifier extends ChangeNotifier {
  AuthChangeNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) {
      notifyListeners();
    });
    _ref.listen(authTokenProvider, (_, __) {
      notifyListeners();
    });
  }

  final Ref _ref;
}

/// Provider for the auth change notifier
final authChangeNotifierProvider = Provider<AuthChangeNotifier>((ref) {
  return AuthChangeNotifier(ref);
});

/// Provider for GoRouter
final routerProvider = Provider<GoRouter>((ref) {
  final authChangeNotifier = ref.watch(authChangeNotifierProvider);

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: authChangeNotifier,
    redirect: (context, state) {
      final authToken = ref.read(authTokenProvider);
      final authState = ref.read(authProvider);

      final isLoggedIn = authToken != null;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isSettingUpHousehold =
          state.matchedLocation == AppRoutes.householdSetup;
      // Allow unauthenticated access to join-by-invite for web invitation flow
      final isJoiningByInvite = state.matchedLocation.startsWith('/join/');

      // If not logged in, redirect to login (except if already on login or joining by invite)
      if (!isLoggedIn && !isLoggingIn && !isJoiningByInvite) {
        return AppRoutes.login;
      }

      // If logged in but on login page, redirect to home
      if (isLoggedIn && isLoggingIn) {
        return AppRoutes.home;
      }

      // Check if user has a household, if not redirect to setup
      if (authState is AuthStateAuthenticated) {
        final hasHousehold = authState.user.households?.isNotEmpty ?? false;

        // If user has no household and not already on setup or joining, redirect to setup
        if (!hasHousehold && !isSettingUpHousehold && !isJoiningByInvite) {
          return AppRoutes.householdSetup;
        }

        // If user has household but is on setup page, redirect to home
        if (hasHousehold && isSettingUpHousehold) {
          return AppRoutes.home;
        }
      }

      return null; // No redirect
    },
    routes: [
      // Login (no shell)
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // Household setup (no shell)
      GoRoute(
        path: AppRoutes.householdSetup,
        builder: (context, state) => const HouseholdSetupScreen(),
      ),

      // Household settings (no shell, accessible from main app)
      GoRoute(
        path: AppRoutes.householdSettings,
        builder: (context, state) => const HouseholdSettingsScreen(),
      ),

      // Join by invite deeplink (no shell)
      GoRoute(
        path: AppRoutes.joinByInvite,
        builder: (context, state) {
          final code = state.pathParameters['code']!;
          return JoinByInviteScreen(inviteCode: code);
        },
      ),

      // Expense screens (no shell).
      // GoRouter takes the FIRST matching route, so every literal
      // /expenses/<name> route must come before /expenses/:id, or it opens
      // the detail screen with id "<name>" ("Gasto no encontrado").
      GoRoute(
        path: AppRoutes.addExpense,
        builder: (context, state) => const AddExpenseScreen(),
      ),
      GoRoute(
        path: AppRoutes.expenseSummary,
        builder: (context, state) => const ExpenseSummaryScreen(),
      ),
      GoRoute(
        path: AppRoutes.recurringExpenses,
        builder: (context, state) => const RecurringExpensesScreen(),
      ),
      GoRoute(
        path: AppRoutes.budgetSetup,
        builder: (context, state) => const BudgetSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.expenseTrends,
        builder: (context, state) => const ExpenseTrendsScreen(),
      ),
      GoRoute(
        path: AppRoutes._expenseEdit,
        builder: (context, state) {
          final expenseId = state.pathParameters['id']!;
          return ExpenseFormScreen(expenseId: expenseId);
        },
      ),
      GoRoute(
        path: AppRoutes._expenseDetail,
        builder: (context, state) {
          final expenseId = state.pathParameters['id']!;
          return ExpenseDetailScreen(expenseId: expenseId);
        },
      ),

      // Profile (no shell)
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),

      // Settings (no shell)
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Activity feed (no shell)
      GoRoute(
        path: AppRoutes.activityFeed,
        builder: (context, state) => const ActivityFeedScreen(),
      ),

      // The old dashboard lived at "/"; send it to the start screen.
      GoRoute(
        path: AppRoutes.root,
        redirect: (context, state) => AppRoutes.home,
      ),

      // Main app with bottom navigation shell
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Expenses
          GoRoute(
            path: AppRoutes.expenses,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ExpensesScreen(),
            ),
          ),

          // Assistant (on-device Gemma 4)
          GoRoute(
            path: AppRoutes.chat,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AssistantScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.matchedLocation}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );

  shellBackButtonDispatcher.attach(router);
  return router;
});
