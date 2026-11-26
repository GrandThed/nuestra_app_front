import 'package:a2ui_core/a2ui_core.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';

/// What happened after a form was sent.
class FormOutcome {
  /// Short Spanish summary, shown to the user and passed to the assistant so
  /// the conversation can continue ("Guardé: sin TACC, sin remolacha").
  final String summary;

  /// A recipe to open (with servings), e.g. after "Ver receta".
  final ({String slug, int? servings})? openRecipe;

  /// Another form to show next (e.g. recipe choices after "¿qué hay en la heladera?").
  final List<Map<String, Object?>> Function(String surfaceId)? next;

  /// What changed, so screens can reload.
  final Set<FoodData> changed;

  /// False when the user just cancelled.
  final bool done;

  const FormOutcome(
    this.summary, {
    this.openRecipe,
    this.next,
    this.changed = const {},
    this.done = true,
  });
}

enum FoodData { preferences, profile, menu, recipes }

// ---------- Parsing helpers (pure) ----------

/// "remolacha, hongos y coliflor" -> [remolacha, hongos, coliflor].
List<String> splitNames(String text) => text
    .split(RegExp(r'[,;\n]|\s+y\s+|\s+e\s+'))
    .map((s) => s.trim())
    .where((s) => s.isNotEmpty)
    .toList();

const _unitWords = r'(kg|kgs|kilos?|kilogramos?|g|gr|grs|gramos?|ml|cc|mililitros?|l|lts?|litros?|cdas?|cucharadas?|cditas?|cdtas?|cucharaditas?|tazas?|dientes?|pizcas?|unidades|unidad|u)';

/// "200 g de azúcar" -> {quantity: 200, unit: g, name: azúcar};
/// "4 huevos" -> {quantity: 4, unit: '', name: huevos};
/// "sal a gusto" -> {quantity: null, unit: a gusto, name: sal}.
Map<String, Object?> parseIngredientLine(String line) {
  var text = line.trim().replaceFirst(RegExp(r'^[-•*·]\s*'), '');
  String unit = '';
  if (RegExp(r'\b(a gusto|c/n|cantidad necesaria)\s*$', caseSensitive: false).hasMatch(text)) {
    text = text.replaceFirst(RegExp(r'\s*\b(a gusto|c/n|cantidad necesaria)\s*$', caseSensitive: false), '');
    return {'name': text.trim(), 'quantity': null, 'unit': 'a gusto'};
  }
  final m = RegExp(
    '^((?:\\d+\\s+)?\\d+/\\d+|\\d+(?:[.,]\\d+)?\\s*[¼½¾]?|[¼½¾])\\s*(?:$_unitWords\\b\\.?)?\\s*(?:de\\s+)?(.*)\$',
    caseSensitive: false,
  ).firstMatch(text);
  if (m == null) return {'name': text, 'quantity': null, 'unit': 'a gusto'};
  unit = m.group(2) ?? '';
  return {'name': (m.group(3) ?? '').trim(), 'quantity': m.group(1)!.trim(), 'unit': unit};
}

/// Lines of a multi-line text field, without blanks.
List<String> lines(String text) =>
    text.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();

// ---------- Handler ----------

/// Runs what a food form asks for: saves preferences, profile and menu
/// changes through the API and returns a summary.
class FoodFormHandler {
  final FoodRepository repo;
  final String householdId;
  final List<FormMember> members;

  FoodFormHandler(this.repo, this.householdId, {this.members = const []});

  static bool handles(String actionName) => actionName.startsWith(FoodFormAction.prefix);

  Future<FormOutcome> handle(A2uiRendererAction action) async {
    final c = action.context;
    try {
      return switch (action.name) {
        FoodFormAction.perfil => await _perfil(c),
        FoodFormAction.armarSemana => _armarSemana(c),
        FoodFormAction.preferencia => await _preferencia(c),
        FoodFormAction.heladera => await _heladera(c),
        FoodFormAction.aclarar => _aclarar(c),
        FoodFormAction.verReceta => _verReceta(c),
        FoodFormAction.agregarMenu => await _agregarMenu(c),
        FoodFormAction.cambiarComida => await _cambiarComida(c),
        FoodFormAction.comensales => _comensales(c),
        FoodFormAction.valorar => await _valorar(c),
        FoodFormAction.invitados => _invitados(c),
        FoodFormAction.nuevaReceta => await _nuevaReceta(c),
        FoodFormAction.borrarPreferencias => await _borrarPreferencias(c),
        FoodFormAction.confirmar => await _confirmar(c),
        FoodFormAction.deEstacion => await _deEstacion(c),
        FoodFormAction.cancelar => const FormOutcome('El usuario canceló.', done: false),
        _ => FormOutcome('No sé manejar "${action.name}".', done: false),
      };
    } on AppException catch (e) {
      return FormOutcome('No se pudo guardar: ${e.message}', done: false);
    }
  }

