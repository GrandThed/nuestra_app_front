// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menus_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for menu plans list

@ProviderFor(MenuPlansNotifier)
final menuPlansProvider = MenuPlansNotifierProvider._();

/// Notifier for menu plans list
final class MenuPlansNotifierProvider
    extends $NotifierProvider<MenuPlansNotifier, MenuPlansState> {
  /// Notifier for menu plans list
  MenuPlansNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuPlansProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuPlansNotifierHash();

  @$internal
  @override
  MenuPlansNotifier create() => MenuPlansNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuPlansState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuPlansState>(value),
    );
  }
}

String _$menuPlansNotifierHash() => r'469b5fd604a1c9d71df2ec2d1b0637940868bc54';

/// Notifier for menu plans list

abstract class _$MenuPlansNotifier extends $Notifier<MenuPlansState> {
  MenuPlansState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MenuPlansState, MenuPlansState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MenuPlansState, MenuPlansState>,
              MenuPlansState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for upcoming meals (weekly view)

@ProviderFor(UpcomingMealsNotifier)
final upcomingMealsProvider = UpcomingMealsNotifierProvider._();

/// Notifier for upcoming meals (weekly view)
final class UpcomingMealsNotifierProvider
    extends $NotifierProvider<UpcomingMealsNotifier, UpcomingMealsState> {
  /// Notifier for upcoming meals (weekly view)
  UpcomingMealsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingMealsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingMealsNotifierHash();

  @$internal
  @override
  UpcomingMealsNotifier create() => UpcomingMealsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpcomingMealsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpcomingMealsState>(value),
    );
  }
}

String _$upcomingMealsNotifierHash() =>
    r'3aa1aa0b3c5b621c1880210b46d6fea3ea660171';

/// Notifier for upcoming meals (weekly view)

abstract class _$UpcomingMealsNotifier extends $Notifier<UpcomingMealsState> {
  UpcomingMealsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UpcomingMealsState, UpcomingMealsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UpcomingMealsState, UpcomingMealsState>,
              UpcomingMealsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for single menu plan detail

@ProviderFor(MenuPlanDetailNotifier)
final menuPlanDetailProvider = MenuPlanDetailNotifierFamily._();

/// Notifier for single menu plan detail
final class MenuPlanDetailNotifierProvider
    extends $NotifierProvider<MenuPlanDetailNotifier, MenuPlanDetailState> {
  /// Notifier for single menu plan detail
  MenuPlanDetailNotifierProvider._({
    required MenuPlanDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'menuPlanDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$menuPlanDetailNotifierHash();

  @override
  String toString() {
    return r'menuPlanDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MenuPlanDetailNotifier create() => MenuPlanDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuPlanDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuPlanDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MenuPlanDetailNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$menuPlanDetailNotifierHash() =>
    r'd892bc98f3b13c93dc8e143ba39f5cc0b4aa9bf9';

/// Notifier for single menu plan detail

final class MenuPlanDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          MenuPlanDetailNotifier,
          MenuPlanDetailState,
          MenuPlanDetailState,
          MenuPlanDetailState,
          String
        > {
  MenuPlanDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'menuPlanDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for single menu plan detail

  MenuPlanDetailNotifierProvider call(String menuId) =>
      MenuPlanDetailNotifierProvider._(argument: menuId, from: this);

  @override
  String toString() => r'menuPlanDetailProvider';
}

/// Notifier for single menu plan detail

abstract class _$MenuPlanDetailNotifier extends $Notifier<MenuPlanDetailState> {
  late final _$args = ref.$arg as String;
  String get menuId => _$args;

  MenuPlanDetailState build(String menuId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MenuPlanDetailState, MenuPlanDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MenuPlanDetailState, MenuPlanDetailState>,
              MenuPlanDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Provider for selected week start date

@ProviderFor(SelectedWeekStart)
final selectedWeekStartProvider = SelectedWeekStartProvider._();

/// Provider for selected week start date
final class SelectedWeekStartProvider
    extends $NotifierProvider<SelectedWeekStart, DateTime> {
  /// Provider for selected week start date
  SelectedWeekStartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedWeekStartProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedWeekStartHash();

  @$internal
  @override
  SelectedWeekStart create() => SelectedWeekStart();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedWeekStartHash() => r'ab31f87fd1b7cf2bbe72839fd5eeb279b1fcbf51';

/// Provider for selected week start date

abstract class _$SelectedWeekStart extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider for currently selected menu plan ID

@ProviderFor(CurrentMenuPlanId)
final currentMenuPlanIdProvider = CurrentMenuPlanIdProvider._();

/// Provider for currently selected menu plan ID
final class CurrentMenuPlanIdProvider
    extends $NotifierProvider<CurrentMenuPlanId, String?> {
  /// Provider for currently selected menu plan ID
  CurrentMenuPlanIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentMenuPlanIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentMenuPlanIdHash();

  @$internal
  @override
  CurrentMenuPlanId create() => CurrentMenuPlanId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$currentMenuPlanIdHash() => r'd8c7f5b637349bfdc0ee1247277fd7c27b51f302';

/// Provider for currently selected menu plan ID

abstract class _$CurrentMenuPlanId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for meal history

@ProviderFor(MealHistoryNotifier)
final mealHistoryProvider = MealHistoryNotifierProvider._();

/// Notifier for meal history
final class MealHistoryNotifierProvider
    extends $NotifierProvider<MealHistoryNotifier, MealHistoryState> {
  /// Notifier for meal history
  MealHistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealHistoryNotifierHash();

  @$internal
  @override
  MealHistoryNotifier create() => MealHistoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealHistoryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealHistoryState>(value),
    );
  }
}

String _$mealHistoryNotifierHash() =>
    r'10a1e7d5e2903ee5ad712e944d78c7a84c49cf9a';

/// Notifier for meal history

abstract class _$MealHistoryNotifier extends $Notifier<MealHistoryState> {
  MealHistoryState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MealHistoryState, MealHistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MealHistoryState, MealHistoryState>,
              MealHistoryState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
