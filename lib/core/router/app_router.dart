import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/network/api_interceptor.dart';
import 'package:nuestra_app/core/providers/shared_content_provider.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/auth/presentation/screens/login_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/household_setup_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/household_settings_screen.dart';
import 'package:nuestra_app/features/household/presentation/screens/join_by_invite_screen.dart';
import 'package:nuestra_app/shared/widgets/main_shell.dart';

// Feature screens
import 'package:nuestra_app/features/boards/presentation/screens/boards_screen.dart';
import 'package:nuestra_app/features/boards/presentation/screens/board_detail_screen.dart';
// Conditional import - use stub on web since share intents are not supported
import 'package:nuestra_app/features/boards/presentation/screens/share_to_board_screen.dart'
    if (dart.library.html) 'package:nuestra_app/features/boards/presentation/screens/share_to_board_screen_stub.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/recipes_screen.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/recipe_detail_screen.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/recipe_form_screen.dart';
import 'package:nuestra_app/features/menus/presentation/screens/menus_screen.dart';
import 'package:nuestra_app/features/menus/presentation/screens/add_meal_screen.dart';
import 'package:nuestra_app/features/wishlists/presentation/screens/wishlists_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/add_expense_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expense_detail_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expense_summary_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expense_form_screen.dart';
import 'package:nuestra_app/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:nuestra_app/features/calendar/presentation/screens/add_event_screen.dart';
import 'package:nuestra_app/features/calendar/presentation/screens/event_detail_screen.dart';
import 'package:nuestra_app/features/calendar/presentation/screens/event_form_screen.dart';
import 'package:nuestra_app/features/home/presentation/screens/home_screen.dart';
import 'package:nuestra_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:nuestra_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/seasonal_vegetables_screen.dart';
import 'package:nuestra_app/features/recipes/presentation/screens/cooking_mode_screen.dart';
import 'package:nuestra_app/features/activity/presentation/screens/activity_feed_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/recurring_expenses_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/budget_setup_screen.dart';
import 'package:nuestra_app/features/expenses/presentation/screens/expense_trends_screen.dart';
import 'package:nuestra_app/features/menus/presentation/screens/meal_history_screen.dart';
import 'package:nuestra_app/features/wishlists/presentation/screens/purchase_history_screen.dart';

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
  static const String menuAddMealSimple = '/menus/add-meal'; // Without menu ID
  static const String menuAddMeal = '/menus/:id/add-meal'; // With menu ID
  static const String menuEditMeal = '/menus/:id/meals/:mealId/edit';

  // Expense routes
  static const String addExpense = '/expenses/new';
  static const String expenseSummary = '/expenses/summary';
  static const String _expenseDetail = '/expenses/:id';
  static String expenseDetail(String id) => '/expenses/$id';
  static const String _expenseEdit = '/expenses/:id/edit';
  static String expenseEdit(String id) => '/expenses/$id/edit';

  // Calendar/Event routes
  static const String addEvent = '/calendar/new';
  static const String _eventDetail = '/calendar/:id';
  static String eventDetail(String id) => '/calendar/$id';
  static const String _eventEdit = '/calendar/:id/edit';
  static String eventEdit(String id) => '/calendar/$id/edit';

  // Settings & Profile
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String seasonalVegetables = '/recipes/seasonal';

  // New feature screens
  static const String activityFeed = '/activity';
  static const String cookingMode = '/recipes/:id/cooking';
  static String cookingModeFor(String id) => '/recipes/$id/cooking';
  static const String recurringExpenses = '/expenses/recurring';
  static const String budgetSetup = '/expenses/budgets';
  static const String expenseTrends = '/expenses/trends';
  static const String mealHistory = '/menus/history';
  static const String purchaseHistory = '/wishlists/history';
}

/// Navigation key for accessing navigator from anywhere
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