  // --- value readers ---
  static List<String> _list(Map c, String k) =>
      (c[k] as List<dynamic>? ?? const []).map((e) => '$e').where((e) => e.isNotEmpty).toList();
  static String _str(Map c, String k) => '${c[k] ?? ''}'.trim();
  static int? _int(Map c, String k) {
    final v = c[k];
    if (v is num) return v.round();
    if (v is List && v.isNotEmpty) return int.tryParse('${v.first}');
    return int.tryParse('${v ?? ''}'.trim());
  }

  static String? _first(Map c, String k) {
    final l = _list(c, k);
    return l.isEmpty ? null : l.first;
  }

  String? _memberId(String? value) => value == null || value == 'todos' ? null : value;
  String _memberName(String? id) => members.where((m) => m.id == id).firstOrNull?.name ?? '';

  static DateTime? _date(String iso) => DateTime.tryParse(iso);

  // --- forms ---

  Future<FormOutcome> _perfil(Map c) async {
    final current = await repo.preferences(householdId);
    final saved = <String>[];
    final unknown = <String>[];

    // Diets and allergies: the form shows the current ones, so unticked ones are removed
    final diets = _list(c, 'dietas').toSet();
    final allergens = _list(c, 'alergias').toSet();
    final member = _memberId(_first(c, 'quien'));
    for (final p in current) {
      if ((p.kind == 'diet' && !diets.contains(p.dietTag)) ||
          (p.kind == 'allergy' && p.allergen != null && !allergens.contains(p.allergen))) {
        await repo.deletePreference(p.id);
      }
    }
    for (final d in diets) {
      if (current.any((p) => p.kind == 'diet' && p.dietTag == d)) continue;
      await repo.savePreference(householdId, kind: 'diet', dietTag: d);
      saved.add(dietLabels[d] ?? d);
    }
    for (final a in allergens) {
      await repo.savePreference(householdId, kind: 'allergy', allergen: a, memberUserId: member);
      saved.add('alergia a ${allergenLabels[a]?.toLowerCase() ?? a}${member != null ? ' (${_memberName(member)})' : ''}');
    }

    // Dislikes: also prefilled, so names removed from the text are deleted
    final dislikes = splitNames(_str(c, 'no_gusta'));
    final wanted = dislikes.map((d) => d.toLowerCase()).toSet();
    for (final p in current.where((p) => p.kind == 'dislike' && p.ingredientName != null)) {
      if (!wanted.contains(p.ingredientName!.toLowerCase())) await repo.deletePreference(p.id);
    }
    for (final name in dislikes) {
      if (current.any((p) => p.kind == 'dislike' && p.ingredientName?.toLowerCase() == name.toLowerCase())) continue;
      if (await _trySave('dislike', name)) {
        saved.add('no les gusta $name');
      } else {
        unknown.add(name);
      }
    }
    for (final name in splitNames(_str(c, 'gusta'))) {
      if (await _trySave('like', name)) {
        saved.add('les encanta $name');
      } else {
        unknown.add(name);
      }
    }

    final time = _first(c, 'tiempo_semana');
    final profile = await repo.updateProfile(householdId, {
      if (_int(c, 'porciones') != null) 'servings': _int(c, 'porciones'),
      'weekdayMaxMinutes': time == null || time == 'sin_limite' ? null : int.tryParse(time),
      if (_first(c, 'nivel') != null) 'skill': int.parse(_first(c, 'nivel')!),
      if (_list(c, 'comidas').isNotEmpty) 'meals': _list(c, 'comidas'),
      'cuisines': _list(c, 'cocinas'),
      'onboarded': true,
    });

    final parts = [
      if (saved.isNotEmpty) saved.join('; '),
      'cocinan para ${profile.servings}',
      profile.weekdayMaxMinutes == null
          ? 'sin límite de tiempo entre semana'
          : 'hasta ${profile.weekdayMaxMinutes} min entre semana',
      if (unknown.isNotEmpty) 'no reconocí: ${unknown.join(', ')}',
    ];
    return FormOutcome('Perfil de comida guardado: ${parts.join('; ')}.',
        changed: const {FoodData.preferences, FoodData.profile});
  }

