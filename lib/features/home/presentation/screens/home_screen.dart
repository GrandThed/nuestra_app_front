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
import 'package:nuestra_app/features/tasks/presentation/providers/tasks_notifier.dart';
import 'package:nuestra_app/features/home/presentation/widgets/pending_tasks_card.dart';
import 'package:nuestra_app/features/home/presentation/providers/home_card_order_notifier.dart';

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

    // Load pending tasks
    ref.read(tasksProvider.notifier).loadTasksIfNeeded();
  }

  Widget _buildCard(String cardId) {
    return switch (cardId) {
      'menu' => const TodaysMenuCard(),
      'tasks' => const PendingTasksCard(),
      'shopping' => const ShoppingListCard(),
      'expenses' => const ExpensesSummaryCard(),
      'events' => const UpcomingEventsCard(),
      _ => const SizedBox.shrink(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final cardOrder = ref.watch(homeCardOrderProvider);

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
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Greeting (not reorderable)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.paddingMd,
                  AppSizes.paddingMd,
                  AppSizes.paddingMd,
                  AppSizes.lg,
                ),
                child: _buildGreeting(context, authState),
              ),
            ),
            // Reorderable cards
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd),
              sliver: SliverReorderableList(
                itemCount: cardOrder.length,
                onReorder: (oldIndex, newIndex) {
                  ref.read(homeCardOrderProvider.notifier).reorder(oldIndex, newIndex);
                },
                itemBuilder: (context, index) {
                  final cardId = cardOrder[index];
                  return ReorderableDragStartListener(
                    key: ValueKey(cardId),
                    index: index,
                    enabled: true,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.md),
                      child: _buildCard(cardId),
                    ),
                  );
                },
              ),
            ),
            // Space for FAB
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSizes.xxl * 2),
            ),
          ],
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
      ref.read(tasksProvider.notifier).loadTasks(),
    ]);
  }
}
