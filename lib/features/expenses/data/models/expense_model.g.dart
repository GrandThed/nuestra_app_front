// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseCategoryModel _$ExpenseCategoryModelFromJson(
  Map<String, dynamic> json,
) => _ExpenseCategoryModel(
  id: json['id'] as String,
  name: json['name'] as String,
  icon: json['icon'] as String?,
  expenseCount: (json['expenseCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ExpenseCategoryModelToJson(
  _ExpenseCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
  'expenseCount': instance.expenseCount,
};

_ExpenseUserModel _$ExpenseUserModelFromJson(Map<String, dynamic> json) =>
    _ExpenseUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$ExpenseUserModelToJson(_ExpenseUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };

_ExpenseSplitModel _$ExpenseSplitModelFromJson(Map<String, dynamic> json) =>
    _ExpenseSplitModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      user:
          json['user'] == null
              ? null
              : ExpenseUserModel.fromJson(json['user'] as Map<String, dynamic>),
      amount: const DecimalConverter().fromJson(json['amount']),
      settled: json['settled'] as bool? ?? false,
      customAmount: const NullableDecimalConverter().fromJson(
        json['customAmount'],
      ),
      isCustom: json['isCustom'] as bool? ?? false,
    );

Map<String, dynamic> _$ExpenseSplitModelToJson(_ExpenseSplitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'user': instance.user,
      'amount': const DecimalConverter().toJson(instance.amount),
      'settled': instance.settled,
      'customAmount': const NullableDecimalConverter().toJson(
        instance.customAmount,
      ),
      'isCustom': instance.isCustom,
    };

_ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) =>
    _ExpenseModel(
      id: json['id'] as String,
      householdId: json['householdId'] as String,
      description: json['description'] as String,
      amount: const DecimalConverter().fromJson(json['amount']),
      currency: json['currency'] as String? ?? 'ARS',
      date: DateTime.parse(json['date'] as String),
      receiptUrl: json['receiptUrl'] as String?,
      category:
          json['category'] == null
              ? null
              : ExpenseCategoryModel.fromJson(
                json['category'] as Map<String, dynamic>,
              ),
      paidBy: ExpenseUserModel.fromJson(json['paidBy'] as Map<String, dynamic>),
      splits:
          (json['splits'] as List<dynamic>?)
              ?.map(
                (e) => ExpenseSplitModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      allSettled: json['allSettled'] as bool? ?? false,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      recurringExpenseId: json['recurringExpenseId'] as String?,
      linkedWishlistItemId: json['linkedWishlistItemId'] as String?,
    );

Map<String, dynamic> _$ExpenseModelToJson(_ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'description': instance.description,
      'amount': const DecimalConverter().toJson(instance.amount),
      'currency': instance.currency,
      'date': instance.date.toIso8601String(),
      'receiptUrl': instance.receiptUrl,
      'category': instance.category,
      'paidBy': instance.paidBy,
      'splits': instance.splits,
      'allSettled': instance.allSettled,
      'createdAt': instance.createdAt?.toIso8601String(),
      'recurringExpenseId': instance.recurringExpenseId,
      'linkedWishlistItemId': instance.linkedWishlistItemId,
    };

_ExpensePeriodModel _$ExpensePeriodModelFromJson(Map<String, dynamic> json) =>
    _ExpensePeriodModel(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
    );

Map<String, dynamic> _$ExpensePeriodModelToJson(_ExpensePeriodModel instance) =>
    <String, dynamic>{'month': instance.month, 'year': instance.year};

_ExpenseCategoryBreakdownModel _$ExpenseCategoryBreakdownModelFromJson(
  Map<String, dynamic> json,
) => _ExpenseCategoryBreakdownModel(
  name: json['name'] as String,
  icon: json['icon'] as String?,
  total: const DecimalConverter().fromJson(json['total']),
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$ExpenseCategoryBreakdownModelToJson(
  _ExpenseCategoryBreakdownModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'icon': instance.icon,
  'total': const DecimalConverter().toJson(instance.total),
  'count': instance.count,
};

_MemberBalanceModel _$MemberBalanceModelFromJson(Map<String, dynamic> json) =>
    _MemberBalanceModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      paid: const DecimalConverter().fromJson(json['paid']),
      owes: const DecimalConverter().fromJson(json['owes']),
      balance: const DecimalConverter().fromJson(json['balance']),
    );

Map<String, dynamic> _$MemberBalanceModelToJson(_MemberBalanceModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'paid': const DecimalConverter().toJson(instance.paid),
      'owes': const DecimalConverter().toJson(instance.owes),
      'balance': const DecimalConverter().toJson(instance.balance),
    };

_SettlementModel _$SettlementModelFromJson(Map<String, dynamic> json) =>
    _SettlementModel(
      from: ExpenseUserModel.fromJson(json['from'] as Map<String, dynamic>),
      to: ExpenseUserModel.fromJson(json['to'] as Map<String, dynamic>),
      amount: const DecimalConverter().fromJson(json['amount']),
    );

Map<String, dynamic> _$SettlementModelToJson(_SettlementModel instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': const DecimalConverter().toJson(instance.amount),
    };

_ExpenseSummaryModel _$ExpenseSummaryModelFromJson(
  Map<String, dynamic> json,
) => _ExpenseSummaryModel(
  period: ExpensePeriodModel.fromJson(json['period'] as Map<String, dynamic>),
  totalAmount: const DecimalConverter().fromJson(json['totalAmount']),
  expenseCount: (json['expenseCount'] as num).toInt(),
  byCategory:
      (json['byCategory'] as List<dynamic>?)
          ?.map(
            (e) => ExpenseCategoryBreakdownModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
  memberBalances:
      (json['memberBalances'] as List<dynamic>?)
          ?.map((e) => MemberBalanceModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  settlements:
      (json['settlements'] as List<dynamic>?)
          ?.map((e) => SettlementModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ExpenseSummaryModelToJson(
  _ExpenseSummaryModel instance,
) => <String, dynamic>{
  'period': instance.period,
  'totalAmount': const DecimalConverter().toJson(instance.totalAmount),
  'expenseCount': instance.expenseCount,
  'byCategory': instance.byCategory,
  'memberBalances': instance.memberBalances,
  'settlements': instance.settlements,
};

_SettlePeriodResultModel _$SettlePeriodResultModelFromJson(
  Map<String, dynamic> json,
) => _SettlePeriodResultModel(
  settledCount: (json['settledCount'] as num).toInt(),
  expensesAffected: (json['expensesAffected'] as num).toInt(),
);

Map<String, dynamic> _$SettlePeriodResultModelToJson(
  _SettlePeriodResultModel instance,
) => <String, dynamic>{
  'settledCount': instance.settledCount,
  'expensesAffected': instance.expensesAffected,
};

_RecalculateSplitsResultModel _$RecalculateSplitsResultModelFromJson(
  Map<String, dynamic> json,
) => _RecalculateSplitsResultModel(
  updatedCount: (json['updatedCount'] as num).toInt(),
  skippedCustom: (json['skippedCustom'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$RecalculateSplitsResultModelToJson(
  _RecalculateSplitsResultModel instance,
) => <String, dynamic>{
  'updatedCount': instance.updatedCount,
  'skippedCustom': instance.skippedCustom,
  'total': instance.total,
};

_RecurringExpenseModel _$RecurringExpenseModelFromJson(
  Map<String, dynamic> json,
) => _RecurringExpenseModel(
  id: json['id'] as String,
  householdId: json['householdId'] as String,
  description: json['description'] as String,
  amount: const DecimalConverter().fromJson(json['amount']),
  currency: json['currency'] as String? ?? 'ARS',
  categoryId: json['categoryId'] as String?,
  category:
      json['category'] == null
          ? null
          : ExpenseCategoryModel.fromJson(
            json['category'] as Map<String, dynamic>,
          ),
  paidById: json['paidById'] as String,
  paidBy:
      json['paidBy'] == null
          ? null
          : ExpenseUserModel.fromJson(json['paidBy'] as Map<String, dynamic>),
  recurrence: json['recurrence'] as String,
  nextDueDate: DateTime.parse(json['nextDueDate'] as String),
  isActive: json['isActive'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$RecurringExpenseModelToJson(
  _RecurringExpenseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'householdId': instance.householdId,
  'description': instance.description,
  'amount': const DecimalConverter().toJson(instance.amount),
  'currency': instance.currency,
  'categoryId': instance.categoryId,
  'category': instance.category,
  'paidById': instance.paidById,
  'paidBy': instance.paidBy,
  'recurrence': instance.recurrence,
  'nextDueDate': instance.nextDueDate.toIso8601String(),
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
};

_ExpenseBudgetModel _$ExpenseBudgetModelFromJson(Map<String, dynamic> json) =>
    _ExpenseBudgetModel(
      id: json['id'] as String,
      householdId: json['householdId'] as String,
      categoryId: json['categoryId'] as String,
      category:
          json['category'] == null
              ? null
              : ExpenseCategoryModel.fromJson(
                json['category'] as Map<String, dynamic>,
              ),
      monthlyLimit: const DecimalConverter().fromJson(json['monthlyLimit']),
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ExpenseBudgetModelToJson(_ExpenseBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'householdId': instance.householdId,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'monthlyLimit': const DecimalConverter().toJson(instance.monthlyLimit),
      'month': instance.month,
      'year': instance.year,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_BudgetStatusModel _$BudgetStatusModelFromJson(Map<String, dynamic> json) =>
    _BudgetStatusModel(
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      budgetLimit: const DecimalConverter().fromJson(json['budgetLimit']),
      actualSpent: const DecimalConverter().fromJson(json['actualSpent']),
      remaining: const DecimalConverter().fromJson(json['remaining']),
      percentUsed: (json['percentUsed'] as num).toDouble(),
    );

Map<String, dynamic> _$BudgetStatusModelToJson(_BudgetStatusModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'budgetLimit': const DecimalConverter().toJson(instance.budgetLimit),
      'actualSpent': const DecimalConverter().toJson(instance.actualSpent),
      'remaining': const DecimalConverter().toJson(instance.remaining),
      'percentUsed': instance.percentUsed,
    };

_ExpenseTrendModel _$ExpenseTrendModelFromJson(Map<String, dynamic> json) =>
    _ExpenseTrendModel(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      total: const DecimalConverter().fromJson(json['total']),
      byCategory:
          (json['byCategory'] as List<dynamic>)
              .map(
                (e) => ExpenseCategoryBreakdownModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
    );

Map<String, dynamic> _$ExpenseTrendModelToJson(_ExpenseTrendModel instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'total': const DecimalConverter().toJson(instance.total),
      'byCategory': instance.byCategory,
    };
