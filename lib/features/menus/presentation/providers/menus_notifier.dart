import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';
import 'package:nuestra_app/features/menus/data/repositories/menu_repository.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_state.dart';

part 'menus_notifier.g.dart';

/// Notifier for menu plans list
@Riverpod(keepAlive: true)
class MenuPlansNotifier extends _$MenuPlansNotifier {
  late final MenuRepository _repository;

  @override
  MenuPlansState build() {
    _repository = ref.watch(menuRepositoryProvider);
    return const MenuPlansState.initial();
  }

  /// Load menu plans only if not already loaded (for screen init)
  Future<void> loadMenuPlansIfNeeded() async {
    if (state is MenuPlansStateInitial || state is MenuPlansStateError) {
      await loadMenuPlans();
    }
  }

  /// Load all menu plans for current household
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadMenuPlans({bool forceLoading = false}) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const MenuPlansState.error('No hay hogar seleccionado');
      return;
    }

    final hasData = state is MenuPlansStateLoaded;
    if (!hasData || forceLoading) {
      state = const MenuPlansState.loading();
    }

    try {
      final plans = await _repository.getMenuPlans(householdId);
      state = MenuPlansState.loaded(plans);
    } on AppException catch (e) {
      if (!hasData) {
        state = MenuPlansState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = MenuPlansState.error('Error al cargar menús: $e');
      }
    }
  }

  /// Create a new menu plan
  Future<MenuPlanModel?> createMenuPlan({String? name}) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final plan = await _repository.createMenuPlan(
        householdId: householdId,
        name: name,
      );

      // Add to current list
      final currentState = state;
      if (currentState is MenuPlansStateLoaded) {
        state = MenuPlansState.loaded([plan, ...currentState.plans]);
      } else {
        state = MenuPlansState.loaded([plan]);
      }

      return plan;
    } on AppException catch (e) {
      debugPrint('Error creating menu plan: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error creating menu plan: $e');
      return null;
    }
  }

  /// Delete a menu plan
  Future<bool> deleteMenuPlan(String id) async {
    try {
      await _repository.deleteMenuPlan(id);

      // Remove from current list
      final currentState = state;
      if (currentState is MenuPlansStateLoaded) {
        final updatedPlans =
            currentState.plans.where((p) => p.id != id).toList();
        state = MenuPlansState.loaded(updatedPlans);
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting menu plan: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting menu plan: $e');
      return false;
    }
  }

  /// Update menu plan in list
  void updateMenuPlanInList(MenuPlanModel plan) {
    final currentState = state;
    if (currentState is MenuPlansStateLoaded) {
      final updatedPlans = currentState.plans.map((p) {
        return p.id == plan.id ? plan : p;
      }).toList();
      state = MenuPlansState.loaded(updatedPlans);
    }
  }
}

/// Notifier for upcoming meals (weekly view)
@Riverpod(keepAlive: true)
class UpcomingMealsNotifier extends _$UpcomingMealsNotifier {
  late final MenuRepository _repository;

  @override
  UpcomingMealsState build() {
    _repository = ref.watch(menuRepositoryProvider);
    return const UpcomingMealsState.initial();
  }

  /// Load week only if not already loaded or if week changed
  Future<void> loadWeekIfNeeded(DateTime weekStart) async {
    final currentState = state;
    if (currentState is UpcomingMealsStateLoaded) {
      // Check if same week
      if (currentState.weekStart == weekStart) return;
    }
    if (state is UpcomingMealsStateInitial || state is UpcomingMealsStateError) {
      await loadWeek(weekStart);
    }
  }

  /// Load upcoming meals for a week
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadWeek(DateTime weekStart, {bool forceLoading = false}) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const UpcomingMealsState.error('No hay hogar seleccionado');
      return;
    }

    final hasData = state is UpcomingMealsStateLoaded;
    if (!hasData || forceLoading) {
      state = const UpcomingMealsState.loading();
    }

    try {
      final weekEnd = weekStart.add(const Duration(days: 6));
      final items = await _repository.getUpcomingMeals(
        householdId,
        from: weekStart,
        to: weekEnd,
      );
      state = UpcomingMealsState.loaded(items, weekStart);
    } on AppException catch (e) {
      if (!hasData) {
        state = UpcomingMealsState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = UpcomingMealsState.error('Error al cargar comidas: $e');
      }
    }
  }

  /// Get meals for a specific date
  List<MenuItemModel> getMealsForDate(DateTime date) {
    final currentState = state;
    if (currentState is! UpcomingMealsStateLoaded) return [];

    return currentState.items.where((item) {
      return item.date.year == date.year &&
          item.date.month == date.month &&
          item.date.day == date.day;
    }).toList();
  }

  /// Add meal to current week view
  void addMealToView(MenuItemModel meal) {
    final currentState = state;
    if (currentState is UpcomingMealsStateLoaded) {
      state = UpcomingMealsState.loaded(
        [...currentState.items, meal],
        currentState.weekStart,
      );
    }
  }

  /// Remove meal from current week view
  void removeMealFromView(String itemId) {
    final currentState = state;
    if (currentState is UpcomingMealsStateLoaded) {
      final updatedItems =
          currentState.items.where((i) => i.id != itemId).toList();
      state = UpcomingMealsState.loaded(updatedItems, currentState.weekStart);
    }
  }

  /// Update meal in current week view
  void updateMealInView(MenuItemModel meal) {
    final currentState = state;
    if (currentState is UpcomingMealsStateLoaded) {
      final updatedItems = currentState.items.map((i) {
        return i.id == meal.id ? meal : i;
      }).toList();
      state = UpcomingMealsState.loaded(updatedItems, currentState.weekStart);
    }
  }
}

