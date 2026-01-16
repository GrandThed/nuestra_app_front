import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';

/// Provider for ExpenseRepository
final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository(dioClient: ref.watch(dioClientProvider));
});

/// Repository for expense operations
class ExpenseRepository {
  final DioClient _dioClient;

  ExpenseRepository({required DioClient dioClient}) : _dioClient = dioClient;

  // ==================== CATEGORIES ====================

  /// Get all expense categories for a household
  Future<List<ExpenseCategoryModel>> getCategories(String householdId) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.expenseCategories,
      queryParameters: {'householdId': householdId},
    );

    final categories = response['data']['categories'] as List<dynamic>? ?? [];
    return categories
        .map((c) => ExpenseCategoryModel.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  /// Create a new expense category
  Future<ExpenseCategoryModel> createCategory({
    required String householdId,
    required String name,
    String? icon,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.expenseCategories,
      data: {
        'householdId': householdId,
        'name': name,
        if (icon != null) 'icon': icon,
      },
    );

    return ExpenseCategoryModel.fromJson(
        response['data']['category'] as Map<String, dynamic>);
  }

  /// Update an expense category
  Future<ExpenseCategoryModel> updateCategory({
    required String id,
    String? name,
    String? icon,
  }) async {
    final response = await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.expenseCategory(id),
      data: {
        if (name != null) 'name': name,
        if (icon != null) 'icon': icon,
      },
    );

    return ExpenseCategoryModel.fromJson(
        response['data']['category'] as Map<String, dynamic>);
  }

  /// Delete an expense category
  Future<void> deleteCategory(String id) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.expenseCategory(id),
    );
  }

  // ==================== EXPENSES ====================

  /// Get expenses for a household with optional filters
  Future<List<ExpenseModel>> getExpenses(
    String householdId, {
    String? categoryId,
    String? paidById,
    int? month,
    int? year,
    bool? settled,
  }) async {
    final queryParams = <String, dynamic>{
      'householdId': householdId,
    };
    if (categoryId != null) queryParams['categoryId'] = categoryId;
    if (paidById != null) queryParams['paidById'] = paidById;
    if (month != null) queryParams['month'] = month.toString();
    if (year != null) queryParams['year'] = year.toString();
    if (settled != null) queryParams['settled'] = settled.toString();

    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.expenses,
      queryParameters: queryParams,
    );

    final expenses = response['data']['expenses'] as List<dynamic>? ?? [];
    return expenses
        .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get a single expense by ID
  Future<ExpenseModel> getExpense(String id) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.expense(id),
    );

    return ExpenseModel.fromJson(
        response['data']['expense'] as Map<String, dynamic>);
  }

  /// Create a new expense
  Future<ExpenseModel> createExpense({
    required String householdId,
    required String description,
    required double amount,
    required DateTime date,
    String currency = 'ARS',
    String? categoryId,
    String? receiptUrl,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.expenses,
      data: {
        'householdId': householdId,
        'description': description,
        'amount': amount,
        'currency': currency,
        'date': date.toIso8601String(),
        if (categoryId != null) 'categoryId': categoryId,
        if (receiptUrl != null) 'receiptUrl': receiptUrl,
      },
    );

    return ExpenseModel.fromJson(
        response['data']['expense'] as Map<String, dynamic>);
  }

  /// Update an expense
  Future<ExpenseModel> updateExpense({
    required String id,
    String? description,
    double? amount,
    String? currency,
    DateTime? date,
    String? categoryId,
    String? receiptUrl,
  }) async {
    final response = await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.expense(id),
      data: {
        if (description != null) 'description': description,
        if (amount != null) 'amount': amount,
        if (currency != null) 'currency': currency,
        if (date != null) 'date': date.toIso8601String(),
        if (categoryId != null) 'categoryId': categoryId,
        if (receiptUrl != null) 'receiptUrl': receiptUrl,
      },
    );

    return ExpenseModel.fromJson(
        response['data']['expense'] as Map<String, dynamic>);
  }

  /// Delete an expense
  Future<void> deleteExpense(String id) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.expense(id),
    );
  }

  // ==================== SETTLEMENTS ====================

  /// Settle an expense (mark splits as settled)
  /// If userId is provided, settles only that user's split
  /// If userId is null, settles all splits
  Future<ExpenseModel> settleExpense({
    required String id,
    String? userId,
    bool settled = true,
  }) async {
    final response = await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.expenseSettle(id),
      data: {
        if (userId != null) 'userId': userId,
        'settled': settled,
      },
    );

    return ExpenseModel.fromJson(
        response['data']['expense'] as Map<String, dynamic>);
  }

  /// Settle all expenses in a date range
  Future<SettlePeriodResultModel> settlePeriod({
    required String householdId,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.expenseSettlePeriod,
      data: {
        'householdId': householdId,
        'fromDate': fromDate.toIso8601String().split('T').first,
        'toDate': toDate.toIso8601String().split('T').first,
      },
    );

    return SettlePeriodResultModel.fromJson(
        response['data'] as Map<String, dynamic>);
  }

  // ==================== SUMMARY ====================

  /// Get expense summary for a household
  Future<ExpenseSummaryModel> getSummary(
    String householdId, {
    int? month,
    int? year,
    bool? settledOnly,
  }) async {
    final queryParams = <String, dynamic>{
      'householdId': householdId,
    };
    if (month != null) queryParams['month'] = month.toString();
    if (year != null) queryParams['year'] = year.toString();
    if (settledOnly != null) queryParams['settledOnly'] = settledOnly.toString();

    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.expenseSummary,
      queryParameters: queryParams,
    );

    return ExpenseSummaryModel.fromJson(
        response['data'] as Map<String, dynamic>);
  }
}
