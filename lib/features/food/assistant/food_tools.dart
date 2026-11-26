import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/assistant/data/assistant_tools.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';

const _date = {
  'type': 'string',
  'description': 'Fecha YYYY-MM-DD, por ejemplo 2026-11-26.',
};
const _meal = {
  'type': 'string',
  'enum': ['desayuno', 'almuerzo', 'merienda', 'cena'],
};

/// Food tools for the on-device model (at most 3 arguments each).
const foodToolSpecs = [
  AssistantToolSpec(
    name: 'buscar_recetas',
    description: 'Busca recetas ya filtradas por los gustos, alergias y dietas del hogar. '
        'Devuelve pocas recetas resumidas con su id.',
    parameters: {
      'type': 'object',
      'properties': {
        'consulta': {'type': 'string', 'description': 'Palabras: plato, ingredientes, tipo de comida.'},
        'pais': {'type': 'string', 'description': 'País o cocina, ej: peruana, italiana (opcional).'},
        'ingrediente': {'type': 'string', 'description': 'Ingrediente que tiene que tener (opcional).'},
      },
    },
  ),
  AssistantToolSpec(
    name: 'ver_receta',
    description: 'Ingredientes con cantidades y pasos de una receta, para cierta cantidad de porciones.',
    parameters: {
      'type': 'object',
      'properties': {
        'receta': {'type': 'string', 'description': 'id de la receta (de buscar_recetas u opciones_menu).'},
        'porciones': {'type': 'integer', 'description': 'Para cuántas personas (opcional).'},
      },
      'required': ['receta'],
    },
  ),
  AssistantToolSpec(
    name: 'opciones_menu',
    description: 'Recetas que encajan en una comida del menú (ya respetan gustos, tiempos y '
        'no repiten la semana). Elegí una de estas para poner_en_menu.',
    parameters: {
      'type': 'object',
      'properties': {'fecha': _date, 'comida': _meal},
      'required': ['fecha', 'comida'],
    },
  ),
  AssistantToolSpec(
    name: 'poner_en_menu',
    description: 'Pone una receta (id) o un texto libre (ej: "comemos afuera", "sobras") en una comida del menú.',
    parameters: {
      'type': 'object',
      'properties': {
        'fecha': _date,
        'comida': _meal,
        'receta': {'type': 'string', 'description': 'id de receta, o texto libre.'},
      },
      'required': ['fecha', 'comida', 'receta'],
    },
  ),
  AssistantToolSpec(
    name: 'ver_menu',
    description: 'El menú de la semana que contiene la fecha (por defecto, esta semana).',
    parameters: {
      'type': 'object',
      'properties': {'fecha': _date},
    },
  ),
  AssistantToolSpec(
    name: 'guardar_preferencia',
    description: 'Guarda algo que no les gusta, les encanta o les da alergia. Se aplica a todas las recetas.',
    parameters: {
      'type': 'object',
      'properties': {
        'tipo': {
          'type': 'string',
          'enum': ['no_gusta', 'alergia', 'encanta'],
        },
        'ingrediente': {'type': 'string'},
        'persona': {'type': 'string', 'description': 'Nombre de quién (opcional).'},
      },
      'required': ['tipo', 'ingrediente'],
    },
  ),
  AssistantToolSpec(
    name: 'mostrar_formulario',
    description: 'Muestra un formulario para que el usuario complete datos con botones en vez de escribir.',
    parameters: {
      'type': 'object',
      'properties': {
        'formulario': {
          'type': 'string',
          'enum': [
            'perfil', 'armar_semana', 'guardar_preferencia', 'heladera', 'aclarar_pedido',
            'invitados', 'nueva_receta', 'repasar_preferencias', 'de_estacion',
          ],
        },
        'dato': {'type': 'string', 'description': 'Opcional: ingrediente a precargar, o fecha YYYY-MM-DD de la semana.'},
      },
      'required': ['formulario'],
    },
  ),
];

final foodToolNames = {for (final t in foodToolSpecs) t.name};

/// Runs the food tools against the backend.
class FoodToolExecutor {
  final FoodRepository repo;
  final String householdId;
  final List<FormMember> members;
  final DateTime Function() now;

  /// Shown at most once per conversation, the first time food comes up
  /// and the household has not answered the first-time questions.
  bool _profileAsked;

  FoodToolExecutor(
    this.repo,
    this.householdId, {
    this.members = const [],
    DateTime Function()? now,
    bool profileAlreadyAsked = false,
  })  : now = now ?? DateTime.now,
        _profileAsked = profileAlreadyAsked;

  bool get profileAsked => _profileAsked;

  /// Servings used by poner_en_menu while planning a week (from the form).
  int? planningServings;

