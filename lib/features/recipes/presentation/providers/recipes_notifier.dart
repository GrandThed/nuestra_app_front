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
  Future<void> loadRecipes({String? search, String? season, bool forceLoading = false}) async {
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

  /// Delete a recipe
  Future<bool> deleteRecipe(String id) async {
    try {
      await _repository.deleteRecipe(id);

      // Remove from current list
      final currentState = state;
      if (currentState is RecipesStateLoaded) {
        final updatedRecipes =
            currentState.recipes.where((r) => r.id != id).toList();
        state = RecipesState.loaded(updatedRecipes);
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting recipe: ${e.message}');
      return false;
    } catch (e) {
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
}

/// Notifier for seasonal vegetables
@riverpod
class SeasonalVegetablesNotifier extends _$SeasonalVegetablesNotifier {
  late final RecipeRepository _repository;

  @override
  SeasonalVegetablesState build() {
    _repository = ref.watch(recipeRepositoryProvider);
    return const SeasonalVegetablesState.initial();
  }

  /// Load seasonal vegetables for current household
  Future<void> loadVegetables() async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const SeasonalVegetablesState.error('No hay hogar seleccionado');
      return;
    }

    state = const SeasonalVegetablesState.loading();

    try {
      final vegetables = await _repository.getSeasonalVegetables(householdId);
      state = SeasonalVegetablesState.loaded(vegetables);
    } on AppException catch (e) {
      state = SeasonalVegetablesState.error(e.message);
    } catch (e) {
      state = SeasonalVegetablesState.error('Error al cargar verduras: $e');
    }
  }
}
