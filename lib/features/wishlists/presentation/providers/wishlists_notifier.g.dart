// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlists_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$uncheckedWishlistItemsCountHash() =>
    r'8962a6d026097a846b6dedea99ff53525ede3d5a';

/// Provider for unchecked items count (for home dashboard)
///
/// Copied from [uncheckedWishlistItemsCount].
@ProviderFor(uncheckedWishlistItemsCount)
final uncheckedWishlistItemsCountProvider = AutoDisposeProvider<int>.internal(
  uncheckedWishlistItemsCount,
  name: r'uncheckedWishlistItemsCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$uncheckedWishlistItemsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UncheckedWishlistItemsCountRef = AutoDisposeProviderRef<int>;
String _$wishlistItemsByCategoryHash() =>
    r'51596421ff26185a71ea6f023a84ae070f701bc5';

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

/// Provider for items filtered by category
///
/// Copied from [wishlistItemsByCategory].
@ProviderFor(wishlistItemsByCategory)
const wishlistItemsByCategoryProvider = WishlistItemsByCategoryFamily();

/// Provider for items filtered by category
///
/// Copied from [wishlistItemsByCategory].
class WishlistItemsByCategoryFamily extends Family<List<WishlistItemModel>> {
  /// Provider for items filtered by category
  ///
  /// Copied from [wishlistItemsByCategory].
  const WishlistItemsByCategoryFamily();

  /// Provider for items filtered by category
  ///
  /// Copied from [wishlistItemsByCategory].
  WishlistItemsByCategoryProvider call(String? categoryId) {
    return WishlistItemsByCategoryProvider(categoryId);
  }

  @override
  WishlistItemsByCategoryProvider getProviderOverride(
    covariant WishlistItemsByCategoryProvider provider,
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
  String? get name => r'wishlistItemsByCategoryProvider';
}

/// Provider for items filtered by category
///
/// Copied from [wishlistItemsByCategory].
class WishlistItemsByCategoryProvider
    extends AutoDisposeProvider<List<WishlistItemModel>> {
  /// Provider for items filtered by category
  ///
  /// Copied from [wishlistItemsByCategory].
  WishlistItemsByCategoryProvider(String? categoryId)
    : this._internal(
        (ref) => wishlistItemsByCategory(
          ref as WishlistItemsByCategoryRef,
          categoryId,
        ),
        from: wishlistItemsByCategoryProvider,
        name: r'wishlistItemsByCategoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$wishlistItemsByCategoryHash,
        dependencies: WishlistItemsByCategoryFamily._dependencies,
        allTransitiveDependencies:
            WishlistItemsByCategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  WishlistItemsByCategoryProvider._internal(
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
    List<WishlistItemModel> Function(WishlistItemsByCategoryRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WishlistItemsByCategoryProvider._internal(
        (ref) => create(ref as WishlistItemsByCategoryRef),
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
  AutoDisposeProviderElement<List<WishlistItemModel>> createElement() {
    return _WishlistItemsByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WishlistItemsByCategoryProvider &&
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
mixin WishlistItemsByCategoryRef
    on AutoDisposeProviderRef<List<WishlistItemModel>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _WishlistItemsByCategoryProviderElement
    extends AutoDisposeProviderElement<List<WishlistItemModel>>
    with WishlistItemsByCategoryRef {
  _WishlistItemsByCategoryProviderElement(super.provider);

  @override
  String? get categoryId =>
      (origin as WishlistItemsByCategoryProvider).categoryId;
}

String _$checkedItemsCountHash() => r'ce564a6b6bcf4ba1204d66a75c093339b44d7572';

/// Provider for checked items count in a category
///
/// Copied from [checkedItemsCount].
@ProviderFor(checkedItemsCount)
const checkedItemsCountProvider = CheckedItemsCountFamily();

/// Provider for checked items count in a category
///
/// Copied from [checkedItemsCount].
class CheckedItemsCountFamily extends Family<int> {
  /// Provider for checked items count in a category
  ///
  /// Copied from [checkedItemsCount].
  const CheckedItemsCountFamily();

  /// Provider for checked items count in a category
  ///
  /// Copied from [checkedItemsCount].
  CheckedItemsCountProvider call(String? categoryId) {
    return CheckedItemsCountProvider(categoryId);
  }

  @override
  CheckedItemsCountProvider getProviderOverride(
    covariant CheckedItemsCountProvider provider,
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
  String? get name => r'checkedItemsCountProvider';
}

/// Provider for checked items count in a category
///
/// Copied from [checkedItemsCount].
class CheckedItemsCountProvider extends AutoDisposeProvider<int> {
  /// Provider for checked items count in a category
  ///
  /// Copied from [checkedItemsCount].
  CheckedItemsCountProvider(String? categoryId)
    : this._internal(
        (ref) => checkedItemsCount(ref as CheckedItemsCountRef, categoryId),
        from: checkedItemsCountProvider,
        name: r'checkedItemsCountProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$checkedItemsCountHash,
        dependencies: CheckedItemsCountFamily._dependencies,
        allTransitiveDependencies:
            CheckedItemsCountFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  CheckedItemsCountProvider._internal(
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
  Override overrideWith(int Function(CheckedItemsCountRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: CheckedItemsCountProvider._internal(
        (ref) => create(ref as CheckedItemsCountRef),
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
  AutoDisposeProviderElement<int> createElement() {
    return _CheckedItemsCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckedItemsCountProvider && other.categoryId == categoryId;
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
mixin CheckedItemsCountRef on AutoDisposeProviderRef<int> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _CheckedItemsCountProviderElement extends AutoDisposeProviderElement<int>
    with CheckedItemsCountRef {
  _CheckedItemsCountProviderElement(super.provider);

  @override
  String? get categoryId => (origin as CheckedItemsCountProvider).categoryId;
}

String _$uncheckedItemsCountHash() =>
    r'fa0b38abb390c32211225d8fc61ffaefda5ec2f9';

/// Provider for unchecked items count in a category
///
/// Copied from [uncheckedItemsCount].
@ProviderFor(uncheckedItemsCount)
const uncheckedItemsCountProvider = UncheckedItemsCountFamily();

/// Provider for unchecked items count in a category
///
/// Copied from [uncheckedItemsCount].
class UncheckedItemsCountFamily extends Family<int> {
  /// Provider for unchecked items count in a category
  ///
  /// Copied from [uncheckedItemsCount].
  const UncheckedItemsCountFamily();

  /// Provider for unchecked items count in a category
  ///
  /// Copied from [uncheckedItemsCount].
  UncheckedItemsCountProvider call(String? categoryId) {
    return UncheckedItemsCountProvider(categoryId);
  }

  @override
  UncheckedItemsCountProvider getProviderOverride(
    covariant UncheckedItemsCountProvider provider,
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
  String? get name => r'uncheckedItemsCountProvider';
}

/// Provider for unchecked items count in a category
///
/// Copied from [uncheckedItemsCount].
class UncheckedItemsCountProvider extends AutoDisposeProvider<int> {
  /// Provider for unchecked items count in a category
  ///
  /// Copied from [uncheckedItemsCount].
  UncheckedItemsCountProvider(String? categoryId)
    : this._internal(
        (ref) => uncheckedItemsCount(ref as UncheckedItemsCountRef, categoryId),
        from: uncheckedItemsCountProvider,
        name: r'uncheckedItemsCountProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$uncheckedItemsCountHash,
        dependencies: UncheckedItemsCountFamily._dependencies,
        allTransitiveDependencies:
            UncheckedItemsCountFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  UncheckedItemsCountProvider._internal(
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
  Override overrideWith(int Function(UncheckedItemsCountRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: UncheckedItemsCountProvider._internal(
        (ref) => create(ref as UncheckedItemsCountRef),
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
  AutoDisposeProviderElement<int> createElement() {
    return _UncheckedItemsCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UncheckedItemsCountProvider &&
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
mixin UncheckedItemsCountRef on AutoDisposeProviderRef<int> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;
}

class _UncheckedItemsCountProviderElement
    extends AutoDisposeProviderElement<int>
    with UncheckedItemsCountRef {
  _UncheckedItemsCountProviderElement(super.provider);

  @override
  String? get categoryId => (origin as UncheckedItemsCountProvider).categoryId;
}

String _$wishlistsNotifierHash() => r'2d5c316e71995c5bfaf9eca7f012f01311a4cf3b';

/// Notifier for wishlists operations (categories + items combined)
///
/// Copied from [WishlistsNotifier].
@ProviderFor(WishlistsNotifier)
final wishlistsNotifierProvider =
    NotifierProvider<WishlistsNotifier, WishlistsState>.internal(
      WishlistsNotifier.new,
      name: r'wishlistsNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$wishlistsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WishlistsNotifier = Notifier<WishlistsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