  Future<ToolOutcome> run(String name, Map<String, dynamic> args) async {
    try {
      final onboarding = await _maybeAskProfile(name);
      if (onboarding != null) return onboarding;
      return switch (name) {
        'buscar_recetas' => ToolOutcome(await _search(args)),
        'ver_receta' => ToolOutcome(await _recipe(args)),
        'opciones_menu' => ToolOutcome(await _options(args)),
        'poner_en_menu' => ToolOutcome(await _setMenu(args)),
        'ver_menu' => ToolOutcome(await _menu(args)),
        'guardar_preferencia' => await _savePreference(args),
        'mostrar_formulario' => await _showForm(args),
        _ => ToolOutcome({'error': 'Herramienta desconocida: $name'}),
      };
    } on AppException catch (e) {
      return ToolOutcome({'error': e.message});
    }
  }

  /// First food request of a household without a profile: show the
  /// profile form instead, once.
  Future<ToolOutcome?> _maybeAskProfile(String tool) async {
    if (_profileAsked || !const {'buscar_recetas', 'opciones_menu', 'ver_receta'}.contains(tool)) return null;
    final profile = await repo.profile(householdId);
    _profileAsked = true;
    if (profile.onboarded) return null;
    final prefs = await repo.preferences(householdId);
    return ToolOutcome(
      {
        'estado': 'falta_perfil',
        'nota': 'Es la primera vez que piden recetas: le mostré al usuario un formulario con dietas, '
            'alergias y gustos. Decile que lo complete y esperá su respuesta antes de recomendar.',
      },
      form: (id) => FoodForms.perfil(id, members: members, prefs: prefs),
    );
  }

  DateTime _day(Object? raw) => DateTime.tryParse('${raw ?? ''}') ?? now();

  Map<String, dynamic> _summary(RecipeSummary r) => {
        'id': r.slug,
        'titulo': r.title,
        'minutos': r.totalMinutes,
        if (r.countryName.isNotEmpty) 'pais': r.countryName,
        if (r.mainIngredients.isNotEmpty) 'ingredientes': r.mainIngredients.take(4).join(', '),
        if (r.omit.isNotEmpty) 'sacar': r.omit.join(', '),
        if (r.why.isNotEmpty) 'por_que': r.why.join('; '),
      };

  Future<Map<String, dynamic>> _search(Map<String, dynamic> args) async {
    final result = await repo.searchRecipes(
      householdId,
      query: '${args['consulta'] ?? ''}',
      country: args['pais'] as String?,
      ingredient: args['ingrediente'] as String?,
      limit: 5,
    );
    return {
      'recetas': [for (final r in result.recipes) _summary(r)],
      if (result.excluded > 0) 'descartadas_por_preferencias': result.excluded,
      if (result.recipes.isEmpty) 'nota': 'No hay recetas así. Ofrecé buscar otra cosa o anotar una receta propia.',
    };
  }

  Future<Map<String, dynamic>> _recipe(Map<String, dynamic> args) async {
    final servings = args['porciones'] is num ? (args['porciones'] as num).round() : null;
    final r = await repo.recipe(householdId, '${args['receta']}', servings: servings);
    return {
      'titulo': r.title,
      'porciones': r.servings,
      'minutos': r.totalMinutes,
      'ingredientes': [
        for (final l in r.ingredients)
          '${l.display} ${l.name}${l.optional ? ' (opcional)' : ''}${l.omit ? ' — NO usar (no les gusta)' : ''}',
      ],
      'pasos': [for (final s in r.steps) s.text],
      if (r.warnings.isNotEmpty) 'advertencias': r.warnings,
    };
  }

  Future<Map<String, dynamic>> _options(Map<String, dynamic> args) async {
    final day = _day(args['fecha']);
    final meal = '${args['comida']}';
    final options = await repo.candidates(householdId, day, meal, limit: 4);
    return {
      'fecha': isoDate(day),
      'comida': meal,
      'opciones': [for (final r in options) _summary(r)],
      if (options.isEmpty) 'nota': 'No hay recetas que encajen: proponé texto libre o preguntá.',
    };
  }

  Future<Map<String, dynamic>> _setMenu(Map<String, dynamic> args) async {
    final day = _day(args['fecha']);
    final meal = '${args['comida']}';
    final value = '${args['receta'] ?? ''}'.trim();
    if (value.toLowerCase().startsWith('sobras')) return _leftovers(day, meal);
    final isSlug = RegExp(r'^[a-z0-9]+(-[a-z0-9]+)*$').hasMatch(value);
    try {
      final entry = await repo.setEntry(householdId, day, meal,
          recipeSlug: isSlug ? value : null,
          freeText: isSlug ? null : value,
          servings: isSlug ? planningServings : null);
      return {'ok': true, 'fecha': isoDate(day), 'comida': meal, 'quedo': entry.title};
    } on NotFoundException {
      // "pizza" looks like an id but is not a recipe: keep it as free text
      final entry = await repo.setEntry(householdId, day, meal, freeText: value);
      return {'ok': true, 'fecha': isoDate(day), 'comida': meal, 'quedo': entry.title, 'nota': 'Guardado como texto libre.'};
    } on ServerException catch (e) {
      // 409: breaks a household rule
      return {'error': e.message, 'nota': 'Elegí otra opción de opciones_menu.'};
    }
  }

