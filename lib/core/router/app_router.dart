import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/network/api_interceptor.dart';
import 'package:nuestra_app/core/services/share_intent_service.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/auth/presentation/screens/login_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/household_setup_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/household_settings_screen.dart';
import 'package:nuestra_app/shared/widgets/main_shell.dart';

// Feature screens
import 'package:nuestra_app/features/boards/presentation/screens/boards_screen.dart';
import 'package:nuestra_app/features/boards/presentation/screens/board_detail_screen.dart';
import 'package:nuestra_app/features/boards/presentation/screens/share_to_board_screen.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/recipes_screen.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/recipe_detail_screen.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/recipe_form_screen.dart';
import 'package:nuestra_app/features/menus/presentation/screens/menus_screen.dart';
import 'package:nuestra_app/features/menus/presentation/screens/add_meal_screen.dart';
import 'package:nuestra_app/features/wishlists/presentation/screens/wishlists_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:nuestra_app/features/home/presentation/screens/home_screen.dart';

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
  static const String shareToBoard = '/share-to-board';
  static const String recipeDetail = '/recipes/:id';
  static const String recipeNew = '/recipes/new';
  static const String recipeEdit = '/recipes/:id/edit';
  static const String menuDetail = '/menus/:id';
  static const String menuAddMeal = '/menus/:id/add-meal';
  static const String menuEditMeal = '/menus/:id/meals/:mealId/edit';
  static const String expenseDetail = '/expenses/:id';
  static const String eventDetail = '/calendar/:id';

  // Settings
  static const String settings = '/settings';
  static const String profile = '/profile';
}

/// Navigation key for accessing navigator from anywhere
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

/// Listenable that notifies GoRouter when auth state changes or shared content arrives
class AuthChangeNotifier extends ChangeNotifier {
  AuthChangeNotifier(this._ref) {
    _ref.listen(authNotifierProvider, (_, __) {
      notifyListeners();
    });
    _ref.listen(authTokenProvider, (_, __) {
      notifyListeners();
    });
    _ref.listen(sharedContentProvider, (_, __) {
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

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    refreshListenable: authChangeNotifier,
    redirect: (context, state) {
      final authToken = ref.read(authTokenProvider);
      final authState = ref.read(authNotifierProvider);

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

        // Check for shared content - redirect to share-to-board screen
        final sharedContent = ref.read(sharedContentProvider);
        final isOnShareScreen = state.matchedLocation == AppRoutes.shareToBoard;
        if (sharedContent != null && !sharedContent.isEmpty && !isOnShareScreen) {
          return AppRoutes.shareToBoard;
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

      // Share to board (no shell, for receiving shared content)
      GoRoute(
        path: AppRoutes.shareToBoard,
        builder: (context, state) => const ShareToBoardScreen(),
      ),

      // Board detail (no shell)
      GoRoute(
        path: AppRoutes.boardDetail,
        builder: (context, state) {
          final boardId = state.pathParameters['id']!;
          return BoardDetailScreen(boardId: boardId);
        },
      ),

      // Recipe new (no shell) - must be before detail to match first
      GoRoute(
        path: AppRoutes.recipeNew,
        builder: (context, state) => const RecipeFormScreen(),
      ),

      // Recipe edit (no shell)
      GoRoute(
        path: AppRoutes.recipeEdit,
        builder: (context, state) {
          final recipeId = state.pathParameters['id']!;
          return RecipeFormScreen(recipeId: recipeId);
        },
      ),

      // Recipe detail (no shell)
      GoRoute(
        path: AppRoutes.recipeDetail,
        builder: (context, state) {
          final recipeId = state.pathParameters['id']!;
          return RecipeDetailScreen(recipeId: recipeId);
        },
      ),

      // Menu add meal (no shell)
      GoRoute(
        path: AppRoutes.menuAddMeal,
        builder: (context, state) {
          final menuId = state.pathParameters['id']!;
          final dateStr = state.uri.queryParameters['date'];
          final initialDate = dateStr != null ? DateTime.tryParse(dateStr) : null;
          return AddMealScreen(
            menuId: menuId,
            initialDate: initialDate,
          );
        },
      ),

      // Menu edit meal (no shell)
      GoRoute(
        path: AppRoutes.menuEditMeal,
        builder: (context, state) {
          final menuId = state.pathParameters['id']!;
          final mealId = state.pathParameters['mealId']!;
          return AddMealScreen(
            menuId: menuId,
            mealItemId: mealId,
          );
        },
      ),

      // Main app with bottom navigation shell
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Home (dashboard)
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
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
