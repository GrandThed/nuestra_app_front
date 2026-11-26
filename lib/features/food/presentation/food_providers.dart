import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderOrFamily;
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_form_handler.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_state.dart';

String _household(Ref ref) {
  final id = ref.watch(currentHouseholdIdProvider);
  if (id == null) throw StateError('No hay un hogar seleccionado');
  return id;
}

/// Monday of the week containing [day] (local calendar).
DateTime mondayOf(DateTime day) {
  final d = DateTime(day.year, day.month, day.day);
  return d.subtract(Duration(days: d.weekday - 1));
}

/// Household members, for "¿de quién es?" in the forms.
final foodMembersProvider = Provider<List<FormMember>>((ref) {
  final state = ref.watch(householdProvider);
  if (state is! HouseholdStateLoaded) return const [];
  return [
    for (final m in state.household.members ?? const []) (id: m.userId, name: m.name),
  ];
});

final foodFormHandlerProvider = Provider<FoodFormHandler>((ref) {
  return FoodFormHandler(
    ref.watch(foodRepositoryProvider),
    _household(ref),
    members: ref.watch(foodMembersProvider),
  );
});

final foodProfileProvider = FutureProvider<FoodProfile>((ref) {
  return ref.watch(foodRepositoryProvider).profile(_household(ref));
});

final foodPreferencesProvider = FutureProvider<List<FoodPreference>>((ref) {
  return ref.watch(foodRepositoryProvider).preferences(_household(ref));
});

/// The week shown in the Menú tab (its Monday).
class SelectedWeekNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => mondayOf(DateTime.now());

  void previous() => state = state.subtract(const Duration(days: 7));
  void next() => state = state.add(const Duration(days: 7));
  void thisWeek() => state = mondayOf(DateTime.now());
}

final selectedWeekProvider =
    NotifierProvider<SelectedWeekNotifier, DateTime>(SelectedWeekNotifier.new);

final menuWeekProvider = FutureProvider.family<MenuWeekData, DateTime>((ref, monday) {
  return ref.watch(foodRepositoryProvider).week(_household(ref), monday);
});

final shoppingListProvider = FutureProvider.family<List<ShoppingGroup>, DateTime>((ref, monday) {
  return ref.watch(foodRepositoryProvider).shopping(_household(ref), monday);
});

/// Search box and meal filter of the Recetas tab.
class RecipeQuery {
  final String text;
  final String? mealType;
  const RecipeQuery({this.text = '', this.mealType});
}

class RecipeQueryNotifier extends Notifier<RecipeQuery> {
  @override
  RecipeQuery build() => const RecipeQuery();

  void setText(String text) => state = RecipeQuery(text: text, mealType: state.mealType);
  void setMealType(String? meal) => state = RecipeQuery(text: state.text, mealType: meal);
}

final recipeQueryProvider =
    NotifierProvider<RecipeQueryNotifier, RecipeQuery>(RecipeQueryNotifier.new);

final recipeSearchProvider = FutureProvider<RecipeSearchResult>((ref) {
  final q = ref.watch(recipeQueryProvider);
  return ref.watch(foodRepositoryProvider).searchRecipes(
        _household(ref),
        query: q.text,
        mealType: q.mealType,
        limit: 10,
      );
});

final recipeDetailProvider =
    FutureProvider.family<RecipeDetail, ({String slug, int? servings})>((ref, args) {
  return ref.watch(foodRepositoryProvider).recipe(_household(ref), args.slug, servings: args.servings);
});

/// Reload whatever a form changed. Pass `ref.invalidate` (WidgetRef or Ref).
void refreshFood(void Function(ProviderOrFamily) invalidate, Set<FoodData> changed) {
  if (changed.contains(FoodData.preferences)) {
    invalidate(foodPreferencesProvider);
    invalidate(recipeSearchProvider);
  }
  if (changed.contains(FoodData.profile)) invalidate(foodProfileProvider);
  if (changed.contains(FoodData.menu)) {
    invalidate(menuWeekProvider);
    invalidate(shoppingListProvider);
  }
  if (changed.contains(FoodData.recipes)) {
    invalidate(recipeSearchProvider);
    invalidate(recipeDetailProvider);
  }
}
