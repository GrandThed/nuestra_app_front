// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for recipes list operations

@ProviderFor(RecipesNotifier)
final recipesProvider = RecipesNotifierProvider._();

/// Notifier for recipes list operations
final class RecipesNotifierProvider
    extends $NotifierProvider<RecipesNotifier, RecipesState> {
  /// Notifier for recipes list operations
  RecipesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipesNotifierHash();

  @$internal
  @override
  RecipesNotifier create() => RecipesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecipesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecipesState>(value),
    );
  }
}

String _$recipesNotifierHash() => r'216c975074b1fae0bd0aa9ae1b938ef8370fa74c';

/// Notifier for recipes list operations

abstract class _$RecipesNotifier extends $Notifier<RecipesState> {
  RecipesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RecipesState, RecipesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecipesState, RecipesState>,
              RecipesState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for single recipe detail operations

@ProviderFor(RecipeDetailNotifier)
final recipeDetailProvider = RecipeDetailNotifierFamily._();

/// Notifier for single recipe detail operations
final class RecipeDetailNotifierProvider
    extends $NotifierProvider<RecipeDetailNotifier, RecipeDetailState> {
  /// Notifier for single recipe detail operations
  RecipeDetailNotifierProvider._({
    required RecipeDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'recipeDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$recipeDetailNotifierHash();

  @override
  String toString() {
    return r'recipeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RecipeDetailNotifier create() => RecipeDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecipeDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecipeDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RecipeDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recipeDetailNotifierHash() =>
    r'862a16c923af9cbcbdf55ecefd8309e3887fbcb6';

/// Notifier for single recipe detail operations

final class RecipeDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          RecipeDetailNotifier,
          RecipeDetailState,
          RecipeDetailState,
          RecipeDetailState,
          String
        > {
  RecipeDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'recipeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for single recipe detail operations

  RecipeDetailNotifierProvider call(String recipeId) =>
      RecipeDetailNotifierProvider._(argument: recipeId, from: this);

  @override
  String toString() => r'recipeDetailProvider';
}

/// Notifier for single recipe detail operations

abstract class _$RecipeDetailNotifier extends $Notifier<RecipeDetailState> {
  late final _$args = ref.$arg as String;
  String get recipeId => _$args;

  RecipeDetailState build(String recipeId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RecipeDetailState, RecipeDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecipeDetailState, RecipeDetailState>,
              RecipeDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Notifier for seasonal vegetables

@ProviderFor(SeasonalVegetablesNotifier)
final seasonalVegetablesProvider = SeasonalVegetablesNotifierProvider._();

/// Notifier for seasonal vegetables
final class SeasonalVegetablesNotifierProvider
    extends
        $NotifierProvider<SeasonalVegetablesNotifier, SeasonalVegetablesState> {
  /// Notifier for seasonal vegetables
  SeasonalVegetablesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seasonalVegetablesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seasonalVegetablesNotifierHash();

  @$internal
  @override
  SeasonalVegetablesNotifier create() => SeasonalVegetablesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeasonalVegetablesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeasonalVegetablesState>(value),
    );
  }
}

String _$seasonalVegetablesNotifierHash() =>
    r'ed7782d05b58bd113835792e1b20be4944ed5620';

/// Notifier for seasonal vegetables

abstract class _$SeasonalVegetablesNotifier
    extends $Notifier<SeasonalVegetablesState> {
  SeasonalVegetablesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<SeasonalVegetablesState, SeasonalVegetablesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SeasonalVegetablesState, SeasonalVegetablesState>,
              SeasonalVegetablesState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
