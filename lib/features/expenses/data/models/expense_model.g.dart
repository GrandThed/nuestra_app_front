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
    );

Map<String, dynamic> _$ExpenseSplitModelToJson(_ExpenseSplitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'user': instance.user,
      'amount': const DecimalConverter().toJson(instance.amount),
      'settled': instance.settled,
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
