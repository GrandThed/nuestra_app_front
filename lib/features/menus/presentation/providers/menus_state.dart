import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/menus/data/models/menu_model.dart';

part 'menus_state.freezed.dart';

/// State for menu plans list
@freezed
sealed class MenuPlansState with _$MenuPlansState {
  const factory MenuPlansState.initial() = MenuPlansStateInitial;
  const factory MenuPlansState.loading() = MenuPlansStateLoading;
  const factory MenuPlansState.loaded(List<MenuPlanModel> plans) = MenuPlansStateLoaded;
  const factory MenuPlansState.error(String message) = MenuPlansStateError;
}

/// State for single menu plan detail
@freezed
sealed class MenuPlanDetailState with _$MenuPlanDetailState {
  const factory MenuPlanDetailState.initial() = MenuPlanDetailStateInitial;
  const factory MenuPlanDetailState.loading() = MenuPlanDetailStateLoading;
  const factory MenuPlanDetailState.loaded(MenuPlanModel plan) = MenuPlanDetailStateLoaded;
  const factory MenuPlanDetailState.error(String message) = MenuPlanDetailStateError;
}

/// State for upcoming meals (weekly view)
@freezed
sealed class UpcomingMealsState with _$UpcomingMealsState {
  const factory UpcomingMealsState.initial() = UpcomingMealsStateInitial;
  const factory UpcomingMealsState.loading() = UpcomingMealsStateLoading;
  const factory UpcomingMealsState.loaded(
    List<MenuItemModel> items,
    DateTime weekStart,
  ) = UpcomingMealsStateLoaded;
  const factory UpcomingMealsState.error(String message) = UpcomingMealsStateError;
}

/// State for shopping list generation
@freezed
sealed class ShoppingListState with _$ShoppingListState {
  const factory ShoppingListState.initial() = ShoppingListStateInitial;
  const factory ShoppingListState.generating() = ShoppingListStateGenerating;
  const factory ShoppingListState.success(ShoppingListResultModel result) = ShoppingListStateSuccess;
  const factory ShoppingListState.error(String message) = ShoppingListStateError;
}
