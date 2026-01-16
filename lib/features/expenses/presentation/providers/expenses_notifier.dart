import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/data/repositories/expense_repository.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';

part 'expenses_notifier.g.dart';

/// Notifier for expenses operations (categories + expenses combined)
@Riverpod(keepAlive: true)
class ExpensesNotifier extends _$ExpensesNotifier {
  late final ExpenseRepository _repository;

  @override
  ExpensesState build() {
    _repository = ref.watch(expenseRepositoryProvider);
    return const ExpensesState.initial();
  }

  /// Load expenses only if not already loaded (for screen init)
  Future<void> loadExpensesIfNeeded() async {
    if (state is ExpensesStateInitial || state is ExpensesStateError) {
      await loadExpenses();
    }
  }

  /// Load all categories and expenses for current household
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadExpenses({
    bool forceLoading = false,
    int? month,
    int? year,
    String? categoryId,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const ExpensesState.error('No hay hogar seleccionado');
      return;
    }

    // Use provided month/year or current/existing values
    final now = DateTime.now();
    final currentState = state;
    final selectedMonth = month ??
        (currentState is ExpensesStateLoaded
            ? currentState.selectedMonth
            : now.month);
    final selectedYear = year ??
        (currentState is ExpensesStateLoaded
            ? currentState.selectedYear
            : now.year);
    final selectedCategoryId = categoryId ??
        (currentState is ExpensesStateLoaded
            ? currentState.selectedCategoryId
            : null);

    final hasData = currentState is ExpensesStateLoaded;
    if (!hasData || forceLoading) {
      state = const ExpensesState.loading();
    }

    try {
      final results = await Future.wait([
        _repository.getCategories(householdId),
        _repository.getExpenses(
          householdId,
          month: selectedMonth,
          year: selectedYear,
          categoryId: selectedCategoryId,
        ),
      ]);

      final categories = results[0] as List<ExpenseCategoryModel>;
      final expenses = results[1] as List<ExpenseModel>;

      state = ExpensesState.loaded(
        categories: categories,
        expenses: expenses,
        selectedMonth: selectedMonth,
        selectedYear: selectedYear,
        selectedCategoryId: selectedCategoryId,
      );
    } on AppException catch (e) {
      if (!hasData) {
        state = ExpensesState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = ExpensesState.error('Error al cargar gastos: $e');
      }
    }
  }

  /// Change selected month/year and reload expenses
  Future<void> setMonth(int month, int year) async {
    await loadExpenses(month: month, year: year);
  }

  /// Change selected category filter
  Future<void> setCategoryFilter(String? categoryId) async {
    await loadExpenses(categoryId: categoryId);
  }

  // ==================== CATEGORY OPERATIONS ====================

  /// Create a new category
  Future<ExpenseCategoryModel?> createCategory({
    required String name,
    String? icon,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final category = await _repository.createCategory(
        householdId: householdId,
        name: name,
        icon: icon,
      );

      // Add to current list
      final currentState = state;
      if (currentState is ExpensesStateLoaded) {
        state = ExpensesState.loaded(
          categories: [...currentState.categories, category],
          expenses: currentState.expenses,
          selectedMonth: currentState.selectedMonth,
          selectedYear: currentState.selectedYear,
          selectedCategoryId: currentState.selectedCategoryId,
        );
      }

      return category;
    } on AppException catch (e) {
      debugPrint('Error creating category: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error creating category: $e');
      return null;
    }
  }

  /// Update a category
  Future<ExpenseCategoryModel?> updateCategory({
    required String id,
    String? name,
    String? icon,
  }) async {
    try {
      final category = await _repository.updateCategory(
        id: id,
        name: name,
        icon: icon,
      );

      // Update in current list
      final currentState = state;
      if (currentState is ExpensesStateLoaded) {
        final updatedCategories = currentState.categories.map((c) {
          return c.id == id ? category : c;
        }).toList();
        state = ExpensesState.loaded(
          categories: updatedCategories,
          expenses: currentState.expenses,
          selectedMonth: currentState.selectedMonth,
          selectedYear: currentState.selectedYear,
          selectedCategoryId: currentState.selectedCategoryId,
        );
      }

      return category;
    } on AppException catch (e) {
      debugPrint('Error updating category: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error updating category: $e');
      return null;
    }
  }

