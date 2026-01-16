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
