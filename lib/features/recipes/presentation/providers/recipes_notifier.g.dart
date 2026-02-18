// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recipesNotifierHash() => r'6e833063fb200cb338c0ade761a6998cbfb5b5a2';

/// Notifier for recipes list operations
///
/// Copied from [RecipesNotifier].
@ProviderFor(RecipesNotifier)
final recipesNotifierProvider =
    NotifierProvider<RecipesNotifier, RecipesState>.internal(
      RecipesNotifier.new,
      name: r'recipesNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$recipesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RecipesNotifier = Notifier<RecipesState>;
String _$recipeDetailNotifierHash() =>
    r'9e055a1353ddd9b13b136c757b28ecb9d2f4ca54';

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

abstract class _$RecipeDetailNotifier
    extends BuildlessNotifier<RecipeDetailState> {
  late final String recipeId;

  RecipeDetailState build(String recipeId);
}

/// Notifier for single recipe detail operations
///
/// Copied from [RecipeDetailNotifier].
@ProviderFor(RecipeDetailNotifier)
const recipeDetailNotifierProvider = RecipeDetailNotifierFamily();

/// Notifier for single recipe detail operations
///
/// Copied from [RecipeDetailNotifier].
class RecipeDetailNotifierFamily extends Family<RecipeDetailState> {
  /// Notifier for single recipe detail operations
  ///
  /// Copied from [RecipeDetailNotifier].
  const RecipeDetailNotifierFamily();

  /// Notifier for single recipe detail operations
  ///
  /// Copied from [RecipeDetailNotifier].
  RecipeDetailNotifierProvider call(String recipeId) {
    return RecipeDetailNotifierProvider(recipeId);
  }

  @override
  RecipeDetailNotifierProvider getProviderOverride(
    covariant RecipeDetailNotifierProvider provider,
  ) {
    return call(provider.recipeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recipeDetailNotifierProvider';
}

/// Notifier for single recipe detail operations
///
/// Copied from [RecipeDetailNotifier].
class RecipeDetailNotifierProvider
    extends NotifierProviderImpl<RecipeDetailNotifier, RecipeDetailState> {
  /// Notifier for single recipe detail operations
  ///
  /// Copied from [RecipeDetailNotifier].
  RecipeDetailNotifierProvider(String recipeId)
    : this._internal(
        () => RecipeDetailNotifier()..recipeId = recipeId,
        from: recipeDetailNotifierProvider,
        name: r'recipeDetailNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$recipeDetailNotifierHash,
        dependencies: RecipeDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            RecipeDetailNotifierFamily._allTransitiveDependencies,
        recipeId: recipeId,
      );

  RecipeDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipeId,
  }) : super.internal();

  final String recipeId;

  @override
  RecipeDetailState runNotifierBuild(covariant RecipeDetailNotifier notifier) {
    return notifier.build(recipeId);
  }

  @override
  Override overrideWith(RecipeDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecipeDetailNotifierProvider._internal(
        () => create()..recipeId = recipeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipeId: recipeId,
      ),
    );
  }

  @override
  NotifierProviderElement<RecipeDetailNotifier, RecipeDetailState>
  createElement() {
    return _RecipeDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeDetailNotifierProvider && other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecipeDetailNotifierRef on NotifierProviderRef<RecipeDetailState> {
  /// The parameter `recipeId` of this provider.
  String get recipeId;
}

class _RecipeDetailNotifierProviderElement
    extends NotifierProviderElement<RecipeDetailNotifier, RecipeDetailState>
    with RecipeDetailNotifierRef {
  _RecipeDetailNotifierProviderElement(super.provider);

  @override
  String get recipeId => (origin as RecipeDetailNotifierProvider).recipeId;
}

String _$seasonalVegetablesNotifierHash() =>
    r'ed7782d05b58bd113835792e1b20be4944ed5620';

/// Notifier for seasonal vegetables
///
/// Copied from [SeasonalVegetablesNotifier].
@ProviderFor(SeasonalVegetablesNotifier)
final seasonalVegetablesNotifierProvider = NotifierProvider<
  SeasonalVegetablesNotifier,
  SeasonalVegetablesState
>.internal(
  SeasonalVegetablesNotifier.new,
  name: r'seasonalVegetablesNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$seasonalVegetablesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SeasonalVegetablesNotifier = Notifier<SeasonalVegetablesState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
