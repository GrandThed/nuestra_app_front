import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/assistant/application/assistant_actions.dart';
import 'package:nuestra_app/features/assistant/application/week_planner.dart';
import 'package:nuestra_app/features/assistant/data/assistant_history_repository.dart';
import 'package:nuestra_app/features/assistant/domain/assistant_request.dart';
import 'package:nuestra_app/features/assistant/domain/chat_items.dart';
import 'package:nuestra_app/features/assistant/domain/reply_suggestion.dart';
import 'package:nuestra_app/features/assistant/domain/spanish_parsing.dart';
import 'package:nuestra_app/features/assistant/presentation/assistant_controller.dart'
    show cleanModelText, stripOldCards;
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/data/repositories/expense_repository.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';

// A Thursday
final _now = DateTime(2026, 11, 26, 18, 30);

const _transporte = ExpenseCategoryModel(id: 'c-tr', name: 'Transporte', icon: '🚗');
const _super = ExpenseCategoryModel(id: 'c-su', name: 'Supermercado', icon: '🛒');
const _ana = ExpenseUserModel(id: 'u-ana', name: 'Ana');
const _beto = ExpenseUserModel(id: 'u-beto', name: 'Beto');

ExpenseModel _expense(String id, String description, double amount, DateTime date,
        {ExpenseCategoryModel? category, ExpenseUserModel paidBy = _ana}) =>
    ExpenseModel(
      id: id,
      householdId: 'h1',
      description: description,
      amount: amount,
      date: date,
      category: category,
      paidBy: paidBy,
    );

class _FakeExpenses implements ExpenseRepository {
  final List<ExpenseModel> all;
  _FakeExpenses(this.all);

  @override
  Future<List<ExpenseModel>> getExpenses(String householdId,
          {String? categoryId, String? paidById, int? month, int? year, bool? settled}) async =>
      all.where((e) => (month == null || e.date.month == month) && (year == null || e.date.year == year)).toList();

