import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';

part 'expenses_state.freezed.dart';

/// Combined state for expenses screen (categories + expenses)
@freezed
sealed class ExpensesState with _$ExpensesState {
  const factory ExpensesState.initial() = ExpensesStateInitial;
  const factory ExpensesState.loading() = ExpensesStateLoading;
  const factory ExpensesState.loaded({
    required List<ExpenseCategoryModel> categories,
    required List<ExpenseModel> expenses,
    required int selectedMonth,
    required int selectedYear,
    String? selectedCategoryId,
  }) = ExpensesStateLoaded;
  const factory ExpensesState.error(String message) = ExpensesStateError;
}

/// State for expense summary
@freezed
sealed class ExpenseSummaryState with _$ExpenseSummaryState {
  const factory ExpenseSummaryState.initial() = ExpenseSummaryStateInitial;
  const factory ExpenseSummaryState.loading() = ExpenseSummaryStateLoading;
  const factory ExpenseSummaryState.loaded(ExpenseSummaryModel summary) = ExpenseSummaryStateLoaded;
  const factory ExpenseSummaryState.error(String message) = ExpenseSummaryStateError;
}

/// State for a single expense detail
@freezed
sealed class ExpenseDetailState with _$ExpenseDetailState {
  const factory ExpenseDetailState.initial() = ExpenseDetailStateInitial;
  const factory ExpenseDetailState.loading() = ExpenseDetailStateLoading;
  const factory ExpenseDetailState.loaded(ExpenseModel expense) = ExpenseDetailStateLoaded;
  const factory ExpenseDetailState.error(String message) = ExpenseDetailStateError;
}

/// State for recurring expenses
@freezed
sealed class RecurringExpensesState with _$RecurringExpensesState {
  const factory RecurringExpensesState.initial() = RecurringExpensesStateInitial;
  const factory RecurringExpensesState.loading() = RecurringExpensesStateLoading;
  const factory RecurringExpensesState.loaded(List<RecurringExpenseModel> expenses) = RecurringExpensesStateLoaded;
  const factory RecurringExpensesState.error(String message) = RecurringExpensesStateError;
}

/// State for budget status
@freezed
sealed class BudgetState with _$BudgetState {
  const factory BudgetState.initial() = BudgetStateInitial;
  const factory BudgetState.loading() = BudgetStateLoading;
  const factory BudgetState.loaded(List<BudgetStatusModel> budgets) = BudgetStateLoaded;
  const factory BudgetState.error(String message) = BudgetStateError;
}

/// State for expense trends
@freezed
sealed class ExpenseTrendsState with _$ExpenseTrendsState {
  const factory ExpenseTrendsState.initial() = ExpenseTrendsStateInitial;
  const factory ExpenseTrendsState.loading() = ExpenseTrendsStateLoading;
  const factory ExpenseTrendsState.loaded(List<ExpenseTrendModel> trends) = ExpenseTrendsStateLoaded;
  const factory ExpenseTrendsState.error(String message) = ExpenseTrendsStateError;
}
