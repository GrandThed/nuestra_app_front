import 'package:flutter/foundation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';

/// Picks one recipe among [options] for a meal. Returns its slug, or null to
/// take the first (best ranked) one.
typedef RecipePicker = Future<String?> Function({
  required String day,
  required String meal,
  required List<RecipeSummary> options,
  required String notes,
});

/// What the "armar la semana" form asked for.
class WeekPlanRequest {
  final List<DateTime> days;
  final List<String> meals;
  final int? servings;
  final bool leftovers;
  final String notes;

  const WeekPlanRequest({
    required this.days,
    required this.meals,
    this.servings,
    this.leftovers = false,
    this.notes = '',
  });

  factory WeekPlanRequest.fromForm(Map<String, dynamic> form) => WeekPlanRequest(
        days: [
          for (final d in form['dias'] as List? ?? const [])
            if (DateTime.tryParse('$d') case final day?) day,
        ]..sort(),
        meals: [for (final m in form['comidas'] as List? ?? const []) '$m'],
        servings: (form['porciones'] as num?)?.round(),
        leftovers: form['sobras'] == true,
        notes: '${form['notas'] ?? ''}'.trim(),
      );
}

/// Fills the week slot by slot. The backend ranks the options that respect
/// the household's rules (and keeps variety); the picker (the model) chooses
/// among them. A pick the backend refuses moves on to the next option.
class WeekPlanner {
  final FoodRepository repo;
  final String householdId;
  final RecipePicker? pick;

  WeekPlanner(this.repo, this.householdId, {this.pick});

  static const _names = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'];

  static String dayName(DateTime d) => '${_names[d.weekday - 1]} ${d.day}';

  /// Plan [request]; [onProgress] gets "lunes 24" as each day starts.
  /// Returns the week as it ended up.
  Future<MenuWeekData> plan(
    WeekPlanRequest request, {
    void Function(String day)? onProgress,
    bool Function()? isCancelled,
  }) async {
    MenuEntry? lastDinner;
    for (final day in request.days) {
      if (isCancelled?.call() ?? false) break;
      onProgress?.call(dayName(day));
      for (final meal in request.meals) {
        // Lunch from last night's dinner, when they asked for it
        if (request.leftovers && meal == 'almuerzo' && lastDinner != null) {
          try {
            await repo.setEntry(householdId, day, meal, leftoverOf: lastDinner.id);
            continue;
          } on AppException catch (e) {
            debugPrint('Leftovers not set: ${e.message}');
          }
        }
        final entry = await _fill(day, meal, request);
        if (meal == 'cena') lastDinner = entry;
      }
    }
    return repo.week(householdId, request.days.isEmpty ? DateTime.now() : request.days.first);
  }

  Future<MenuEntry?> _fill(DateTime day, String meal, WeekPlanRequest request) async {
    final options = await repo.candidates(householdId, day, meal, limit: 5);
    if (options.isEmpty) return null;
    String? chosen;
    try {
      chosen = await pick?.call(day: dayName(day), meal: meal, options: options, notes: request.notes);
    } catch (e) {
      debugPrint('Recipe pick failed, using the best ranked: $e');
    }
    final ordered = [
      ...options.where((o) => o.slug == chosen),
      ...options.where((o) => o.slug != chosen),
    ];
    for (final option in ordered) {
      try {
        return await repo.setEntry(householdId, day, meal, recipeSlug: option.slug, servings: request.servings);
      } on AppException catch (e) {
        // 409: breaks a household rule (e.g. "no repetir"): next option
        debugPrint('Option ${option.slug} refused: ${e.message}');
      }
    }
    return null;
  }
}