/// Notifier for single menu plan detail
@Riverpod(keepAlive: true)
class MenuPlanDetailNotifier extends _$MenuPlanDetailNotifier {
  late final MenuRepository _repository;

  @override
  MenuPlanDetailState build(String menuId) {
    _repository = ref.watch(menuRepositoryProvider);
    return const MenuPlanDetailState.initial();
  }

  /// Load menu plan only if not already loaded
  Future<void> loadMenuPlanIfNeeded() async {
    if (state is MenuPlanDetailStateInitial || state is MenuPlanDetailStateError) {
      await loadMenuPlan();
    }
  }

  /// Load menu plan detail
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadMenuPlan({bool forceLoading = false}) async {
    final hasData = state is MenuPlanDetailStateLoaded;

    if (!hasData || forceLoading) {
      state = const MenuPlanDetailState.loading();
    }

    try {
      final plan = await _repository.getMenuPlan(menuId);
      state = MenuPlanDetailState.loaded(plan);
    } on AppException catch (e) {
      if (!hasData) {
        state = MenuPlanDetailState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = MenuPlanDetailState.error('Error al cargar menú: $e');
      }
    }
  }

  /// Add a meal to the plan
  Future<MenuItemModel?> addMeal({
    required String recipeId,
    required DateTime date,
    required String mealType,
    Map<String, dynamic>? substitutions,
  }) async {
    try {
      final item = await _repository.addMenuItem(
        menuId: menuId,
        recipeId: recipeId,
        date: date,
        mealType: mealType,
        substitutions: substitutions,
      );

      // Update state
      final currentState = state;
      if (currentState is MenuPlanDetailStateLoaded) {
        final currentItems = currentState.plan.items ?? [];
        final updatedPlan = currentState.plan.copyWith(
          items: [...currentItems, item],
        );
        state = MenuPlanDetailState.loaded(updatedPlan);
      }

      return item;
    } on AppException catch (e) {
      debugPrint('Error adding meal: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error adding meal: $e');
      return null;
    }
  }

  /// Update a meal in the plan
  Future<MenuItemModel?> updateMeal({
    required String itemId,
    DateTime? date,
    String? mealType,
    String? recipeId,
    Map<String, dynamic>? substitutions,
  }) async {
    try {
      final item = await _repository.updateMenuItem(
        menuId: menuId,
        itemId: itemId,
        date: date,
        mealType: mealType,
        recipeId: recipeId,
        substitutions: substitutions,
      );

      // Update state
      final currentState = state;
      if (currentState is MenuPlanDetailStateLoaded) {
        final updatedItems = currentState.plan.items?.map((i) {
          return i.id == item.id ? item : i;
        }).toList();
        final updatedPlan = currentState.plan.copyWith(items: updatedItems);
        state = MenuPlanDetailState.loaded(updatedPlan);
      }

      return item;
    } on AppException catch (e) {
      debugPrint('Error updating meal: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error updating meal: $e');
      return null;
    }
  }

  /// Delete a meal from the plan
  Future<bool> deleteMeal(String itemId) async {
    try {
      await _repository.deleteMenuItem(menuId: menuId, itemId: itemId);

      // Update state
      final currentState = state;
      if (currentState is MenuPlanDetailStateLoaded) {
        final updatedItems =
            currentState.plan.items?.where((i) => i.id != itemId).toList();
        final updatedPlan = currentState.plan.copyWith(items: updatedItems);
        state = MenuPlanDetailState.loaded(updatedPlan);
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting meal: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting meal: $e');
      return false;
    }
  }

  /// Generate shopping list from this menu plan
  Future<ShoppingListResultModel?> generateShoppingList({
    double servingsMultiplier = 1.0,
  }) async {
    try {
      final result = await _repository.generateShoppingList(
        menuId: menuId,
        servingsMultiplier: servingsMultiplier,
      );
      return result;
    } on AppException catch (e) {
      debugPrint('Error generating shopping list: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error generating shopping list: $e');
      return null;
    }
  }
}

/// Provider for selected week start date
@riverpod
class SelectedWeekStart extends _$SelectedWeekStart {
  @override
  DateTime build() {
    // Start from current week's Monday
    final now = DateTime.now();
    final weekday = now.weekday;
    return DateTime(now.year, now.month, now.day - (weekday - 1));
  }

  void setWeek(DateTime date) {
    // Normalize to Monday of that week
    final weekday = date.weekday;
    state = DateTime(date.year, date.month, date.day - (weekday - 1));
  }

  void nextWeek() {
    state = state.add(const Duration(days: 7));
  }

  void previousWeek() {
    state = state.subtract(const Duration(days: 7));
  }
}

/// Provider for currently selected menu plan ID
@Riverpod(keepAlive: true)
class CurrentMenuPlanId extends _$CurrentMenuPlanId {
  @override
  String? build() => null;

  void setMenuPlan(String? id) {
    state = id;
  }
}
