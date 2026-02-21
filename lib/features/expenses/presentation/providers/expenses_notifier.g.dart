// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for expenses operations (categories + expenses combined)

@ProviderFor(ExpensesNotifier)
final expensesProvider = ExpensesNotifierProvider._();

/// Notifier for expenses operations (categories + expenses combined)
final class ExpensesNotifierProvider
    extends $NotifierProvider<ExpensesNotifier, ExpensesState> {
  /// Notifier for expenses operations (categories + expenses combined)
  ExpensesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expensesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expensesNotifierHash();

  @$internal
  @override
  ExpensesNotifier create() => ExpensesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpensesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpensesState>(value),
    );
  }
}

String _$expensesNotifierHash() => r'd1910a249bb3f363945cc4ccf89b1f93244cc738';

/// Notifier for expenses operations (categories + expenses combined)

abstract class _$ExpensesNotifier extends $Notifier<ExpensesState> {
  ExpensesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExpensesState, ExpensesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExpensesState, ExpensesState>,
              ExpensesState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for expense summary

@ProviderFor(ExpenseSummaryNotifier)
final expenseSummaryProvider = ExpenseSummaryNotifierProvider._();

/// Notifier for expense summary
final class ExpenseSummaryNotifierProvider
    extends $NotifierProvider<ExpenseSummaryNotifier, ExpenseSummaryState> {
  /// Notifier for expense summary
  ExpenseSummaryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseSummaryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseSummaryNotifierHash();

  @$internal
  @override
  ExpenseSummaryNotifier create() => ExpenseSummaryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpenseSummaryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpenseSummaryState>(value),
    );
  }
}

String _$expenseSummaryNotifierHash() =>
    r'a61fa4cfd5cf1cf23059aa17c571af0a085fefd9';

/// Notifier for expense summary

