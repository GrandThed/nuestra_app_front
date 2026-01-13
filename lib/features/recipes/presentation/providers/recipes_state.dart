import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';

part 'recipes_state.freezed.dart';

/// State for recipes list
@freezed
sealed class RecipesState with _$RecipesState {
  const factory RecipesState.initial() = RecipesStateInitial;
  const factory RecipesState.loading() = RecipesStateLoading;
  const factory RecipesState.loaded(List<RecipeModel> recipes) = RecipesStateLoaded;
  const factory RecipesState.error(String message) = RecipesStateError;
}

/// State for single recipe detail
@freezed
sealed class RecipeDetailState with _$RecipeDetailState {
  const factory RecipeDetailState.initial() = RecipeDetailStateInitial;
  const factory RecipeDetailState.loading() = RecipeDetailStateLoading;
  const factory RecipeDetailState.loaded(RecipeModel recipe) = RecipeDetailStateLoaded;
  const factory RecipeDetailState.error(String message) = RecipeDetailStateError;
}

/// State for seasonal vegetables
@freezed
sealed class SeasonalVegetablesState with _$SeasonalVegetablesState {
  const factory SeasonalVegetablesState.initial() = SeasonalVegetablesStateInitial;
  const factory SeasonalVegetablesState.loading() = SeasonalVegetablesStateLoading;
  const factory SeasonalVegetablesState.loaded(List<SeasonalVegetableModel> vegetables) = SeasonalVegetablesStateLoaded;
  const factory SeasonalVegetablesState.error(String message) = SeasonalVegetablesStateError;
}
