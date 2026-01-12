import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/network/api_interceptor.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/auth/presentation/screens/login_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/household_setup_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/household_settings_screen.dart';
import 'package:nuestra_app/shared/widgets/main_shell.dart';

// Feature screens
import 'package:nuestra_app/features/boards/presentation/screens/boards_screen.dart';
import 'package:nuestra_app/features/boards/presentation/screens/board_detail_screen.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/recipes_screen.dart';
import 'package:nuestra_app/features/menus/presentation/screens/menus_screen.dart';
import 'package:nuestra_app/features/wishlists/presentation/screens/wishlists_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:nuestra_app/features/calendar/presentation/screens/calendar_screen.dart';

/// Route names
class AppRoutes {
  AppRoutes._();

  // Auth
  static const String splash = '/splash';
  static const String login = '/login';

  // Household
  static const String householdSetup = '/household-setup';
  static const String householdSettings = '/household-settings';

  // Main tabs
  static const String home = '/';
  static const String boards = '/boards';
  static const String recipes = '/recipes';
  static const String menus = '/menus';
  static const String wishlists = '/wishlists';
  static const String expenses = '/expenses';
  static const String calendar = '/calendar';

  // Detail screens
  static const String boardDetail = '/boards/:id';
  static const String recipeDetail = '/recipes/:id';
  static const String menuDetail = '/menus/:id';
  static const String expenseDetail = '/expenses/:id';
  static const String eventDetail = '/calendar/:id';

  // Settings
  static const String settings = '/settings';
  static const String profile = '/profile';
}

/// Navigation key for accessing navigator from anywhere
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

/// Provider for GoRouter
final routerProvider = Provider<GoRouter>((ref) {
  final authToken = ref.watch(authTokenProvider);
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authToken != null;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isSettingUpHousehold =
          state.matchedLocation == AppRoutes.householdSetup;

      // If not logged in, redirect to login (except if already on login)
      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.login;
      }

      // If logged in but on login page, redirect to home
      if (isLoggedIn && isLoggingIn) {
        return AppRoutes.home;
      }

      // Check if user has a household, if not redirect to setup
      if (authState is AuthStateAuthenticated) {
        final hasHousehold = authState.user.households?.isNotEmpty ?? false;

        // If user has no household and not already on setup, redirect to setup
        if (!hasHousehold && !isSettingUpHousehold) {
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

      // Board detail (no shell)
      GoRoute(
        path: AppRoutes.boardDetail,
        builder: (context, state) {
          final boardId = state.pathParameters['id']!;
          return BoardDetailScreen(boardId: boardId);
        },
      ),

      // Main app with bottom navigation shell
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Home / Calendar (default tab)
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CalendarScreen(),
            ),
          ),

          // Boards
          GoRoute(
            path: AppRoutes.boards,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BoardsScreen(),
            ),
          ),

          // Recipes
          GoRoute(
            path: AppRoutes.recipes,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: RecipesScreen(),
            ),
          ),

          // Menus
          GoRoute(
            path: AppRoutes.menus,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MenusScreen(),
            ),
          ),

          // Wishlists
          GoRoute(
            path: AppRoutes.wishlists,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: WishlistsScreen(),
            ),
          ),

          // Expenses
          GoRoute(
            path: AppRoutes.expenses,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ExpensesScreen(),
            ),
          ),

          // Calendar
          GoRoute(
            path: AppRoutes.calendar,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CalendarScreen(),
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
});
