import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/home/presentation/widgets/todays_menu_card.dart';
import 'package:nuestra_app/features/home/presentation/widgets/shopping_list_card.dart';
import 'package:nuestra_app/features/home/presentation/widgets/expenses_summary_card.dart';
import 'package:nuestra_app/features/home/presentation/widgets/upcoming_events_card.dart';
import 'package:nuestra_app/features/home/presentation/widgets/quick_actions_fab.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_notifier.dart';

/// Home dashboard screen
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data using microtask to avoid calling during build
    Future.microtask(() => _loadDataWhenReady());
  }

  /// Wait for household ID to be available, then load data
  Future<void> _loadDataWhenReady() async {
    if (!mounted) return;

    // Check if household ID is already available, or wait for it
    final householdId =
        ref.read(currentHouseholdIdProvider) ?? await _waitForHouseholdId();

    if (!mounted) return;

    if (householdId != null) {
      _loadAllData();
    }
  }

  /// Wait for household ID to become available (with timeout)
  Future<String?> _waitForHouseholdId() async {
    // Poll for household ID with timeout
    for (var i = 0; i < 50; i++) {
      // Max 5 seconds (50 * 100ms)
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return null;

      final id = ref.read(currentHouseholdIdProvider);
      if (id != null) {
        return id;
      }
    }
    return null;
  }

  void _loadAllData() {
    // Load today's meals
    final today = DateTime.now();
    final weekStart = DateTime(today.year, today.month, today.day);
    ref
        .read(upcomingMealsProvider.notifier)
        .loadWeekIfNeeded(weekStart);

    // Load menu plans for the FAB
    ref.read(menuPlansProvider.notifier).loadMenuPlansIfNeeded();

    // Load wishlists for the shopping list card
    ref.read(wishlistsProvider.notifier).loadWishlistsIfNeeded();

    // Load expenses for the expenses summary card
    ref.read(expensesProvider.notifier).loadExpensesIfNeeded();

    // Load calendar events for the upcoming events card
    ref.read(calendarProvider.notifier).loadEventsIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.householdSettings),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(AppRoutes.profile),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshAll,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSizes.paddingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting section
              _buildGreeting(context, authState),
              const SizedBox(height: AppSizes.lg),

              // Today's Menu Card
              const TodaysMenuCard(),
              const SizedBox(height: AppSizes.md),

              // Shopping List Quick Access
              const ShoppingListCard(),
              const SizedBox(height: AppSizes.md),

              // Expenses Summary
              const ExpensesSummaryCard(),
              const SizedBox(height: AppSizes.md),

              // Upcoming Events
              const UpcomingEventsCard(),

              // Space for FAB
              const SizedBox(height: AppSizes.xxl * 2),
            ],
          ),
        ),
      ),
      floatingActionButton: const QuickActionsFab(),
    );
  }

  Widget _buildGreeting(BuildContext context, AuthState authState) {
    String userName = 'Usuario';

    if (authState is AuthStateAuthenticated) {
      final name = authState.user.name;
      // Get first name only
      userName = name.split(' ').first;
    }

    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Buenos dias';
    } else if (hour < 19) {
      greeting = 'Buenas tardes';
    } else {
      greeting = 'Buenas noches';
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting,',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        Text(
          userName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Future<void> _refreshAll() async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return;

    final today = DateTime.now();
    final weekStart = DateTime(today.year, today.month, today.day);

    await Future.wait([
      ref.read(upcomingMealsProvider.notifier).loadWeek(weekStart),
      ref.read(menuPlansProvider.notifier).loadMenuPlans(),
      ref.read(wishlistsProvider.notifier).loadWishlists(),
      ref.read(expensesProvider.notifier).loadExpenses(),
      ref.read(calendarProvider.notifier).loadEvents(),
    ]);
  }
}
