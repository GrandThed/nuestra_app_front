import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/core/utils/file_utils.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';
import 'package:nuestra_app/features/recipes/data/repositories/recipe_repository.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';

part 'recipes_notifier.g.dart';

/// Notifier for recipes list operations
@Riverpod(keepAlive: true)
class RecipesNotifier extends _$RecipesNotifier {
  late final RecipeRepository _repository;

  @override
  RecipesState build() {
    _repository = ref.watch(recipeRepositoryProvider);
    return const RecipesState.initial();
  }

  /// Load recipes only if not already loaded (for screen init)
  Future<void> loadRecipesIfNeeded() async {
    if (state is RecipesStateInitial || state is RecipesStateError) {
      await loadRecipes();
    }
  }

  /// Load all recipes for current household
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadRecipes({
    String? search,
    String? season,
    bool? favorites,
    int? maxPrepTime,
    int? maxCookTime,
    bool forceLoading = false,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const RecipesState.error('No hay hogar seleccionado');
      return;
    }

    final hasData = state is RecipesStateLoaded;
    if (!hasData || forceLoading) {
      state = const RecipesState.loading();
    }

    try {
      final recipes = await _repository.getRecipes(
        householdId,
        search: search,
        season: season,
        favorites: favorites,
        maxPrepTime: maxPrepTime,
        maxCookTime: maxCookTime,
      );
      state = RecipesState.loaded(recipes);
    } on AppException catch (e) {
      if (!hasData) {
        state = RecipesState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = RecipesState.error('Error al cargar recetas: $e');
      }
    }
  }

  /// Create a new recipe
  Future<RecipeModel?> createRecipe({
    required String title,
    List<IngredientModel>? ingredients,
    List<String>? instructions,
    int? servings,
    String? sourceUrl,
    File? image,
  }) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final recipe = await _repository.createRecipe(
        householdId: householdId,
        title: title,
        ingredients: ingredients,
        instructions: instructions,
        servings: servings,
        sourceUrl: sourceUrl,
        image: image,
      );

      // Add to current list
      final currentState = state;
      if (currentState is RecipesStateLoaded) {
        state = RecipesState.loaded([recipe, ...currentState.recipes]);
      } else {
        state = RecipesState.loaded([recipe]);
      }

      return recipe;
    } on AppException catch (e) {
      debugPrint('Error creating recipe: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error creating recipe: $e');
      return null;
    }
  }

  /// Delete a recipe (optimistic)
  Future<bool> deleteRecipe(String id) async {
    final previousState = state;

    // Optimistically remove from list
    final currentState = state;
    if (currentState is RecipesStateLoaded) {
      state = RecipesState.loaded(
        currentState.recipes.where((r) => r.id != id).toList(),
      );
    }

    try {
      await _repository.deleteRecipe(id);
      return true;
    } catch (e) {
      state = previousState;
      debugPrint('Error deleting recipe: $e');
      return false;
    }
  }

  /// Update recipe in list (after detail edit)
  void updateRecipeInList(RecipeModel recipe) {
    final currentState = state;
    if (currentState is RecipesStateLoaded) {
      final updatedRecipes = currentState.recipes.map((r) {
        return r.id == recipe.id ? recipe : r;
      }).toList();
      state = RecipesState.loaded(updatedRecipes);
    }
  }

  /// Import a recipe from a URL using LLM extraction
  Future<RecipeModel?> importFromUrl(String householdId, String url) async {
    try {
      final recipe = await _repository.importFromUrl(householdId, url);

      // Add to current list
      final currentState = state;
      if (currentState is RecipesStateLoaded) {
        state = RecipesState.loaded([recipe, ...currentState.recipes]);
      } else {
        state = RecipesState.loaded([recipe]);
      }

      return recipe;
    } on AppException catch (e) {
      debugPrint('Error importing recipe from URL: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error importing recipe from URL: $e');
      return null;
    }
  }
}

/// Notifier for single recipe detail operations
@Riverpod(keepAlive: true)
class RecipeDetailNotifier extends _$RecipeDetailNotifier {
  late final RecipeRepository _repository;

  @override
  RecipeDetailState build(String recipeId) {
    _repository = ref.watch(recipeRepositoryProvider);
    return const RecipeDetailState.initial();
  }

  /// Load recipe only if not already loaded
  Future<void> loadRecipeIfNeeded() async {
    if (state is RecipeDetailStateInitial || state is RecipeDetailStateError) {
      await loadRecipe();
    }
  }

