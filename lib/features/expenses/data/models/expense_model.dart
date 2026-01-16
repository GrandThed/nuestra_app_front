import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

/// Converter for Decimal fields that may come as String or num from Prisma
class DecimalConverter implements JsonConverter<double, Object?> {
  const DecimalConverter();

  @override
  double fromJson(Object? json) {
    if (json == null) return 0.0;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json) ?? 0.0;
    return 0.0;
  }

  @override
  Object toJson(double object) => object;
}

/// Converter for nullable Decimal fields
class NullableDecimalConverter implements JsonConverter<double?, Object?> {
  const NullableDecimalConverter();

  @override
  double? fromJson(Object? json) {
    if (json == null) return null;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json);
    return null;
  }

  @override
  Object? toJson(double? object) => object;
}

/// Model for an expense category
@freezed
sealed class ExpenseCategoryModel with _$ExpenseCategoryModel {
  const factory ExpenseCategoryModel({
    required String id,
    required String name,
    String? icon,
    @Default(0) int expenseCount,
  }) = _ExpenseCategoryModel;

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryModelFromJson(json);
}

/// Minimal user model for expense references
@freezed
sealed class ExpenseUserModel with _$ExpenseUserModel {
  const factory ExpenseUserModel({
    required String id,
    required String name,
    String? avatarUrl,
  }) = _ExpenseUserModel;

  factory ExpenseUserModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseUserModelFromJson(json);
}

/// Model for an expense split (how much each member owes)
@freezed
sealed class ExpenseSplitModel with _$ExpenseSplitModel {
  const factory ExpenseSplitModel({
    required String id,
    required String userId,
    ExpenseUserModel? user,
    @DecimalConverter() required double amount,
    @Default(false) bool settled,
  }) = _ExpenseSplitModel;

  factory ExpenseSplitModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSplitModelFromJson(json);
}

/// Model for an expense
@freezed
sealed class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    required String id,
    required String householdId,
    required String description,
    @DecimalConverter() required double amount,
    @Default('ARS') String currency,
    required DateTime date,
    String? receiptUrl,
    ExpenseCategoryModel? category,
    required ExpenseUserModel paidBy,
    @Default([]) List<ExpenseSplitModel> splits,
    @Default(false) bool allSettled,
    DateTime? createdAt,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}

/// Model for expense period (month/year)
@freezed
sealed class ExpensePeriodModel with _$ExpensePeriodModel {
  const factory ExpensePeriodModel({
    required int month,
    required int year,
  }) = _ExpensePeriodModel;

  factory ExpensePeriodModel.fromJson(Map<String, dynamic> json) =>
      _$ExpensePeriodModelFromJson(json);
}

/// Model for category breakdown in summary
@freezed
sealed class ExpenseCategoryBreakdownModel with _$ExpenseCategoryBreakdownModel {
  const factory ExpenseCategoryBreakdownModel({
    required String name,
    String? icon,
    @DecimalConverter() required double total,
    required int count,
  }) = _ExpenseCategoryBreakdownModel;

  factory ExpenseCategoryBreakdownModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryBreakdownModelFromJson(json);
}

/// Model for member balance in summary
@freezed
sealed class MemberBalanceModel with _$MemberBalanceModel {
  const factory MemberBalanceModel({
    required String userId,
    required String name,
    String? avatarUrl,
    @DecimalConverter() required double paid,
    @DecimalConverter() required double owes,
    @DecimalConverter() required double balance,
  }) = _MemberBalanceModel;

  factory MemberBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$MemberBalanceModelFromJson(json);
}

/// Model for settlement suggestion
@freezed
sealed class SettlementModel with _$SettlementModel {
  const factory SettlementModel({
    required ExpenseUserModel from,
    required ExpenseUserModel to,
    @DecimalConverter() required double amount,
  }) = _SettlementModel;

  factory SettlementModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementModelFromJson(json);
}

/// Model for expense summary
@freezed
sealed class ExpenseSummaryModel with _$ExpenseSummaryModel {
  const factory ExpenseSummaryModel({
    required ExpensePeriodModel period,
    @DecimalConverter() required double totalAmount,
    required int expenseCount,
    @Default([]) List<ExpenseCategoryBreakdownModel> byCategory,
    @Default([]) List<MemberBalanceModel> memberBalances,
    @Default([]) List<SettlementModel> settlements,
  }) = _ExpenseSummaryModel;

  factory ExpenseSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSummaryModelFromJson(json);
}

/// Model for settle period response
@freezed
sealed class SettlePeriodResultModel with _$SettlePeriodResultModel {
  const factory SettlePeriodResultModel({
    required int settledCount,
    required int expensesAffected,
  }) = _SettlePeriodResultModel;

  factory SettlePeriodResultModel.fromJson(Map<String, dynamic> json) =>
      _$SettlePeriodResultModelFromJson(json);
}