/// Listenable that notifies GoRouter when auth state changes or shared content arrives
class AuthChangeNotifier extends ChangeNotifier {
  AuthChangeNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) {
      notifyListeners();
    });
    _ref.listen(authTokenProvider, (_, __) {
      notifyListeners();
    });
    // Only listen to shared content on mobile (share intents don't work on web)
    if (!kIsWeb) {
      _ref.listen(sharedContentProvider, (_, __) {
        notifyListeners();
      });
    }
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

        // Check for shared content - redirect to share-to-board screen (mobile only)
        if (!kIsWeb) {
          final sharedContent = ref.read(sharedContentProvider);
          final isOnShareScreen = state.matchedLocation == AppRoutes.shareToBoard;
          if (sharedContent != null && !sharedContent.isEmpty && !isOnShareScreen) {
            return AppRoutes.shareToBoard;
          }
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

      // Join by invite deeplink (no shell)
      GoRoute(
        path: AppRoutes.joinByInvite,
        builder: (context, state) {
          final code = state.pathParameters['code']!;
          return JoinByInviteScreen(inviteCode: code);
        },
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

      // Menu add meal without ID (no shell) - must be before :id route
      GoRoute(
        path: AppRoutes.menuAddMealSimple,
        builder: (context, state) {
          final dateStr = state.uri.queryParameters['date'];
          final initialDate = dateStr != null ? DateTime.tryParse(dateStr) : null;
          return AddMealScreen(
            initialDate: initialDate,
          );
        },
      ),

      // Menu add meal with ID (no shell)
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

      // Expense add (no shell) - must be before detail to match first
      GoRoute(
        path: AppRoutes.addExpense,
        builder: (context, state) => const AddExpenseScreen(),
      ),

      // Expense summary (no shell)
      GoRoute(
        path: AppRoutes.expenseSummary,
        builder: (context, state) => const ExpenseSummaryScreen(),
      ),

      // Expense edit (no shell) - must be before detail to match first
      GoRoute(
        path: AppRoutes._expenseEdit,
        builder: (context, state) {
          final expenseId = state.pathParameters['id']!;
          return ExpenseFormScreen(expenseId: expenseId);
        },
      ),

      // Expense detail (no shell)
      GoRoute(
        path: AppRoutes._expenseDetail,
        builder: (context, state) {
          final expenseId = state.pathParameters['id']!;
          return ExpenseDetailScreen(expenseId: expenseId);
        },
      ),

      // Calendar add event (no shell) - must be before detail to match first
      GoRoute(
        path: AppRoutes.addEvent,
        builder: (context, state) => const AddEventScreen(),
      ),

      // Calendar event edit (no shell) - must be before detail to match first
      GoRoute(
        path: AppRoutes._eventEdit,
        builder: (context, state) {
          final eventId = state.pathParameters['id']!;
          return EventFormScreen(eventId: eventId);
        },
      ),

      // Calendar event detail (no shell)
      GoRoute(
        path: AppRoutes._eventDetail,
        builder: (context, state) {
          final eventId = state.pathParameters['id']!;
          return EventDetailScreen(eventId: eventId);
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

      // Seasonal vegetables (no shell) - must be before /recipes/:id
      GoRoute(
        path: AppRoutes.seasonalVegetables,
        builder: (context, state) => const SeasonalVegetablesScreen(),
      ),

      // Cooking mode (no shell) - must be before /recipes/:id
      GoRoute(
        path: AppRoutes.cookingMode,
        builder: (context, state) {
          final recipeId = state.pathParameters['id']!;
          return CookingModeScreen(recipeId: recipeId);
        },
      ),

      // Activity feed (no shell)
      GoRoute(
        path: AppRoutes.activityFeed,
        builder: (context, state) => const ActivityFeedScreen(),
      ),

      // Recurring expenses (no shell) - must be before /expenses/:id
      GoRoute(
        path: AppRoutes.recurringExpenses,
        builder: (context, state) => const RecurringExpensesScreen(),
      ),

      // Budget setup (no shell)
      GoRoute(
        path: AppRoutes.budgetSetup,
        builder: (context, state) => const BudgetSetupScreen(),
      ),

      // Expense trends (no shell)
      GoRoute(
        path: AppRoutes.expenseTrends,
        builder: (context, state) => const ExpenseTrendsScreen(),
      ),

      // Meal history (no shell) - must be before /menus/:id
      GoRoute(
        path: AppRoutes.mealHistory,
        builder: (context, state) => const MealHistoryScreen(),
      ),

      // Purchase history (no shell)
      GoRoute(
        path: AppRoutes.purchaseHistory,
        builder: (context, state) => const PurchaseHistoryScreen(),
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