  /// "sobras": the last earlier meal of the week that has a recipe.
  Future<Map<String, dynamic>> _leftovers(DateTime day, String meal) async {
    const order = ['desayuno', 'almuerzo', 'merienda', 'cena'];
    final week = await repo.week(householdId, day);
    final target = '${isoDate(day)}#${order.indexOf(meal)}';
    final earlier = week.entries
        .where((e) => e.recipe != null && !e.isLeftovers)
        .where((e) => '${e.date}#${order.indexOf(e.meal)}'.compareTo(target) < 0)
        .toList()
      ..sort((a, b) => '${b.date}#${order.indexOf(b.meal)}'.compareTo('${a.date}#${order.indexOf(a.meal)}'));
    if (earlier.isEmpty) {
      return {'error': 'No hay una comida anterior esta semana para usar de sobras.'};
    }
    final entry = await repo.setEntry(householdId, day, meal, leftoverOf: earlier.first.id);
    return {'ok': true, 'fecha': isoDate(day), 'comida': meal, 'quedo': entry.title};
  }

  Future<Map<String, dynamic>> _menu(Map<String, dynamic> args) async {
    final week = await repo.week(householdId, _day(args['fecha']));
    return {
      'semana': week.weekStart,
      'comidas': [
        for (final e in week.entries)
          {'fecha': e.date, 'comida': e.meal, 'plato': e.title, if (e.recipe != null) 'id': e.recipe!.slug},
      ],
      if (week.entries.isEmpty) 'nota': 'La semana está vacía.',
    };
  }

  Future<ToolOutcome> _savePreference(Map<String, dynamic> args) async {
    const kinds = {'no_gusta': 'dislike', 'alergia': 'allergy', 'encanta': 'like'};
    final kind = kinds['${args['tipo']}'] ?? 'dislike';
    final ingredient = '${args['ingrediente'] ?? ''}'.trim();
    final person = '${args['persona'] ?? ''}'.trim().toLowerCase();
    final member = members.where((m) => m.name.toLowerCase().startsWith(person) && person.isNotEmpty).firstOrNull;
    try {
      final pref = await repo.savePreference(householdId, kind: kind, ingredient: ingredient, memberUserId: member?.id);
      return ToolOutcome({'ok': true, 'guardado': '${args['tipo']}: ${pref.label}${member != null ? ' (${member.name})' : ''}'});
    } on ValidationException {
      // Not in the catalog: let the user confirm or correct it with the form
      return ToolOutcome(
        {
          'ok': false,
          'nota': 'No reconocí "$ingredient". Le mostré un formulario para que lo corrija o confirme.',
        },
        form: (id) => FoodForms.confirmarPreferencia(id, members: members, ingredient: ingredient, kind: kind),
      );
    }
  }

  Future<ToolOutcome> _showForm(Map<String, dynamic> args) async {
    final dato = '${args['dato'] ?? ''}'.trim();
    List<Map<String, Object?>> Function(String)? form;
    switch ('${args['formulario']}') {
      case 'perfil':
        final profile = await repo.profile(householdId);
        final prefs = await repo.preferences(householdId);
        form = (id) => FoodForms.perfil(id, members: members, profile: profile, prefs: prefs);
      case 'armar_semana':
        final profile = await repo.profile(householdId);
        final day = DateTime.tryParse(dato) ?? now();
        final monday = DateTime(day.year, day.month, day.day).subtract(Duration(days: day.weekday - 1));
        form = (id) => FoodForms.armarSemana(id, weekStart: monday, profile: profile);
      case 'guardar_preferencia':
        form = (id) => FoodForms.confirmarPreferencia(id, members: members, ingredient: dato);
      case 'heladera':
        form = FoodForms.heladera;
      case 'aclarar_pedido':
        final profile = await repo.profile(householdId);
        form = (id) => FoodForms.aclararPedido(id, servings: profile.servings);
      case 'invitados':
        form = FoodForms.invitados;
      case 'nueva_receta':
        form = (id) => FoodForms.nuevaReceta(id, title: dato);
      case 'repasar_preferencias':
        final profile = await repo.profile(householdId);
        final prefs = await repo.preferences(householdId);
        form = (id) => FoodForms.repasarPreferencias(id, prefs: prefs, profile: profile);
      case 'de_estacion':
        final produce = await repo.seasonIngredients(householdId);
        form = (id) => FoodForms.deEstacion(id, ingredients: produce);
      default:
        return ToolOutcome({'error': 'Formulario desconocido: ${args['formulario']}'});
    }
    return ToolOutcome(
      {'mostrado': true, 'nota': 'El usuario lo está completando: esperá su respuesta.'},
      form: form,
    );
  }
}
