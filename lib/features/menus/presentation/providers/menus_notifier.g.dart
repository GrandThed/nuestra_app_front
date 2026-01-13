// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menus_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$menuPlansNotifierHash() => r'4a5eb8b707267f359fde6db7377dbb0c34537184';

/// Notifier for menu plans list
///
/// Copied from [MenuPlansNotifier].
@ProviderFor(MenuPlansNotifier)
final menuPlansNotifierProvider =
    NotifierProvider<MenuPlansNotifier, MenuPlansState>.internal(
      MenuPlansNotifier.new,
      name: r'menuPlansNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$menuPlansNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MenuPlansNotifier = Notifier<MenuPlansState>;
String _$upcomingMealsNotifierHash() =>
    r'341fed43de92830d8637071c59ab2299e712f3f5';

/// Notifier for upcoming meals (weekly view)
///
/// Copied from [UpcomingMealsNotifier].
@ProviderFor(UpcomingMealsNotifier)
final upcomingMealsNotifierProvider = AutoDisposeNotifierProvider<
  UpcomingMealsNotifier,
  UpcomingMealsState
>.internal(
  UpcomingMealsNotifier.new,
  name: r'upcomingMealsNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$upcomingMealsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpcomingMealsNotifier = AutoDisposeNotifier<UpcomingMealsState>;
String _$menuPlanDetailNotifierHash() =>
    r'92c56fd568b92efacb078fcf4d3d7e5c8aa1dd68';

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

abstract class _$MenuPlanDetailNotifier
    extends BuildlessAutoDisposeNotifier<MenuPlanDetailState> {
  late final String menuId;

  MenuPlanDetailState build(String menuId);
}

/// Notifier for single menu plan detail
///
/// Copied from [MenuPlanDetailNotifier].
@ProviderFor(MenuPlanDetailNotifier)
const menuPlanDetailNotifierProvider = MenuPlanDetailNotifierFamily();

/// Notifier for single menu plan detail
///
/// Copied from [MenuPlanDetailNotifier].
class MenuPlanDetailNotifierFamily extends Family<MenuPlanDetailState> {
  /// Notifier for single menu plan detail
  ///
  /// Copied from [MenuPlanDetailNotifier].
  const MenuPlanDetailNotifierFamily();

  /// Notifier for single menu plan detail
  ///
  /// Copied from [MenuPlanDetailNotifier].
  MenuPlanDetailNotifierProvider call(String menuId) {
    return MenuPlanDetailNotifierProvider(menuId);
  }

  @override
  MenuPlanDetailNotifierProvider getProviderOverride(
    covariant MenuPlanDetailNotifierProvider provider,
  ) {
    return call(provider.menuId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'menuPlanDetailNotifierProvider';
}

/// Notifier for single menu plan detail
///
/// Copied from [MenuPlanDetailNotifier].
class MenuPlanDetailNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          MenuPlanDetailNotifier,
          MenuPlanDetailState
        > {
  /// Notifier for single menu plan detail
  ///
  /// Copied from [MenuPlanDetailNotifier].
  MenuPlanDetailNotifierProvider(String menuId)
    : this._internal(
        () => MenuPlanDetailNotifier()..menuId = menuId,
        from: menuPlanDetailNotifierProvider,
        name: r'menuPlanDetailNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$menuPlanDetailNotifierHash,
        dependencies: MenuPlanDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            MenuPlanDetailNotifierFamily._allTransitiveDependencies,
        menuId: menuId,
      );

  MenuPlanDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.menuId,
  }) : super.internal();

  final String menuId;

  @override
  MenuPlanDetailState runNotifierBuild(
    covariant MenuPlanDetailNotifier notifier,
  ) {
    return notifier.build(menuId);
  }

  @override
  Override overrideWith(MenuPlanDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MenuPlanDetailNotifierProvider._internal(
        () => create()..menuId = menuId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        menuId: menuId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    MenuPlanDetailNotifier,
    MenuPlanDetailState
  >
  createElement() {
    return _MenuPlanDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MenuPlanDetailNotifierProvider && other.menuId == menuId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, menuId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MenuPlanDetailNotifierRef
    on AutoDisposeNotifierProviderRef<MenuPlanDetailState> {
  /// The parameter `menuId` of this provider.
  String get menuId;
}

class _MenuPlanDetailNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          MenuPlanDetailNotifier,
          MenuPlanDetailState
        >
    with MenuPlanDetailNotifierRef {
  _MenuPlanDetailNotifierProviderElement(super.provider);

  @override
  String get menuId => (origin as MenuPlanDetailNotifierProvider).menuId;
}

String _$selectedWeekStartHash() => r'ab31f87fd1b7cf2bbe72839fd5eeb279b1fcbf51';

/// Provider for selected week start date
///
/// Copied from [SelectedWeekStart].
@ProviderFor(SelectedWeekStart)
final selectedWeekStartProvider =
    AutoDisposeNotifierProvider<SelectedWeekStart, DateTime>.internal(
      SelectedWeekStart.new,
      name: r'selectedWeekStartProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedWeekStartHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedWeekStart = AutoDisposeNotifier<DateTime>;
String _$currentMenuPlanIdHash() => r'd8c7f5b637349bfdc0ee1247277fd7c27b51f302';

/// Provider for currently selected menu plan ID
///
/// Copied from [CurrentMenuPlanId].
@ProviderFor(CurrentMenuPlanId)
final currentMenuPlanIdProvider =
    NotifierProvider<CurrentMenuPlanId, String?>.internal(
      CurrentMenuPlanId.new,
      name: r'currentMenuPlanIdProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentMenuPlanIdHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentMenuPlanId = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