  /// Delete a category
  Future<bool> deleteCategory(String id) async {
    try {
      await _repository.deleteCategory(id);

      // Remove from current list, expenses keep their data but category becomes null
      final currentState = state;
      if (currentState is ExpensesStateLoaded) {
        final updatedCategories =
            currentState.categories.where((c) => c.id != id).toList();
        state = ExpensesState.loaded(
          categories: updatedCategories,
          expenses: currentState.expenses,
          selectedMonth: currentState.selectedMonth,
          selectedYear: currentState.selectedYear,
          selectedCategoryId: currentState.selectedCategoryId == id
              ? null
              : currentState.selectedCategoryId,
        );
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting category: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting category: $e');
      return false;
    }
  }

  // ==================== EXPENSE OPERATIONS ====================

  /// Create a new expense
  Future<ExpenseModel?> createExpense({
    required String description,
    required double amount,
    required DateTime date,
    String currency = 'ARS',
    String? categoryId,
    String? receiptUrl,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final expense = await _repository.createExpense(
        householdId: householdId,
        description: description,
        amount: amount,
        date: date,
        currency: currency,
        categoryId: categoryId,
        receiptUrl: receiptUrl,
      );

      // Add to current list if in the same month/year
      final currentState = state;
      if (currentState is ExpensesStateLoaded) {
        final expenseMonth = date.month;
        final expenseYear = date.year;
        if (expenseMonth == currentState.selectedMonth &&
            expenseYear == currentState.selectedYear) {
          state = ExpensesState.loaded(
            categories: currentState.categories,
            expenses: [expense, ...currentState.expenses],
            selectedMonth: currentState.selectedMonth,
            selectedYear: currentState.selectedYear,
            selectedCategoryId: currentState.selectedCategoryId,
          );
        }
      }

      return expense;
    } on AppException catch (e) {
      debugPrint('Error creating expense: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error creating expense: $e');
      return null;
    }
  }

  /// Update an expense
  Future<ExpenseModel?> updateExpense({
    required String id,
    String? description,
    double? amount,
    String? currency,
    DateTime? date,
    String? categoryId,
    String? receiptUrl,
  }) async {
    try {
      final expense = await _repository.updateExpense(
        id: id,
        description: description,
        amount: amount,
        currency: currency,
        date: date,
        categoryId: categoryId,
        receiptUrl: receiptUrl,
      );

      // Update in current list
      final currentState = state;
      if (currentState is ExpensesStateLoaded) {
        final updatedExpenses = currentState.expenses.map((e) {
          return e.id == id ? expense : e;
        }).toList();
        state = ExpensesState.loaded(
          categories: currentState.categories,
          expenses: updatedExpenses,
          selectedMonth: currentState.selectedMonth,
          selectedYear: currentState.selectedYear,
          selectedCategoryId: currentState.selectedCategoryId,
        );
      }

      return expense;
    } on AppException catch (e) {
      debugPrint('Error updating expense: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error updating expense: $e');
      return null;
    }
  }

  /// Delete an expense
  Future<bool> deleteExpense(String id) async {
    try {
      await _repository.deleteExpense(id);

      // Remove from current list
      final currentState = state;
      if (currentState is ExpensesStateLoaded) {
        final updatedExpenses =
            currentState.expenses.where((e) => e.id != id).toList();
        state = ExpensesState.loaded(
          categories: currentState.categories,
          expenses: updatedExpenses,
          selectedMonth: currentState.selectedMonth,
          selectedYear: currentState.selectedYear,
          selectedCategoryId: currentState.selectedCategoryId,
        );
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting expense: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting expense: $e');
      return false;
    }
  }

  /// Settle an expense (mark splits as settled)
  Future<ExpenseModel?> settleExpense({
    required String id,
    String? userId,
    bool settled = true,
  }) async {
    try {
      final expense = await _repository.settleExpense(
        id: id,
        userId: userId,
        settled: settled,
      );

      // Update in current list
      final currentState = state;
      if (currentState is ExpensesStateLoaded) {
        final updatedExpenses = currentState.expenses.map((e) {
          return e.id == id ? expense : e;
        }).toList();
        state = ExpensesState.loaded(
          categories: currentState.categories,
          expenses: updatedExpenses,
          selectedMonth: currentState.selectedMonth,
          selectedYear: currentState.selectedYear,
          selectedCategoryId: currentState.selectedCategoryId,
        );
      }

      return expense;
    } on AppException catch (e) {
      debugPrint('Error settling expense: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error settling expense: $e');
      return null;
    }
  }
}

/// Notifier for expense summary
@Riverpod(keepAlive: true)
class ExpenseSummaryNotifier extends _$ExpenseSummaryNotifier {
  late final ExpenseRepository _repository;

  @override
  ExpenseSummaryState build() {
    _repository = ref.watch(expenseRepositoryProvider);
    return const ExpenseSummaryState.initial();
  }

  /// Load summary only if not already loaded
  Future<void> loadSummaryIfNeeded({int? month, int? year}) async {
    if (state is ExpenseSummaryStateInitial ||
        state is ExpenseSummaryStateError) {
      await loadSummary(month: month, year: year);
    }
  }

  /// Load expense summary
  Future<void> loadSummary({
    bool forceLoading = false,
    int? month,
    int? year,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const ExpenseSummaryState.error('No hay hogar seleccionado');
      return;
    }

    final hasData = state is ExpenseSummaryStateLoaded;
    if (!hasData || forceLoading) {
      state = const ExpenseSummaryState.loading();
    }

    try {
      final summary = await _repository.getSummary(
        householdId,
        month: month,
        year: year,
      );

      state = ExpenseSummaryState.loaded(summary);
    } on AppException catch (e) {
      if (!hasData) {
        state = ExpenseSummaryState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = ExpenseSummaryState.error('Error al cargar resumen: $e');
      }
    }
  }

  /// Settle all expenses in a period
  Future<SettlePeriodResultModel?> settlePeriod({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final result = await _repository.settlePeriod(
        householdId: householdId,
        fromDate: fromDate,
        toDate: toDate,
      );

      // Reload summary after settling
      await loadSummary(forceLoading: true);

      return result;
    } on AppException catch (e) {
      debugPrint('Error settling period: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error settling period: $e');
      return null;
    }
  }
}

/// Provider for total expenses in current month
@riverpod
double totalExpensesAmount(Ref ref) {
  final state = ref.watch(expensesNotifierProvider);
  if (state is ExpensesStateLoaded) {
    return state.expenses.fold(0.0, (sum, e) => sum + e.amount);
  }
  return 0.0;
}

/// Provider for unsettled expenses count
@riverpod
int unsettledExpensesCount(Ref ref) {
  final state = ref.watch(expensesNotifierProvider);
  if (state is ExpensesStateLoaded) {
    return state.expenses.where((e) => !e.allSettled).length;
  }
  return 0;
}

/// Provider for expenses filtered by category
@riverpod
List<ExpenseModel> expensesByCategory(Ref ref, String? categoryId) {
  final state = ref.watch(expensesNotifierProvider);
  if (state is ExpensesStateLoaded) {
    if (categoryId == null) {
      return state.expenses;
    }
    return state.expenses.where((e) => e.category?.id == categoryId).toList();
  }
  return [];
}