  @override
  Future<List<ExpenseModel>> getExpensesInRange(String householdId, {required DateTime from, required DateTime to}) async =>
      all.where((e) => !e.date.isBefore(from) && !e.date.isAfter(to)).toList();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeFood implements FoodRepository {
  final Map<String, List<RecipeSummary>> options;
  final Set<String> refused;
  final List<MenuEntry> entries = [];
  _FakeFood({this.options = const {}, this.refused = const {}});

  @override
  Future<List<RecipeSummary>> candidates(String householdId, DateTime day, String meal, {int limit = 5}) async =>
      options[meal] ?? const [];

  @override
  Future<MenuEntry> setEntry(String householdId, DateTime day, String meal,
      {String? recipeSlug, String? freeText, String? leftoverOf, int? servings, bool force = false}) async {
    if (recipeSlug != null && refused.contains(recipeSlug)) {
      throw const ServerException(message: 'No va: no repetir', statusCode: 409);
    }
    final entry = MenuEntry(
      id: 'e${entries.length + 1}',
      date: isoDate(day),
      meal: meal,
      recipe: recipeSlug == null ? null : RecipeSummary(slug: recipeSlug, title: recipeSlug),
      leftoverOfId: leftoverOf,
      servings: servings,
    );
    entries.add(entry);
    return entry;
  }

  @override
  Future<MenuWeekData> week(String householdId, DateTime day) async =>
      MenuWeekData(isoDate(day), const [], List.of(entries));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  group('amounts the Argentine way', () {
    test('thousands dots, decimal commas and slang', () {
      expect(parseAmountAr('7.000'), 7000);
      expect(parseAmountAr('7000'), 7000);
      expect(parseAmountAr(r'$ 1.029,50'), 1029.5);
      expect(parseAmountAr('7.000.000'), 7000000);
      expect(parseAmountAr('15 lucas'), 15000);
      expect(parseAmountAr('7k'), 7000);
      expect(parseAmountAr('3 mil'), 3000);
      expect(parseAmountAr('1,5 palos'), 1500000);
      expect(parseAmountAr('12,5'), 12.5);
      expect(parseAmountAr('99.90'), 99.9);
      expect(parseAmountAr('nada'), isNull);
    });

    test('a date in the message is not taken as the amount', () {
      expect(amountInMessage('gasté 7.000 de nafta el 15'), 7000);
      expect(amountInMessage('el 15 gasté 7000 en el súper'), 7000);
      expect(amountInMessage('15/11 luz 23.500'), 23500);
    });
  });

  group('dates and months', () {
    test('relative and written dates', () {
      expect(parseDateEs('hoy', _now), DateTime(2026, 11, 26));
      expect(parseDateEs('ayer', _now), DateTime(2026, 11, 25));
      expect(parseDateEs('anteayer', _now), DateTime(2026, 11, 24));
      expect(parseDateEs('el lunes', _now), DateTime(2026, 11, 23));
      expect(parseDateEs('el miércoles', _now), DateTime(2026, 11, 25));
      expect(parseDateEs('el jueves', _now), DateTime(2026, 11, 26));
      expect(parseDateEs('el 15', _now), DateTime(2026, 11, 15));
      expect(parseDateEs('el 28', _now), DateTime(2026, 10, 28));
      expect(parseDateEs('15/11', _now), DateTime(2026, 11, 15));
      expect(parseDateEs('28/12', _now), DateTime(2025, 12, 28));
      expect(parseDateEs('3 de noviembre', _now), DateTime(2026, 11, 3));
      expect(parseDateEs('', _now), isNull);
    });

    test('months', () {
      expect(parseMonthEs('este mes', _now), (2026, 11));
      expect(parseMonthEs('', _now), (2026, 11));
      expect(parseMonthEs('el mes pasado', _now), (2026, 10));
      expect(parseMonthEs('octubre', _now), (2026, 10));
      expect(parseMonthEs('diciembre', _now), (2025, 12));
      expect(parseMonthEs('2026-03', _now), (2026, 3));
    });

    test('short yes and no', () {
      for (final yes in ['sí', 'Si', 'dale', 'ok', 'Confirmo', 'sí, guardalo', 'dale gracias']) {
        expect(isYes(yes), isTrue, reason: yes);
      }
      for (final no in ['no', 'cancelá', 'dejalo', 'no gracias']) {
        expect(isNo(no), isTrue, reason: no);
      }
      expect(isYes('sí, cuánto gastamos de nafta?'), isFalse);
      expect(isNo('no le pusiste categoría'), isFalse);
    });
  });

  group('model text', () {
    test('markdown marks are removed', () {
      expect(cleanModelText('Propongo **\$7.000** en **Transporte**.'), 'Propongo \$7.000 en Transporte.');
      expect(cleanModelText('## Hola\n* uno\n- dos'), 'Hola\n• uno\n• dos');
      expect(cleanModelText('usé `proponer_gasto`'), 'usé proponer_gasto');
    });

    test('old replies lose their A2UI blocks', () {
      expect(stripOldCards('Listo.<a2ui-json>[{"x":1}]</a2ui-json>'), 'Listo.');
      expect(stripOldCards('Cortado <a2ui-json>[{"x"'), 'Cortado');
    });

    test('a request is read from the model JSON, anything odd is small talk', () {
      final r = AssistantRequest.fromJson({'accion': 'anotar_gasto', 'monto': '7.000', 'descripcion': 'Nafta'});
      expect(r.action, RequestAction.anotarGasto);
      expect(r.amount, '7.000');
      expect(AssistantRequest.fromJson({'accion': 'volar'}).action, RequestAction.charlar);
      expect(decodeJsonObject('```json\n{"accion":"charlar"}\n```'), {'accion': 'charlar'});
      final schema = requestSchema(['Transporte']);
      expect(((schema['properties'] as Map)['categoria'] as Map)['enum'], ['Transporte', '']);
    });

    test('examples never suggest a category the household does not have', () {
      final prompt = requestPrompt(categoryNames: const ['Alquiler']);
      expect(prompt, isNot(contains('"categoria":"Alquiler"')));
    });
  });

  group('cards', () {
    test('every card survives the saved JSON', () {
      final cards = <DataCard>[
        ExpenseDraftCard(description: 'Nafta', amount: 7000, date: DateTime(2026, 11, 26), categoryId: 'c', categoryName: 'Transporte'),
        SpendingCard(title: 'Nafta · noviembre', year: 2026, month: 11, total: 7000, count: 1,
            rows: [ExpenseRow(DateTime(2026, 11, 2), 'Nafta', 7000, 'Ana', 'Transporte')]),
        const MonthSummaryCard(year: 2026, month: 11, total: 10, count: 1, byCategory: [Slice('A', 10)], byMember: [Slice('Ana', 10)]),
        const FixedExpensesCard(year: 2026, month: 11, items: [FixedExpense('Luz', 23000, 5)]),
        const RecipesCard(title: 'Recetas', recipes: [RecipeRow('dal', 'Dal', 45, 'india')], excluded: 2),
        const MenuCard(weekStart: '2026-11-23', slots: [MenuSlot('2026-11-23', 'cena', 'Dal', 'dal')]),
        const PreferenceCard(label: 'No les gusta: remolacha', preferenceId: 'p1'),
        const LinkCard(title: 'Lista de compras', subtitle: 'x', route: '/food/shopping'),
      ];
      for (final card in cards) {
        final back = DataCard.fromJson(card.toJson(), messageId: 'm1')!;
        expect(back.toJson(), card.toJson(), reason: card.type);
        expect(back.messageId, 'm1');
      }
      expect(DataCard.fromJson({'type': 'nope'}), isNull);
    });

    test('a draft being saved when the app closed is stored as pending', () {
      final saving = ExpenseDraftCard(description: 'x', amount: 1, date: _now, status: DraftStatus.saving);
      expect(saving.toJson()['status'], 'pending');
    });

    test('conversation ids are accepted by the backend format', () {
      final id = AssistantHistoryRepository.newConversationId();
      expect(RegExp(r'^[A-Za-z0-9-]{8,64}$').hasMatch(id), isTrue);
    });
  });

  group('actions use the app data, not the model', () {
    final history = [
      _expense('1', 'Nafta', 6500, DateTime(2026, 11, 2), category: _transporte),
      _expense('2', 'Nafta YPF', 8000, DateTime(2026, 11, 20), category: _transporte, paidBy: _beto),
      _expense('3', 'Supermercado', 40000, DateTime(2026, 11, 10), category: _super),
      _expense('4', 'Nafta', 5000, DateTime(2026, 10, 30), category: _transporte),
    ];

    AssistantActions actions() => AssistantActions(
          expenses: _FakeExpenses(history),
          food: _FakeFood(),
          householdId: 'h1',
          categories: const [_transporte, _super],
          now: () => _now,
        );

    test('"7.000 de nafta" is 7000 and lands in the category they always use', () async {
      final out = await actions().run(
        const AssistantRequest(RequestAction.anotarGasto, description: 'nafta', amount: '7.000', date: 'hoy'),
        'gasté 7.000 de nafta',
      );
      final draft = (out.single as CardOut).card as ExpenseDraftCard;
      expect(draft.amount, 7000);
      expect(draft.description, 'Nafta');
      expect(draft.categoryName, 'Transporte');
      expect(draft.date, DateTime(2026, 11, 26));
      expect(draft.status, DraftStatus.pending);
    });

    test('an amount the model missed is read from the message', () async {
      final out = await actions().run(
        const AssistantRequest(RequestAction.anotarGasto, description: 'super'),
        'ayer 15 lucas en el super',
      );
      final draft = (out.single as CardOut).card as ExpenseDraftCard;
      expect(draft.amount, 15000);
      expect(draft.date, DateTime(2026, 11, 25));
    });

    test('"cuánto gastamos de nafta este mes" adds up only this month', () async {
      final out = await actions().run(
        const AssistantRequest(RequestAction.consultarGastos, search: 'nafta', month: 'este mes'),
        'cuanto gastamos de nafta este mes?',
      );
      final card = (out.single as CardOut).card as SpendingCard;
      expect(card.total, 14500);
      expect(card.count, 2);
      expect(card.rows.first.description, 'Nafta YPF');
    });

    test('the month summary adds up by category and by who paid', () async {
      final out = await actions().run(const AssistantRequest(RequestAction.resumenMes), 'cuánto gastamos este mes');
      final card = (out.single as CardOut).card as MonthSummaryCard;
      expect(card.total, 54500);
      expect(card.byCategory.first.name, 'Supermercado');
      expect(card.byMember.map((m) => m.name), ['Ana', 'Beto']);
    });

    test('"no, eran 8000" patches the waiting expense', () async {
      final out = await actions().run(
        const AssistantRequest(RequestAction.corregirGasto, amount: '8000', category: 'Supermercado'),
        'no, eran 8000',
      );
      final patch = out.single as DraftPatch;
      expect(patch.amount, 8000);
      expect(patch.category?.id, 'c-su');
    });

    test('small talk goes to the model', () async {
      final out = await actions().run(const AssistantRequest(RequestAction.charlar), 'hola');
      expect(out.single, isA<ChatOut>());
    });
  });

  group('week planner', () {
    RecipeSummary r(String slug) => RecipeSummary(slug: slug, title: slug);

    test('takes the model pick, skips refused ones, and leftovers for lunch', () async {
      final food = _FakeFood(
        options: {
          'almuerzo': [r('tarta'), r('ensalada')],
          'cena': [r('dal'), r('guiso')],
        },
        refused: {'dal'},
      );
      final planner = WeekPlanner(food, 'h1', pick: ({required day, required meal, required options, required notes}) async {
        return meal == 'cena' ? 'dal' : 'ensalada';
      });
      await planner.plan(WeekPlanRequest(
        days: [DateTime(2026, 11, 23), DateTime(2026, 11, 24)],
        meals: const ['almuerzo', 'cena'],
        leftovers: true,
      ));
      final byKey = {for (final e in food.entries) '${e.date} ${e.meal}': e};
      expect(byKey['2026-11-23 almuerzo']!.recipe!.slug, 'ensalada');
      // "dal" breaks a rule: the next option is used
      expect(byKey['2026-11-23 cena']!.recipe!.slug, 'guiso');
      // Monday's dinner becomes Tuesday's lunch
      expect(byKey['2026-11-24 almuerzo']!.leftoverOfId, byKey['2026-11-23 cena']!.id);
    });

    test('without the model it takes the best ranked option', () async {
      final food = _FakeFood(options: {'cena': [r('dal'), r('guiso')]});
      await WeekPlanner(food, 'h1').plan(WeekPlanRequest(days: [DateTime(2026, 11, 23)], meals: const ['cena']));
      expect(food.entries.single.recipe!.slug, 'dal');
    });
  });

  group('reply suggestion', () {
    final now = DateTime(2026, 11, 27);
    ExpenseDraftCard draft(DraftStatus status, DateTime date) =>
        ExpenseDraftCard(description: 'Nafta', amount: 7000, date: date, status: status);

    test('one suggestion that follows the last card', () {
      expect(replySuggestion([draft(DraftStatus.saved, now)], now), '¿Cuánto gastamos este mes?');
      expect(replySuggestion([draft(DraftStatus.saved, DateTime(2026, 10, 30))], now),
          '¿Cuánto gastamos el mes pasado?');
      expect(replySuggestion([const MenuCard(weekStart: '2026-11-30', slots: [])], now), 'Pasame la lista de compras');
      expect(replySuggestion([const RecipesCard(title: 'Con pollo', recipes: [])], now), 'Una receta rápida para hoy');
    });

    test('nothing while a card waits or after small talk', () {
      expect(replySuggestion([draft(DraftStatus.pending, now)], now), isNull);
      expect(replySuggestion([const UserMessage('hola'), const AssistantText('¡Hola!')], now), isNull);
      expect(replySuggestion(const [], now), isNull);
    });

    test('never repeats what the user just asked', () {
      expect(
        replySuggestion([const UserMessage('Pasame la lista de compras'), const MenuCard(weekStart: '2026-11-30', slots: [])], now),
        isNull,
      );
    });
  });
}
