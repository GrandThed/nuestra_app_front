import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/assistant/domain/assistant_request.dart';
import 'package:nuestra_app/features/assistant/domain/chat_items.dart';
import 'package:nuestra_app/features/assistant/domain/spanish_parsing.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/data/repositories/expense_repository.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';

typedef FormBuilder = List<Map<String, Object?>> Function(String surfaceId);

/// What an action produces, in order.
sealed class Output {
  const Output();
}

/// A card with data (saved in the conversation).
class CardOut extends Output {
  final DataCard card;
  const CardOut(this.card);
}

/// A line written by the app, not the model (saved as a reply).
class TextOut extends Output {
  final String text;
  const TextOut(this.text);
}

/// A form to fill in.
class FormOut extends Output {
  final FormBuilder form;
  const FormOut(this.form);
}

/// Changes to the expense waiting on screen ("no, eran 8000").
class DraftPatch extends Output {
  final double? amount;
  final DateTime? date;
  final ExpenseCategoryModel? category;
  final String? description;
  const DraftPatch({this.amount, this.date, this.category, this.description});

  bool get isEmpty => amount == null && date == null && category == null && description == null;
}

/// The model answers in its own words.
class ChatOut extends Output {
  const ChatOut();
}

final _monthName = DateFormat('MMMM', 'es');

String monthLabel(int year, int month, DateTime now) {
  final name = _monthName.format(DateTime(year, month));
  return year == now.year ? name : '$name $year';
}