abstract class _$ExpenseSummaryNotifier extends $Notifier<ExpenseSummaryState> {
  ExpenseSummaryState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExpenseSummaryState, ExpenseSummaryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExpenseSummaryState, ExpenseSummaryState>,
              ExpenseSummaryState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider for total expenses in current month

@ProviderFor(totalExpensesAmount)
final totalExpensesAmountProvider = TotalExpensesAmountProvider._();

/// Provider for total expenses in current month

final class TotalExpensesAmountProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  /// Provider for total expenses in current month
  TotalExpensesAmountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalExpensesAmountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalExpensesAmountHash();

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    return totalExpensesAmount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$totalExpensesAmountHash() =>
    r'60d379702e2a5b3c500e99ad4a939b0ce9a535a4';

/// Provider for unsettled expenses count

@ProviderFor(unsettledExpensesCount)
final unsettledExpensesCountProvider = UnsettledExpensesCountProvider._();

/// Provider for unsettled expenses count

final class UnsettledExpensesCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Provider for unsettled expenses count
  UnsettledExpensesCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unsettledExpensesCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unsettledExpensesCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return unsettledExpensesCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$unsettledExpensesCountHash() =>
    r'6da96052f2c4d08ebd7af19270ad8043e65a994a';

/// Provider for expenses filtered by category

@ProviderFor(expensesByCategory)
final expensesByCategoryProvider = ExpensesByCategoryFamily._();

/// Provider for expenses filtered by category

final class ExpensesByCategoryProvider
    extends
        $FunctionalProvider<
          List<ExpenseModel>,
          List<ExpenseModel>,
          List<ExpenseModel>
        >
    with $Provider<List<ExpenseModel>> {
  /// Provider for expenses filtered by category
  ExpensesByCategoryProvider._({
    required ExpensesByCategoryFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'expensesByCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$expensesByCategoryHash();

  @override
  String toString() {
    return r'expensesByCategoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<ExpenseModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ExpenseModel> create(Ref ref) {
    final argument = this.argument as String?;
    return expensesByCategory(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ExpenseModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ExpenseModel>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesByCategoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$expensesByCategoryHash() =>
    r'dad1768911ec1dfe8dbbfe30e3b5e3bf5c311692';

/// Provider for expenses filtered by category

final class ExpensesByCategoryFamily extends $Family
    with $FunctionalFamilyOverride<List<ExpenseModel>, String?> {
  ExpensesByCategoryFamily._()
    : super(
        retry: null,
        name: r'expensesByCategoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for expenses filtered by category

  ExpensesByCategoryProvider call(String? categoryId) =>
      ExpensesByCategoryProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'expensesByCategoryProvider';
}

/// Notifier for recurring expenses

@ProviderFor(RecurringExpensesNotifier)
final recurringExpensesProvider = RecurringExpensesNotifierProvider._();

/// Notifier for recurring expenses
final class RecurringExpensesNotifierProvider
    extends
        $NotifierProvider<RecurringExpensesNotifier, RecurringExpensesState> {
  /// Notifier for recurring expenses
  RecurringExpensesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringExpensesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringExpensesNotifierHash();

  @$internal
  @override
  RecurringExpensesNotifier create() => RecurringExpensesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecurringExpensesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecurringExpensesState>(value),
    );
  }
}

String _$recurringExpensesNotifierHash() =>
    r'9e429837539e065a57848c51cc3cbe527a3c37a7';

/// Notifier for recurring expenses

abstract class _$RecurringExpensesNotifier
    extends $Notifier<RecurringExpensesState> {
  RecurringExpensesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<RecurringExpensesState, RecurringExpensesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecurringExpensesState, RecurringExpensesState>,
              RecurringExpensesState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for budget status

@ProviderFor(BudgetNotifier)
final budgetProvider = BudgetNotifierProvider._();

/// Notifier for budget status
final class BudgetNotifierProvider
    extends $NotifierProvider<BudgetNotifier, BudgetState> {
  /// Notifier for budget status
  BudgetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetNotifierHash();

  @$internal
  @override
  BudgetNotifier create() => BudgetNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetState>(value),
    );
  }
}

String _$budgetNotifierHash() => r'd834f2903bdc0962f581a0366d7d042e87ed7f9c';

/// Notifier for budget status

abstract class _$BudgetNotifier extends $Notifier<BudgetState> {
  BudgetState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BudgetState, BudgetState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BudgetState, BudgetState>,
              BudgetState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for expense trends

@ProviderFor(ExpenseTrendsNotifier)
final expenseTrendsProvider = ExpenseTrendsNotifierProvider._();

/// Notifier for expense trends
final class ExpenseTrendsNotifierProvider
    extends $NotifierProvider<ExpenseTrendsNotifier, ExpenseTrendsState> {
  /// Notifier for expense trends
  ExpenseTrendsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseTrendsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseTrendsNotifierHash();

  @$internal
  @override
  ExpenseTrendsNotifier create() => ExpenseTrendsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpenseTrendsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpenseTrendsState>(value),
    );
  }
}

String _$expenseTrendsNotifierHash() =>
    r'05fd42b23b0d3a9669cd1955b8626882b97aedca';

/// Notifier for expense trends

abstract class _$ExpenseTrendsNotifier extends $Notifier<ExpenseTrendsState> {
  ExpenseTrendsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExpenseTrendsState, ExpenseTrendsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExpenseTrendsState, ExpenseTrendsState>,
              ExpenseTrendsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Utility provider for exporting expenses as CSV
/// Returns the CSV string or null on error

@ProviderFor(exportExpensesCsv)
final exportExpensesCsvProvider = ExportExpensesCsvFamily._();

/// Utility provider for exporting expenses as CSV
/// Returns the CSV string or null on error

final class ExportExpensesCsvProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// Utility provider for exporting expenses as CSV
  /// Returns the CSV string or null on error
  ExportExpensesCsvProvider._({
    required ExportExpensesCsvFamily super.from,
    required ({int? month, int? year}) super.argument,
  }) : super(
         retry: null,
         name: r'exportExpensesCsvProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exportExpensesCsvHash();

  @override
  String toString() {
    return r'exportExpensesCsvProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as ({int? month, int? year});
    return exportExpensesCsv(ref, month: argument.month, year: argument.year);
  }

  @override
  bool operator ==(Object other) {
    return other is ExportExpensesCsvProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exportExpensesCsvHash() => r'6f96b7315652cd7d0732d76d6d2ce91c36b0b9ac';

/// Utility provider for exporting expenses as CSV
/// Returns the CSV string or null on error

final class ExportExpensesCsvFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<String?>,
          ({int? month, int? year})
        > {
  ExportExpensesCsvFamily._()
    : super(
        retry: null,
        name: r'exportExpensesCsvProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Utility provider for exporting expenses as CSV
  /// Returns the CSV string or null on error

  ExportExpensesCsvProvider call({int? month, int? year}) =>
      ExportExpensesCsvProvider._(
        argument: (month: month, year: year),
        from: this,
      );

  @override
  String toString() => r'exportExpensesCsvProvider';
}
