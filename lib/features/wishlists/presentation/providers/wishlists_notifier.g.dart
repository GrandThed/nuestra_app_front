// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlists_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for wishlists operations (categories + items combined)

@ProviderFor(WishlistsNotifier)
final wishlistsProvider = WishlistsNotifierProvider._();

/// Notifier for wishlists operations (categories + items combined)
final class WishlistsNotifierProvider
    extends $NotifierProvider<WishlistsNotifier, WishlistsState> {
  /// Notifier for wishlists operations (categories + items combined)
  WishlistsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wishlistsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wishlistsNotifierHash();

  @$internal
  @override
  WishlistsNotifier create() => WishlistsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WishlistsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WishlistsState>(value),
    );
  }
}

String _$wishlistsNotifierHash() => r'23a2aa7109490608067d8d01055c64b9347c5240';

/// Notifier for wishlists operations (categories + items combined)

abstract class _$WishlistsNotifier extends $Notifier<WishlistsState> {
  WishlistsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WishlistsState, WishlistsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WishlistsState, WishlistsState>,
              WishlistsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider for unchecked items count (for home dashboard)

@ProviderFor(uncheckedWishlistItemsCount)
final uncheckedWishlistItemsCountProvider =
    UncheckedWishlistItemsCountProvider._();

/// Provider for unchecked items count (for home dashboard)

final class UncheckedWishlistItemsCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Provider for unchecked items count (for home dashboard)
  UncheckedWishlistItemsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uncheckedWishlistItemsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uncheckedWishlistItemsCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return uncheckedWishlistItemsCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$uncheckedWishlistItemsCountHash() =>
    r'cba83180de532ff9ded3912741a5acfcca446d5e';

/// Provider for items filtered by category

@ProviderFor(wishlistItemsByCategory)
final wishlistItemsByCategoryProvider = WishlistItemsByCategoryFamily._();

/// Provider for items filtered by category

final class WishlistItemsByCategoryProvider
    extends
        $FunctionalProvider<
          List<WishlistItemModel>,
          List<WishlistItemModel>,
          List<WishlistItemModel>
        >
    with $Provider<List<WishlistItemModel>> {
  /// Provider for items filtered by category
  WishlistItemsByCategoryProvider._({
    required WishlistItemsByCategoryFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'wishlistItemsByCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$wishlistItemsByCategoryHash();

  @override
  String toString() {
    return r'wishlistItemsByCategoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<WishlistItemModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<WishlistItemModel> create(Ref ref) {
    final argument = this.argument as String?;
    return wishlistItemsByCategory(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<WishlistItemModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<WishlistItemModel>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WishlistItemsByCategoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wishlistItemsByCategoryHash() =>
    r'38c83ae4473a32cf04130a3209b9a7774c4b7a3f';

/// Provider for items filtered by category

final class WishlistItemsByCategoryFamily extends $Family
    with $FunctionalFamilyOverride<List<WishlistItemModel>, String?> {
  WishlistItemsByCategoryFamily._()
    : super(
        retry: null,
        name: r'wishlistItemsByCategoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for items filtered by category

  WishlistItemsByCategoryProvider call(String? categoryId) =>
      WishlistItemsByCategoryProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'wishlistItemsByCategoryProvider';
}

/// Provider for checked items count in a category

@ProviderFor(checkedItemsCount)
final checkedItemsCountProvider = CheckedItemsCountFamily._();

/// Provider for checked items count in a category

final class CheckedItemsCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Provider for checked items count in a category
  CheckedItemsCountProvider._({
    required CheckedItemsCountFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'checkedItemsCountProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$checkedItemsCountHash();

  @override
  String toString() {
    return r'checkedItemsCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    final argument = this.argument as String?;
    return checkedItemsCount(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CheckedItemsCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$checkedItemsCountHash() => r'415bba1226a56a1747eb7b881b2234eaf1438bb0';

/// Provider for checked items count in a category

final class CheckedItemsCountFamily extends $Family
    with $FunctionalFamilyOverride<int, String?> {
  CheckedItemsCountFamily._()
    : super(
        retry: null,
        name: r'checkedItemsCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for checked items count in a category

  CheckedItemsCountProvider call(String? categoryId) =>
      CheckedItemsCountProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'checkedItemsCountProvider';
}

/// Provider for unchecked items count in a category

@ProviderFor(uncheckedItemsCount)
final uncheckedItemsCountProvider = UncheckedItemsCountFamily._();

/// Provider for unchecked items count in a category

final class UncheckedItemsCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Provider for unchecked items count in a category
  UncheckedItemsCountProvider._({
    required UncheckedItemsCountFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'uncheckedItemsCountProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$uncheckedItemsCountHash();

  @override
  String toString() {
    return r'uncheckedItemsCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    final argument = this.argument as String?;
    return uncheckedItemsCount(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UncheckedItemsCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$uncheckedItemsCountHash() =>
    r'6faf4a87c9d6c0ed1640c1de11edf16aa9e1cee4';

/// Provider for unchecked items count in a category

final class UncheckedItemsCountFamily extends $Family
    with $FunctionalFamilyOverride<int, String?> {
  UncheckedItemsCountFamily._()
    : super(
        retry: null,
        name: r'uncheckedItemsCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for unchecked items count in a category

  UncheckedItemsCountProvider call(String? categoryId) =>
      UncheckedItemsCountProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'uncheckedItemsCountProvider';
}

/// Notifier for purchase history

@ProviderFor(PurchaseHistoryNotifier)
final purchaseHistoryProvider = PurchaseHistoryNotifierProvider._();

/// Notifier for purchase history
final class PurchaseHistoryNotifierProvider
    extends $NotifierProvider<PurchaseHistoryNotifier, PurchaseHistoryState> {
  /// Notifier for purchase history
  PurchaseHistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseHistoryNotifierHash();

  @$internal
  @override
  PurchaseHistoryNotifier create() => PurchaseHistoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseHistoryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseHistoryState>(value),
    );
  }
}

String _$purchaseHistoryNotifierHash() =>
    r'b598a7e125cd30cfb8c097431b367de2c486ccc4';

/// Notifier for purchase history

abstract class _$PurchaseHistoryNotifier
    extends $Notifier<PurchaseHistoryState> {
  PurchaseHistoryState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PurchaseHistoryState, PurchaseHistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PurchaseHistoryState, PurchaseHistoryState>,
              PurchaseHistoryState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