String _capitalize(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

/// Turns a read request into cards, using the app's data. Everything shown
/// (amounts, totals, lists) comes from here, never from the model.
class AssistantActions {
  final ExpenseRepository expenses;
  final FoodRepository food;
  final String householdId;
  final List<ExpenseCategoryModel> categories;
  final List<FormMember> members;
  final DateTime Function() now;

  AssistantActions({
    required this.expenses,
    required this.food,
    required this.householdId,
    required this.categories,
    this.members = const [],
    DateTime Function()? now,
  }) : now = now ?? DateTime.now;

  /// The first-time food questions are shown once per conversation.
  bool profileAsked = false;

  /// Recent expenses, to guess the category of a new one from how the
  /// household filed the same thing before. Loaded once.
  Future<List<ExpenseModel>>? _recent;

  Future<List<Output>> run(AssistantRequest r, String message) async {
    try {
      return switch (r.action) {
        RequestAction.anotarGasto => [await _draft(r, message)],
        RequestAction.corregirGasto => [_patch(r, message)],
        RequestAction.consultarGastos => [await _spending(r, message)],
        RequestAction.resumenMes => [await _summary(r, message)],
        RequestAction.gastosFijos => [await _fixed(r, message)],
        RequestAction.buscarReceta => await _recipes(r, message),
        RequestAction.cocinarConLoQueHay => await _withWhatWeHave(r),
        RequestAction.armarMenu => [await weekPlannerForm(parseDateEs(r.date, now()))],
        RequestAction.verMenu => [await _menu(r)],
        RequestAction.listaCompras => [_shopping(r)],
        RequestAction.guardarGusto => [await _taste(r)],
        RequestAction.repasarGustos => [await _reviewTastes()],
        RequestAction.invitados => const [FormOut(FoodForms.invitados)],
        RequestAction.deEstacion => [await _season()],
        RequestAction.charlar => const [ChatOut()],
      };
    } on AppException catch (e) {
      return [TextOut('No pude traer los datos: ${e.message}')];
    }
  }

  // ---------- Expenses ----------

  ExpenseCategoryModel? categoryNamed(String name) {
    final n = normalizeEs(name);
    if (n.isEmpty) return null;
    return categories.where((c) => normalizeEs(c.name) == n).firstOrNull ??
        categories.where((c) => normalizeEs(c.name).contains(n) || n.contains(normalizeEs(c.name))).firstOrNull;
  }

  Future<ExpenseCategoryModel?> _guessCategory(String description) async {
    final d = normalizeEs(description);
    if (d.isEmpty) return null;
    try {
      _recent ??= expenses.getExpensesInRange(
        householdId,
        from: now().subtract(const Duration(days: 180)),
        to: now(),
      );
      final counts = <String, int>{};
      for (final e in await _recent!) {
        final c = e.category;
        if (c == null) continue;
        final ed = normalizeEs(e.description);
        if (ed == d || ed.contains(d) || d.contains(ed)) counts[c.id] = (counts[c.id] ?? 0) + 1;
      }
      if (counts.isEmpty) return null;
      final best = (counts.entries.toList()..sort((a, b) => b.value - a.value)).first.key;
      return categories.where((c) => c.id == best).firstOrNull;
    } catch (e) {
      debugPrint('Could not guess category: $e');
      return null;
    }
  }

  /// "7.000 de nafta ayer": amount, date and category read in code.
  Future<Output> _draft(AssistantRequest r, String message) async {
    final amount = amountFor(r.amount, message);
    final date = parseDateEs(r.date, now()) ?? parseDateEs(message, now()) ?? DateTime(now().year, now().month, now().day);
    final description = _capitalize(r.description.isNotEmpty ? r.description : _descriptionFrom(message));
    // How the household filed it before wins over the model's guess
    final category = await _guessCategory(description) ?? categoryNamed(r.category);
    return CardOut(ExpenseDraftCard(
      description: description,
      amount: amount,
      date: date,
      categoryId: category?.id,
      categoryName: category?.name,
    ));
  }

  Output _patch(AssistantRequest r, String message) {
    final amount = r.amount.isEmpty ? null : amountFor(r.amount, message);
    return DraftPatch(
      amount: amount,
      date: r.date.isEmpty ? null : parseDateEs(r.date, now()),
      category: categoryNamed(r.category),
      description: r.description.isEmpty ? null : _capitalize(r.description),
    );
  }

  Future<Output> _spending(AssistantRequest r, String message) async {
    final (year, month) = parseMonthEs(r.month.isNotEmpty ? r.month : message, now());
    final term = r.search.isNotEmpty ? r.search : r.description;
    final category = categoryNamed(r.category) ?? categoryNamed(term);
    if (term.isEmpty && category == null) return _summary(r, message);

    final all = await expenses.getExpenses(householdId, month: month, year: year);
    final t = normalizeEs(term);
    final matches = all.where((e) {
      if (category != null && e.category?.id == category.id) return true;
      return t.isNotEmpty &&
          (normalizeEs(e.description).contains(t) || normalizeEs(e.category?.name ?? '').contains(t));
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return CardOut(SpendingCard(
      title: '${_capitalize(term.isNotEmpty ? term : category!.name)} · ${monthLabel(year, month, now())}',
      year: year,
      month: month,
      total: matches.fold(0.0, (s, e) => s + e.amount),
      count: matches.length,
      rows: [
        for (final e in matches.take(8))
          ExpenseRow(e.date, e.description, e.amount, e.paidBy.name, e.category?.name),
      ],
    ));
  }

  Future<Output> _summary(AssistantRequest r, String message) async {
    final (year, month) = parseMonthEs(r.month.isNotEmpty ? r.month : message, now());
    final all = await expenses.getExpenses(householdId, month: month, year: year);
    final byCategory = <String, (double, String?)>{};
    final byMember = <String, double>{};
    for (final e in all) {
      final name = e.category?.name ?? 'Sin categoría';
      final prev = byCategory[name];
      byCategory[name] = ((prev?.$1 ?? 0) + e.amount, e.category?.icon);
      byMember[e.paidBy.name] = (byMember[e.paidBy.name] ?? 0) + e.amount;
    }
    final cats = [for (final e in byCategory.entries) Slice(e.key, e.value.$1, icon: e.value.$2)]
      ..sort((a, b) => b.amount.compareTo(a.amount));
    final people = [for (final e in byMember.entries) Slice(e.key, e.value)]
      ..sort((a, b) => b.amount.compareTo(a.amount));
    return CardOut(MonthSummaryCard(
      year: year,
      month: month,
      total: all.fold(0.0, (s, e) => s + e.amount),
      count: all.length,
      byCategory: cats,
      byMember: people,
    ));
  }

  Future<Output> _fixed(AssistantRequest r, String message) async {
    final (year, month) = parseMonthEs(r.month.isNotEmpty ? r.month : message, now());
    final predictions = await expenses.getPredictions(householdId, month: month, year: year);
    if (predictions.isEmpty) {
      return TextOut('No falta cargar ningún gasto fijo de ${monthLabel(year, month, now())}.');
    }
    return CardOut(FixedExpensesCard(
      year: year,
      month: month,
      items: [
        for (final p in predictions) FixedExpense(p.description, p.suggestedAmount, p.dayOfMonth),
      ],
    ));
  }

  // ---------- Food ----------

  /// The first food request of a household that never answered the
  /// first-time questions shows them (once per conversation).
  Future<Output?> _profileFirst() async {
    if (profileAsked) return null;
    profileAsked = true;
    final profile = await food.profile(householdId);
    if (profile.onboarded) return null;
    final prefs = await food.preferences(householdId);
    return FormOut((id) => FoodForms.perfil(id, members: members, prefs: prefs));
  }

  Future<List<Output>> _recipes(AssistantRequest r, String message) async {
    final query = r.search.isNotEmpty ? r.search : r.description;
    final first = await _profileFirst();
    if (query.isEmpty && r.ingredients.isEmpty) {
      // "algo rico": ask what they feel like
      final profile = await food.profile(householdId);
      return [?first, FormOut((id) => FoodForms.aclararPedido(id, servings: profile.servings))];
    }
    return [
      ?first,
      await recipeSearch(
        title: 'Recetas${query.isEmpty ? '' : ' con ${query.toLowerCase()}'}',
        query: query.isEmpty ? r.ingredients.join(' ') : query,
        ingredient: r.ingredients.firstOrNull,
      ),
    ];
  }

  Future<List<Output>> _withWhatWeHave(AssistantRequest r) async {
    if (r.ingredients.isEmpty) return const [FormOut(FoodForms.heladera)];
    final first = await _profileFirst();
    return [
      ?first,
      await recipeSearch(
        title: 'Con ${r.ingredients.join(', ')}',
        query: r.ingredients.join(' '),
      ),
    ];
  }

  /// Search the catalog (already filtered by the household's preferences).
  Future<Output> recipeSearch({
    required String title,
    String? query,
    String? ingredient,
    String? mealType,
    int? maxMinutes,
  }) async {
    final result = await food.searchRecipes(
      householdId,
      query: query,
      ingredient: ingredient,
      mealType: mealType,
      maxMinutes: maxMinutes,
      limit: 5,
    );
    if (result.recipes.isEmpty) {
      return TextOut('No encontré recetas así que respeten sus gustos'
          '${result.excluded > 0 ? ' (dejé afuera ${result.excluded} por sus preferencias)' : ''}. '
          'Podés anotar una receta propia desde Comida → Recetas.');
    }
    return CardOut(RecipesCard(
      title: title,
      excluded: result.excluded,
      recipes: [for (final s in result.recipes) RecipeRow(s.slug, s.title, s.totalMinutes, _recipeNote(s))],
    ));
  }

  static String _recipeNote(RecipeSummary s) {
    if (s.omit.isNotEmpty) return 'sin ${s.omit.join(', ')}';
    if (s.why.isNotEmpty) return s.why.first;
    return [
      if (s.countryName.isNotEmpty) s.countryName,
      if (s.mainIngredients.isNotEmpty) s.mainIngredients.take(3).join(', '),
    ].join(' · ');
  }

  /// The week a plan is about: the one of [day], or this one (next one on
  /// weekends, when this one is almost over).
  DateTime planningMonday(DateTime? day) {
    final d = day ?? now();
    final monday = DateTime(d.year, d.month, d.day).subtract(Duration(days: d.weekday - 1));
    return day == null && d.weekday >= DateTime.saturday ? monday.add(const Duration(days: 7)) : monday;
  }

  Future<Output> weekPlannerForm(DateTime? day) async {
    final profile = await food.profile(householdId);
    final monday = planningMonday(day);
    return FormOut((id) => FoodForms.armarSemana(id, weekStart: monday, profile: profile));
  }

  Future<Output> _menu(AssistantRequest r) async {
    final day = parseDateEs(r.date, now()) ?? now();
    final week = await food.week(householdId, day);
    if (week.entries.isEmpty) {
      return const TextOut('Todavía no hay menú para esa semana. Decime "armá el menú" y lo hacemos.');
    }
    return CardOut(menuCard(week));
  }

  static MenuCard menuCard(MenuWeekData week) {
    const order = ['desayuno', 'almuerzo', 'merienda', 'cena'];
    final entries = [...week.entries]
      ..sort((a, b) => '${a.date}${order.indexOf(a.meal)}'.compareTo('${b.date}${order.indexOf(b.meal)}'));
    return MenuCard(
      weekStart: week.weekStart,
      slots: [for (final e in entries) MenuSlot(e.date, e.meal, e.title, e.recipe?.slug)],
    );
  }

  Output _shopping(AssistantRequest r) {
    final monday = planningMonday(parseDateEs(r.date, now()));
    return CardOut(LinkCard(
      title: 'Lista de compras',
      subtitle: 'Semana del ${DateFormat("d 'de' MMMM", 'es').format(monday)}',
      route: '/food/shopping?week=${isoDate(monday)}',
      icon: 'cart',
    ));
  }

  Future<Output> _taste(AssistantRequest r) async {
    const kinds = {'no_le_gusta': 'dislike', 'alergia': 'allergy', 'le_encanta': 'like'};
    final kind = kinds[r.taste] ?? 'dislike';
    final ingredient = r.ingredient.isNotEmpty ? r.ingredient : r.search;
    final person = normalizeEs(r.person);
    final member = person.isEmpty
        ? null
        : members.where((m) => normalizeEs(m.name).startsWith(person)).firstOrNull;
    if (ingredient.isEmpty) {
      return FormOut((id) => FoodForms.confirmarPreferencia(id, members: members, kind: kind));
    }
    try {
      final pref = await food.savePreference(householdId, kind: kind, ingredient: ingredient, memberUserId: member?.id);
      const verbs = {'dislike': 'No les gusta', 'allergy': 'Alergia', 'like': 'Les encanta'};
      return CardOut(PreferenceCard(
        label: '${verbs[kind]}: ${pref.label}${member == null ? '' : ' (${member.name})'}',
        preferenceId: pref.id,
      ));
    } on ValidationException {
      // Not in the ingredient catalog: let them correct or confirm it
      return FormOut((id) => FoodForms.confirmarPreferencia(id, members: members, ingredient: ingredient, kind: kind));
    }
  }

  Future<Output> _reviewTastes() async {
    final profile = await food.profile(householdId);
    final prefs = await food.preferences(householdId);
    return FormOut((id) => FoodForms.repasarPreferencias(id, prefs: prefs, profile: profile));
  }

  Future<Output> _season() async {
    final produce = await food.seasonIngredients(householdId);
    return FormOut((id) => FoodForms.deEstacion(id, ingredients: produce));
  }
}

/// The amount in a whole message, skipping numbers that are part of a date
/// ("el 15", "15/11").
double? amountInMessage(String message) {
  final cleaned = message
      .replaceAll(RegExp(r'\b\d{1,2}/\d{1,2}(/\d{2,4})?\b'), ' ')
      .replaceAll(RegExp(r'\b(el|del|desde el|hasta el) \d{1,2}\b', caseSensitive: false), ' ')
      .replaceAll(RegExp(r'\b\d{1,2} de [a-záéíóú]+\b', caseSensitive: false), ' ')
      .replaceAll(RegExp(r'\b\d+ cuotas?\b', caseSensitive: false), ' ');
  return parseAmountAr(cleaned);
}

/// The amount the user wrote. The model only points at which number it is:
/// its copy can change the punctuation ("75.000" → "75,000"), so the number
/// with the same digits is read from the message itself.
double? amountFor(String copied, String message) {
  final digits = copied.replaceAll(RegExp(r'\D'), '');
  if (digits.isNotEmpty) {
    // Each number in the message with the word after it ("75.000", "15 lucas")
    for (final n in RegExp(r'\d[\d.,]*(?:\s*[a-zA-Zóñ]+)?').allMatches(message)) {
      final token = n[0]!;
      if (token.replaceAll(RegExp(r'\D'), '') == digits) return parseAmountAr(token);
    }
  }
  // The copy matches nothing the user wrote: the message wins
  return amountInMessage(message) ?? parseAmountAr(copied);
}

/// "gasté 7000 en nafta" → "nafta": a fallback when the model gave none.
String _descriptionFrom(String message) {
  final m = RegExp(r'\b(?:en|de|por|del|la|el)\s+([a-záéíóúñ ]{3,30})', caseSensitive: false).firstMatch(message);
  final text = (m?[1] ?? message).trim();
  return text.length > 40 ? text.substring(0, 40) : text;
}
