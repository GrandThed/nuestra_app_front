// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalExpensesAmountHash() =>
    r'60d379702e2a5b3c500e99ad4a939b0ce9a535a4';

/// Provider for total expenses in current month
///
/// Copied from [totalExpensesAmount].
@ProviderFor(totalExpensesAmount)
final totalExpensesAmountProvider = AutoDisposeProvider<double>.internal(
  totalExpensesAmount,
  name: r'totalExpensesAmountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$totalExpensesAmountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalExpensesAmountRef = AutoDisposeProviderRef<double>;
String _$unsettledExpensesCountHash() =>
    r'6da96052f2c4d08ebd7af19270ad8043e65a994a';

/// Provider for unsettled expenses count
///
/// Copied from [unsettledExpensesCount].
@ProviderFor(unsettledExpensesCount)
final unsettledExpensesCountProvider = AutoDisposeProvider<int>.internal(
  unsettledExpensesCount,
  name: r'unsettledExpensesCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$unsettledExpensesCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnsettledExpensesCountRef = AutoDisposeProviderRef<int>;
String _$expensesByCategoryHash() =>
    r'dad1768911ec1dfe8dbbfe30e3b5e3bf5c311692';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for expenses filtered by category
///
/// Copied from [expensesByCategory].
@ProviderFor(expensesByCategory)
const expensesByCategoryProvider = ExpensesByCategoryFamily();

/// Provider for expenses filtered by category
///
/// Copied from [expensesByCategory].
class ExpensesByCategoryFamily extends Family<List<ExpenseModel>> {
  /// Provider for expenses filtered by category
  ///
  /// Copied from [expensesByCategory].
  const ExpensesByCategoryFamily();

  /// Provider for expenses filtered by category
  ///
  /// Copied from [expensesByCategory].
  ExpensesByCategoryProvider call(String? categoryId) {
    return ExpensesByCategoryProvider(categoryId);
  }

  @override
  ExpensesByCategoryProvider getProviderOverride(
    covariant ExpensesByCategoryProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'expensesByCategoryProvider';
}

/// Provider for expenses filtered by category
///
/// Copied from [expensesByCategory].
class ExpensesByCategoryProvider
    extends AutoDisposeProvider<List<ExpenseModel>> {
  /// Provider for expenses filtered by category
  ///
  /// Copied from [expensesByCategory].
  ExpensesByCategoryProvider(String? categoryId)
    : this._internal(
        (ref) => expensesByCategory(ref as ExpensesByCategoryRef, categoryId),
        from: expensesByCategoryProvider,
        name: r'expensesByCategoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$expensesByCategoryHash,
        dependencies: ExpensesByCategoryFamily._dependencies,
        allTransitiveDependencies:
            ExpensesByCategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  ExpensesByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String? categoryId;

  @override
  Override overrideWith(
    List<ExpenseModel> Function(ExpensesByCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExpensesByCategoryProvider._internal(
        (ref) => create(ref as ExpensesByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<ExpenseModel>> createElement() {
    return _ExpensesByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesByCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExpensesByCategoryRef on AutoDisposeProviderRef<List<ExpenseModel>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _ExpensesByCategoryProviderElement
    extends AutoDisposeProviderElement<List<ExpenseModel>>
    with ExpensesByCategoryRef {
  _ExpensesByCategoryProviderElement(super.provider);

  @override
  String? get categoryId => (origin as ExpensesByCategoryProvider).categoryId;
}

String _$exportExpensesCsvHash() => r'6f96b7315652cd7d0732d76d6d2ce91c36b0b9ac';

/// Utility provider for exporting expenses as CSV
/// Returns the CSV string or null on error
///
/// Copied from [exportExpensesCsv].
@ProviderFor(exportExpensesCsv)
const exportExpensesCsvProvider = ExportExpensesCsvFamily();

/// Utility provider for exporting expenses as CSV
/// Returns the CSV string or null on error
///
/// Copied from [exportExpensesCsv].
class ExportExpensesCsvFamily extends Family<AsyncValue<String?>> {
  /// Utility provider for exporting expenses as CSV
  /// Returns the CSV string or null on error
  ///
  /// Copied from [exportExpensesCsv].
  const ExportExpensesCsvFamily();

  /// Utility provider for exporting expenses as CSV
  /// Returns the CSV string or null on error
  ///
  /// Copied from [exportExpensesCsv].
  ExportExpensesCsvProvider call({int? month, int? year}) {
    return ExportExpensesCsvProvider(month: month, year: year);
  }

  @override
  ExportExpensesCsvProvider getProviderOverride(
    covariant ExportExpensesCsvProvider provider,
  ) {
    return call(month: provider.month, year: provider.year);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'exportExpensesCsvProvider';
}

/// Utility provider for exporting expenses as CSV
/// Returns the CSV string or null on error
///
/// Copied from [exportExpensesCsv].
class ExportExpensesCsvProvider extends AutoDisposeFutureProvider<String?> {
  /// Utility provider for exporting expenses as CSV
  /// Returns the CSV string or null on error
  ///
  /// Copied from [exportExpensesCsv].
  ExportExpensesCsvProvider({int? month, int? year})
    : this._internal(
        (ref) => exportExpensesCsv(
          ref as ExportExpensesCsvRef,
          month: month,
          year: year,
        ),
        from: exportExpensesCsvProvider,
        name: r'exportExpensesCsvProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$exportExpensesCsvHash,
        dependencies: ExportExpensesCsvFamily._dependencies,
        allTransitiveDependencies:
            ExportExpensesCsvFamily._allTransitiveDependencies,
        month: month,
        year: year,
      );

  ExportExpensesCsvProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
    required this.year,
  }) : super.internal();

  final int? month;
  final int? year;

  @override
  Override overrideWith(
    FutureOr<String?> Function(ExportExpensesCsvRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExportExpensesCsvProvider._internal(
        (ref) => create(ref as ExportExpensesCsvRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
        year: year,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _ExportExpensesCsvProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExportExpensesCsvProvider &&
        other.month == month &&
        other.year == year;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExportExpensesCsvRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `month` of this provider.
  int? get month;

  /// The parameter `year` of this provider.
  int? get year;
}

class _ExportExpensesCsvProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with ExportExpensesCsvRef {
  _ExportExpensesCsvProviderElement(super.provider);

  @override
  int? get month => (origin as ExportExpensesCsvProvider).month;
  @override
  int? get year => (origin as ExportExpensesCsvProvider).year;
}

String _$expensesNotifierHash() => r'799686ca0b812729cda29ac6c75063cb85f77bb6';

/// Notifier for expenses operations (categories + expenses combined)
///
/// Copied from [ExpensesNotifier].
@ProviderFor(ExpensesNotifier)
final expensesNotifierProvider =
    NotifierProvider<ExpensesNotifier, ExpensesState>.internal(
      ExpensesNotifier.new,
      name: r'expensesNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$expensesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ExpensesNotifier = Notifier<ExpensesState>;
String _$expenseSummaryNotifierHash() =>
    r'a1813f48936706db4bfb5cdcb7eb5ee58e6be760';

/// Notifier for expense summary
///
/// Copied from [ExpenseSummaryNotifier].
@ProviderFor(ExpenseSummaryNotifier)
final expenseSummaryNotifierProvider =
    NotifierProvider<ExpenseSummaryNotifier, ExpenseSummaryState>.internal(
      ExpenseSummaryNotifier.new,
      name: r'expenseSummaryNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$expenseSummaryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ExpenseSummaryNotifier = Notifier<ExpenseSummaryState>;
String _$recurringExpensesNotifierHash() =>
    r'e46e3ee5a7d5f5f5807da7453eaf63c39ec58097';

/// Notifier for recurring expenses
///
/// Copied from [RecurringExpensesNotifier].
@ProviderFor(RecurringExpensesNotifier)
final recurringExpensesNotifierProvider = NotifierProvider<
  RecurringExpensesNotifier,
  RecurringExpensesState
>.internal(
  RecurringExpensesNotifier.new,
  name: r'recurringExpensesNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$recurringExpensesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecurringExpensesNotifier = Notifier<RecurringExpensesState>;
String _$budgetNotifierHash() => r'acd9d74b6fc5af8f1fea364e44d477303026396d';

/// Notifier for budget status
///
/// Copied from [BudgetNotifier].
@ProviderFor(BudgetNotifier)
final budgetNotifierProvider =
    NotifierProvider<BudgetNotifier, BudgetState>.internal(
      BudgetNotifier.new,
      name: r'budgetNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$budgetNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BudgetNotifier = Notifier<BudgetState>;
String _$expenseTrendsNotifierHash() =>
    r'05fd42b23b0d3a9669cd1955b8626882b97aedca';

/// Notifier for expense trends
///
/// Copied from [ExpenseTrendsNotifier].
@ProviderFor(ExpenseTrendsNotifier)
final expenseTrendsNotifierProvider =
    NotifierProvider<ExpenseTrendsNotifier, ExpenseTrendsState>.internal(
      ExpenseTrendsNotifier.new,
      name: r'expenseTrendsNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$expenseTrendsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ExpenseTrendsNotifier = Notifier<ExpenseTrendsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