  /// Save a preference by ingredient name; false when the name is unknown.
  Future<bool> _trySave(String kind, String name, {String? member}) async {
    try {
      await repo.savePreference(householdId, kind: kind, ingredient: name, memberUserId: member);
      return true;
    } on ServerException {
      return false;
    }
  }

  FormOutcome _armarSemana(Map c) {
    final days = _list(c, 'dias')..sort();
    final notes = _str(c, 'notas');
    return FormOutcome(
      'Armar el menú de la semana del ${_str(c, 'semana')}: '
      'días ${days.join(', ')}; comidas ${_list(c, 'comidas').join(', ')}; '
      '${_int(c, 'porciones') ?? 2} porciones; '
      '${c['sobras'] == true ? 'usar sobras al día siguiente' : 'sin sobras'}; '
      '${c['repetir'] == true ? 'incluir platos que les gustaron' : 'platos nuevos'}'
      '${notes.isEmpty ? '' : '; notas: $notes'}.',
    );
  }

  Future<FormOutcome> _preferencia(Map c) async {
    final name = _str(c, 'ingrediente');
    final kind = _first(c, 'tipo') ?? 'dislike';
    final member = _memberId(_first(c, 'quien'));
    if (!await _trySave(kind, name, member: member)) {
      return FormOutcome('No conozco "$name" en el catálogo de ingredientes todavía, no lo pude guardar.', done: false);
    }
    const verbs = {'dislike': 'no les gusta', 'allergy': 'da alergia', 'like': 'les encanta'};
    return FormOutcome(
      'Guardado: ${verbs[kind]} $name${member != null ? ' (${_memberName(member)})' : ''}. Se aplica a todas las recetas.',
      changed: const {FoodData.preferences},
    );
  }

  Future<FormOutcome> _search(String what, {String? meal, String? time, String? query, String? ingredient}) async {
    final result = await repo.searchRecipes(
      householdId,
      query: query,
      ingredient: ingredient,
      mealType: meal,
      maxMinutes: time == null || time == 'sin_limite' ? null : int.tryParse(time),
      limit: 5,
    );
    if (result.recipes.isEmpty) {
      return FormOutcome('No encontré recetas $what que respeten sus gustos'
          '${result.excluded > 0 ? ' (descarté ${result.excluded} por sus preferencias)' : ''}.');
    }
    return FormOutcome(
      'Encontré ${result.recipes.length} recetas $what: ${result.recipes.map((r) => r.title).join(', ')}.',
      next: (id) => FoodForms.elegirReceta(id, recipes: result.recipes),
    );
  }

  Future<FormOutcome> _heladera(Map c) {
    final names = splitNames(_str(c, 'ingredientes'));
    return _search('con ${names.join(', ')}',
        query: names.join(' '), meal: _first(c, 'comida'), time: _first(c, 'tiempo'));
  }

  FormOutcome _aclarar(Map c) {
    final cuisine = _first(c, 'cocina');
    return FormOutcome(
      'Quiere: ${_first(c, 'comida') ?? 'cualquier comida'}; '
      '${_first(c, 'tiempo') == 'sin_limite' ? 'sin apuro' : 'hasta ${_first(c, 'tiempo')} min'}; '
      '${cuisine == null || cuisine == 'cualquiera' ? 'cualquier cocina' : 'cocina $cuisine'}; '
      'para ${_int(c, 'personas') ?? 2} personas.',
    );
  }

  FormOutcome _verReceta(Map c) {
    final slug = _first(c, 'receta');
    if (slug == null) return const FormOutcome('No eligió ninguna receta.', done: false);
    return FormOutcome('Abrió la receta $slug.', openRecipe: (slug: slug, servings: null));
  }

  Future<FormOutcome> _setSlot(DateTime day, String meal, {String? slug, String? text}) async {
    try {
      final entry = await repo.setEntry(householdId, day, meal, recipeSlug: slug, freeText: text);
      return FormOutcome('Menú: ${mealLabels[meal]?.toLowerCase() ?? meal} del ${isoDate(day)} → ${entry.title}.',
          changed: const {FoodData.menu});
    } on ServerException catch (e) {
      return FormOutcome('No la agregué: ${e.message}', done: false);
    }
  }

  Future<FormOutcome> _agregarMenu(Map c) async {
    final day = _date(_str(c, 'fecha'));
    final slug = _first(c, 'receta');
    if (day == null || slug == null) return const FormOutcome('Faltan datos para agregar al menú.', done: false);
    return _setSlot(day, _str(c, 'comida'), slug: slug);
  }