  /// Load recipe detail
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadRecipe({bool forceLoading = false}) async {
    final hasData = state is RecipeDetailStateLoaded;

    if (!hasData || forceLoading) {
      state = const RecipeDetailState.loading();
    }

    try {
      final recipe = await _repository.getRecipe(recipeId);
      state = RecipeDetailState.loaded(recipe);
    } on AppException catch (e) {
      if (!hasData) {
        state = RecipeDetailState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = RecipeDetailState.error('Error al cargar receta: $e');
      }
    }
  }

  /// Update the recipe
  Future<RecipeModel?> updateRecipe({
    String? title,
    List<IngredientModel>? ingredients,
    List<String>? instructions,
    int? servings,
    String? sourceUrl,
    File? image,
  }) async {
    try {
      final recipe = await _repository.updateRecipe(
        id: recipeId,
        title: title,
        ingredients: ingredients,
        instructions: instructions,
        servings: servings,
        sourceUrl: sourceUrl,
        image: image,
      );

      state = RecipeDetailState.loaded(recipe);

      // Update recipes list
      ref.read(recipesNotifierProvider.notifier).updateRecipeInList(recipe);

      return recipe;
    } on AppException catch (e) {
      debugPrint('Error updating recipe: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error updating recipe: $e');
      return null;
    }
  }

  /// Rate the recipe (create or update rating)
  /// Returns the created/updated rating, or null on failure
  Future<RecipeRatingModel?> rateRecipe(int rating, {String? note}) async {
    try {
      final ratingModel = await _repository.rateRecipe(
        recipeId,
        rating,
        note: note,
      );

      // Background refresh to get updated averageRating and ratings list
      loadRecipe();

      return ratingModel;
    } on AppException catch (e) {
      debugPrint('Error rating recipe: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error rating recipe: $e');
      return null;
    }
  }

  /// Toggle favorite status for the recipe (optimistic)
  Future<void> toggleFavorite() async {
    final previousState = state;

    // Optimistically toggle favorite
    final currentState = state;
    if (currentState is RecipeDetailStateLoaded) {
      final updatedRecipe = currentState.recipe.copyWith(
        isFavorite: !currentState.recipe.isFavorite,
      );
      state = RecipeDetailState.loaded(updatedRecipe);

      // Also update in the recipes list
      ref
          .read(recipesNotifierProvider.notifier)
          .updateRecipeInList(updatedRecipe);
    }

    try {
      final isFavorite = await _repository.toggleFavorite(recipeId);

      // Sync with server response (in case it differs)
      final current = state;
      if (current is RecipeDetailStateLoaded) {
        final synced = current.recipe.copyWith(isFavorite: isFavorite);
        state = RecipeDetailState.loaded(synced);
        ref.read(recipesNotifierProvider.notifier).updateRecipeInList(synced);
      }
    } catch (e) {
      state = previousState;
      // Also revert recipes list
      if (previousState is RecipeDetailStateLoaded) {
        ref
            .read(recipesNotifierProvider.notifier)
            .updateRecipeInList(previousState.recipe);
      }
      debugPrint('Error toggling favorite: $e');
    }
  }
}

/// Notifier for seasonal vegetables
@Riverpod(keepAlive: true)
class SeasonalVegetablesNotifier extends _$SeasonalVegetablesNotifier {
  late final RecipeRepository _repository;

  @override
  SeasonalVegetablesState build() {
    _repository = ref.watch(recipeRepositoryProvider);
    return const SeasonalVegetablesState.initial();
  }

  /// Load vegetables only if not already loaded (for screen init)
  Future<void> loadVegetablesIfNeeded() async {
    if (state is SeasonalVegetablesStateInitial ||
        state is SeasonalVegetablesStateError) {
      await loadVegetables();
    }
  }

  /// Load seasonal vegetables for current household
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadVegetables({bool forceLoading = false}) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const SeasonalVegetablesState.error('No hay hogar seleccionado');
      return;
    }

    final hasData = state is SeasonalVegetablesStateLoaded;

    if (!hasData || forceLoading) {
      state = const SeasonalVegetablesState.loading();
    }

    try {
      final vegetables = await _repository.getSeasonalVegetables(householdId);
      state = SeasonalVegetablesState.loaded(vegetables);
    } on AppException catch (e) {
      if (!hasData) {
        state = SeasonalVegetablesState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = SeasonalVegetablesState.error('Error al cargar verduras: $e');
      }
    }
  }
}