  Future<FormOutcome> _cambiarComida(Map c) async {
    final day = _date(_str(c, 'fecha'));
    if (day == null) return const FormOutcome('Falta la fecha.', done: false);
    final text = _str(c, 'texto');
    final slug = _first(c, 'receta');
    if (text.isEmpty && slug == null) return const FormOutcome('No eligió nada.', done: false);
    return _setSlot(day, _str(c, 'comida'), slug: text.isEmpty ? slug : null, text: text.isEmpty ? null : text);
  }

  FormOutcome _comensales(Map c) {
    final people = _int(c, 'personas') ?? 2;
    return FormOutcome('Receta para $people personas.',
        openRecipe: (slug: _str(c, 'receta'), servings: people));
  }

  Future<FormOutcome> _valorar(Map c) async {
    final rating = int.tryParse(_first(c, 'puntaje') ?? '') ?? 2;
    final note = _str(c, 'nota');
    await repo.updateEntry(_str(c, 'entrada'), {'rating': rating, if (note.isNotEmpty) 'note': note});
    const labels = {1: 'no repetir', 2: 'estuvo bien', 3: 'para repetir'};
    return FormOutcome('Anotado: ${labels[rating]}${note.isEmpty ? '' : ' ($note)'}.', changed: const {FoodData.menu});
  }

  FormOutcome _invitados(Map c) {
    final diets = _list(c, 'dietas').map((d) => dietLabels[d] ?? d);
    final allergies = _list(c, 'alergias').map((a) => allergenLabels[a] ?? a);
    final notes = _str(c, 'notas');
    return FormOutcome(
      'Solo para esta comida: ${_int(c, 'cantidad') ?? 2} invitados'
      '${diets.isEmpty ? '' : '; dietas: ${diets.join(', ')}'}'
      '${allergies.isEmpty ? '' : '; alergias: ${allergies.join(', ')}'}'
      '${notes.isEmpty ? '' : '; $notes'}. No cambia las preferencias de la casa.',
    );
  }

  Future<FormOutcome> _nuevaReceta(Map c) async {
    final ingredients = lines(_str(c, 'ingredientes')).map(parseIngredientLine).toList();
    final steps = lines(_str(c, 'pasos'));
    if (ingredients.isEmpty || steps.isEmpty) {
      return const FormOutcome('Faltan ingredientes o pasos.', done: false);
    }
    final created = await repo.createRecipe(householdId, {
      'title': _str(c, 'titulo'),
      'servings': _int(c, 'porciones') ?? 4,
      'prepMinutes': _int(c, 'preparacion') ?? 0,
      'cookMinutes': _int(c, 'coccion') ?? 0,
      'mealTypes': _list(c, 'comidas'),
      'ingredients': ingredients,
      'steps': steps,
      'origin': _str(c, 'origen') == 'photo' ? 'photo' : 'manual',
    });
    return FormOutcome(
      'Receta "${_str(c, 'titulo')}" guardada'
      '${created.unmatched.isEmpty ? '' : '. No reconocí estos ingredientes (quedan como texto): ${created.unmatched.join(', ')}'}.',
      openRecipe: (slug: created.slug, servings: null),
      changed: const {FoodData.recipes},
    );
  }

  Future<FormOutcome> _borrarPreferencias(Map c) async {
    final ids = _list(c, 'borrar');
    for (final id in ids) {
      await repo.deletePreference(id);
    }
    return FormOutcome('Borré ${ids.length} preferencia${ids.length == 1 ? '' : 's'}.',
        changed: const {FoodData.preferences});
  }

  Future<FormOutcome> _confirmar(Map c) async {
    switch (_str(c, 'accion')) {
      case 'vaciar_semana':
      case 'rehacer_semana':
        final day = _date(_str(c, 'fecha')) ?? DateTime.now();
        await repo.clearWeek(householdId, day);
        return FormOutcome(
          _str(c, 'accion') == 'rehacer_semana'
              ? 'Vacié el menú de la semana del ${isoDate(day)}; hay que armarlo de nuevo.'
              : 'Vacié el menú de la semana del ${isoDate(day)}.',
          changed: const {FoodData.menu},
        );
      case 'borrar_receta':
        await repo.deleteRecipe(householdId, _str(c, 'receta'));
        return const FormOutcome('Receta borrada.', changed: {FoodData.recipes});
      default:
        return const FormOutcome('Acción desconocida.', done: false);
    }
  }

  Future<FormOutcome> _deEstacion(Map c) {
    final names = _list(c, 'ingredientes');
    return _search('de estación con ${names.join(', ')}', query: names.join(' '));
  }
}
