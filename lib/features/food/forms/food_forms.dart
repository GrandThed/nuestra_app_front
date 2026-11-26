import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/forms/a2ui_form_builder.dart';

/// A household member, for "¿de quién es?" questions.
typedef FormMember = ({String id, String name});

/// Action names sent by the food forms; [FoodFormHandler] handles each one.
abstract final class FoodFormAction {
  static const prefix = 'form.';
  static const perfil = 'form.perfil';
  static const armarSemana = 'form.armar_semana';
  static const preferencia = 'form.preferencia';
  static const heladera = 'form.heladera';
  static const aclarar = 'form.aclarar';
  static const verReceta = 'form.ver_receta';
  static const agregarMenu = 'form.agregar_menu';
  static const cambiarComida = 'form.cambiar_comida';
  static const comensales = 'form.comensales';
  static const valorar = 'form.valorar';
  static const invitados = 'form.invitados';
  static const nuevaReceta = 'form.nueva_receta';
  static const borrarPreferencias = 'form.borrar_preferencias';
  static const confirmar = 'form.confirmar';
  static const deEstacion = 'form.de_estacion';
  static const cancelar = 'form.cancelar';
}

/// The forms the assistant can show (by [FoodFormKind] name) and the
/// Comida screens reuse.
enum FoodFormKind {
  perfil('Perfil de comida', 'Primera vez que piden una receta o un menú: dietas, alergias, gustos y tiempos.'),
  armarSemana('Armar la semana', 'Antes de planear el menú semanal: días, comidas, porciones, sobras.'),
  confirmarPreferencia('Guardar un gusto o alergia', 'Cuando el usuario dice que algo no le gusta, le encanta o le da alergia.'),
  heladera('¿Qué hay en la heladera?', 'Para cocinar con lo que tienen.'),
  aclararPedido('Aclarar el pedido', 'Cuando el pedido de receta es muy vago.'),
  invitados('Invitados', 'Cuando vienen invitados con restricciones (no se guarda).'),
  nuevaReceta('Nueva receta propia', 'Para anotar una receta de la casa.'),
  repasarPreferencias('Repasar preferencias', 'Cuando preguntan qué saben de sus gustos o quieren borrar algo.'),
  deEstacion('Productos de estación', 'Para elegir verduras y frutas de estación.');

  final String title;
  final String whenToUse;
  const FoodFormKind(this.title, this.whenToUse);
}

const _weekdayLabels = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

const _cuisines = {
  'AR': 'Argentina',
  'IT': 'Italiana',
  'ES': 'Española',
  'MX': 'Mexicana',
  'PE': 'Peruana',
  'IN': 'India',
  'CN': 'China',
  'JP': 'Japonesa',
  'FR': 'Francesa',
  'GR': 'Griega',
  'TH': 'Tailandesa',
  'LB': 'Libanesa',
};

const _commonAllergens = ['gluten', 'leche', 'huevo', 'mani', 'frutos_secos', 'pescado', 'crustaceos', 'soja', 'sesamo'];

const _plannedMeals = {'desayuno': 'Desayuno', 'almuerzo': 'Almuerzo', 'merienda': 'Merienda', 'cena': 'Cena'};

Map<String, String> _memberOptions(List<FormMember> members) => {
      'todos': 'Todos',
      for (final m in members) m.id: m.name,
    };

String _minutesValue(int? minutes) => minutes == null ? 'sin_limite' : '$minutes';

const _timeOptions = {
  '20': '20 min',
  '30': '30 min',
  '45': '45 min',
  '60': '1 hora',
  '90': '1 h 30',
  'sin_limite': 'Sin límite',
};

/// Builders for every food form. Each returns the A2UI messages for a new
/// surface with [surfaceId].
abstract final class FoodForms {
  /// 1. First-time profile: diets, allergies (and whose), dislikes, cooking.
  static List<Map<String, Object?>> perfil(
    String surfaceId, {
    required List<FormMember> members,
    FoodProfile profile = const FoodProfile(),
    List<FoodPreference> prefs = const [],
  }) {
    final diets = prefs.where((p) => p.kind == 'diet').map((p) => p.dietTag!).toList();
    final allergens = prefs.where((p) => p.kind == 'allergy' && p.allergen != null).map((p) => p.allergen!).toList();
    final dislikes = prefs.where((p) => p.kind == 'dislike' && p.ingredientName != null).map((p) => p.ingredientName!).join(', ');
    return (A2uiFormBuilder(surfaceId)
          ..title('Contanos cómo comen en casa')
          ..text('Con esto filtramos recetas y armamos menús. Lo pueden cambiar cuando quieran.', caption: true)
          ..choice('dietas', 'Dietas', dietLabels, multiple: true, initial: diets)
          ..choice('alergias', 'Alergias o intolerancias',
              {for (final a in _commonAllergens) a: allergenLabels[a]!},
              multiple: true, initial: allergens)
          ..choice('quien', '¿De quién son las alergias?', _memberOptions(members), initial: const ['todos'])
          ..field('no_gusta', 'No nos gusta', initial: dislikes, placeholder: 'Ej: remolacha, hongos, coliflor')
          ..field('gusta', 'Nos encanta', placeholder: 'Ej: berenjena, lentejas')
          ..divider()
          ..slider('porciones', '¿Para cuántas personas cocinan?', 1, 10, initial: profile.servings)
          ..choice('tiempo_semana', 'Tiempo para cocinar entre semana', _timeOptions,
              initial: [_minutesValue(profile.weekdayMaxMinutes)])
          ..choice('nivel', '¿Qué tan bien cocinan?', const {'1': 'Básico', '2': 'Intermedio', '3': 'Avanzado'},
              initial: ['${profile.skill}'])
          ..choice('comidas', '¿Qué comidas planean?', _plannedMeals, multiple: true, initial: profile.meals)
          ..choice('cocinas', 'Cocinas favoritas', _cuisines, multiple: true, initial: profile.cuisines)
          ..button('Guardar', FoodFormAction.perfil, fields: const [
            'dietas', 'alergias', 'quien', 'no_gusta', 'gusta', 'porciones', 'tiempo_semana', 'nivel', 'comidas', 'cocinas',
          ]))
        .build();
  }

  /// 2. Before planning the week: which days and meals, servings, leftovers.
  static List<Map<String, Object?>> armarSemana(
    String surfaceId, {
    required DateTime weekStart,
    FoodProfile profile = const FoodProfile(),
  }) {
    final days = {
      for (var i = 0; i < 7; i++)
        _iso(weekStart.add(Duration(days: i))): '${_weekdayLabels[i]} ${weekStart.add(Duration(days: i)).day}',
    };
    return (A2uiFormBuilder(surfaceId)
          ..title('Armemos la semana')
          ..choice('dias', '¿Qué días?', days, multiple: true, initial: days.keys.toList())
          ..choice('comidas', '¿Qué comidas?', _plannedMeals, multiple: true, initial: profile.meals)
          ..slider('porciones', 'Porciones por comida', 1, 10, initial: profile.servings)
          ..check('sobras', 'Cocinar de más y usar sobras al día siguiente', initial: true)
          ..check('repetir', 'Incluir platos que nos gustaron', initial: true)
          ..field('notas', 'Algo especial esta semana', placeholder: 'Ej: el viernes comemos afuera')
          ..button('Armar menú', FoodFormAction.armarSemana,
              fields: const ['dias', 'comidas', 'porciones', 'sobras', 'repetir', 'notas'],
              extra: {'semana': _iso(weekStart)},
              requiredField: 'dias',
              requiredMessage: 'Elegí al menos un día'))
        .build();
  }

  /// 3. Confirm something the user said ("no nos gusta la remolacha").
  static List<Map<String, Object?>> confirmarPreferencia(
    String surfaceId, {
    required List<FormMember> members,
    String ingredient = '',
    String kind = 'dislike',
  }) =>
      (A2uiFormBuilder(surfaceId)
            ..title('¿Lo guardo?')
            ..field('ingrediente', 'Ingrediente o comida', initial: ingredient)
            ..choice('tipo', 'Es algo que…', const {
              'dislike': 'No nos gusta',
              'allergy': 'Da alergia',
              'like': 'Nos encanta',
            }, initial: [kind])
            ..choice('quien', '¿De quién?', _memberOptions(members), initial: const ['todos'])
            ..buttonRow([
              (b) => b.button('No', FoodFormAction.cancelar, primary: false),
              (b) => b.button('Guardar', FoodFormAction.preferencia,
                  fields: const ['ingrediente', 'tipo', 'quien'], requiredField: 'ingrediente'),
            ]))
          .build();

  /// 4. Cook with what's at home.
  static List<Map<String, Object?>> heladera(String surfaceId) => (A2uiFormBuilder(surfaceId)
        ..title('¿Qué tenés para cocinar?')
        ..field('ingredientes', 'Ingredientes', multiline: true, placeholder: 'Ej: papas, huevos, cebolla')
        ..choice('comida', '¿Para qué comida?', _plannedMeals, initial: const ['cena'])
        ..choice('tiempo', 'Tiempo disponible', _timeOptions, initial: const ['45'])
        ..button('Buscar recetas', FoodFormAction.heladera,
            fields: const ['ingredientes', 'comida', 'tiempo'], requiredField: 'ingredientes'))
      .build();

  /// 5. A vague request ("algo rico").
  static List<Map<String, Object?>> aclararPedido(String surfaceId, {int servings = 2}) =>
      (A2uiFormBuilder(surfaceId)
            ..title('Contame un poco más')
            ..choice('comida', '¿Para qué comida?', {..._plannedMeals, 'postre': 'Postre', 'snack': 'Para picar'},
                initial: const ['cena'])
            ..choice('tiempo', '¿Cuánto tiempo tenés?', _timeOptions, initial: const ['45'])
            ..choice('cocina', '¿De dónde?', {'cualquiera': 'Cualquiera', ..._cuisines}, initial: const ['cualquiera'])
            ..slider('personas', '¿Para cuántos?', 1, 12, initial: servings)
            ..button('Listo', FoodFormAction.aclarar, fields: const ['comida', 'tiempo', 'cocina', 'personas']))
          .build();

  /// 6. Pick one of a few recipes; optionally add it to a menu slot.
  static List<Map<String, Object?>> elegirReceta(
    String surfaceId, {
    required List<RecipeSummary> recipes,
    String title = 'Estas te pueden servir',
    DateTime? day,
    String? meal,
  }) {
    final b = A2uiFormBuilder(surfaceId)
      ..title(title)
      ..choice('receta', 'Elegí una', {for (final r in recipes) r.slug: _recipeLabel(r)},
          initial: recipes.isEmpty ? const [] : [recipes.first.slug], chips: false);
    if (day != null && meal != null) {
      b.buttonRow([
        (b) => b.button('Ver receta', FoodFormAction.verReceta, fields: const ['receta'], primary: false),
        (b) => b.button('Agregar al menú', FoodFormAction.agregarMenu,
            fields: const ['receta'], extra: {'fecha': _iso(day), 'comida': meal}, requiredField: 'receta'),
      ]);
    } else {
      b.button('Ver receta', FoodFormAction.verReceta, fields: const ['receta'], requiredField: 'receta');
    }
    return b.build();
  }

  /// 7. Change one meal of the menu.
  static List<Map<String, Object?>> cambiarComida(
    String surfaceId, {
    required DateTime day,
    required String meal,
    required List<RecipeSummary> candidates,
  }) =>
      (A2uiFormBuilder(surfaceId)
            ..title('${_plannedMeals[meal] ?? meal} del ${_weekdayLabels[day.weekday - 1].toLowerCase()} ${day.day}')
            ..choice('receta', 'Opciones que respetan sus gustos',
                {for (final r in candidates) r.slug: _recipeLabel(r)}, chips: false)
            ..field('texto', 'O escribí otra cosa', placeholder: 'Ej: comemos afuera, sobras, pizza')
            ..button('Cambiar', FoodFormAction.cambiarComida,
                fields: const ['receta', 'texto'], extra: {'fecha': _iso(day), 'comida': meal}))
          .build();

  /// 8. How many people eat this time (scales the recipe).
  static List<Map<String, Object?>> comensales(String surfaceId, {required String slug, int servings = 2}) =>
      (A2uiFormBuilder(surfaceId)
            ..title('¿Para cuántos?')
            ..slider('personas', 'Personas', 1, 12, initial: servings)
            ..button('Ver cantidades', FoodFormAction.comensales, fields: const ['personas'], extra: {'receta': slug}))
          .build();

  /// 9. After cooking a menu meal.
  static List<Map<String, Object?>> valorar(String surfaceId, {required String entryId, required String title}) =>
      (A2uiFormBuilder(surfaceId)
            ..title('¿Qué tal estuvo $title?')
            ..choice('puntaje', '', const {'3': 'Para repetir', '2': 'Estuvo bien', '1': 'No repetir'},
                initial: const ['2'])
            ..field('nota', 'Algo para la próxima', placeholder: 'Ej: menos sal, más picante')
            ..button('Guardar', FoodFormAction.valorar, fields: const ['puntaje', 'nota'], extra: {'entrada': entryId}))
          .build();

  /// 10. Guests with restrictions, for one meal only (nothing is saved).
  static List<Map<String, Object?>> invitados(String surfaceId) => (A2uiFormBuilder(surfaceId)
        ..title('¿Quiénes vienen?')
        ..slider('cantidad', 'Invitados', 1, 20, initial: 2)
        ..choice('dietas', 'Dietas', dietLabels, multiple: true)
        ..choice('alergias', 'Alergias', {for (final a in _commonAllergens) a: allergenLabels[a]!}, multiple: true)
        ..field('notas', 'Algo más', placeholder: 'Ej: uno no come picante')
        ..text('Solo para esta comida: no cambia las preferencias de la casa.', caption: true)
        ..button('Buscar recetas', FoodFormAction.invitados, fields: const ['cantidad', 'dietas', 'alergias', 'notas']))
      .build();

  /// 11. A household recipe, typed or read from a photo (pre-filled).
  static List<Map<String, Object?>> nuevaReceta(
    String surfaceId, {
    String title = '',
    int servings = 4,
    List<String> ingredientLines = const [],
    List<String> steps = const [],
    int? prepMinutes,
    int? cookMinutes,
    bool fromPhoto = false,
  }) =>
      (A2uiFormBuilder(surfaceId)
            ..title(fromPhoto ? 'Revisá la receta de la foto' : 'Nueva receta')
            ..text(
                fromPhoto
                    ? 'La leí de la imagen: corregí lo que haga falta antes de guardarla.'
                    : 'Un ingrediente por renglón, por ejemplo "200 g de azúcar".',
                caption: true)
            ..field('titulo', 'Nombre', initial: title)
            ..slider('porciones', 'Porciones', 1, 20, initial: servings.clamp(1, 20))
            ..field('ingredientes', 'Ingredientes', multiline: true, initial: ingredientLines.join('\n'),
                placeholder: '4 huevos\n200 g de azúcar\nsal a gusto')
            ..field('pasos', 'Pasos', multiline: true, initial: steps.join('\n'),
                placeholder: 'Un paso por renglón')
            ..field('preparacion', 'Minutos de preparación', number: true, initial: prepMinutes?.toString() ?? '')
            ..field('coccion', 'Minutos de cocción', number: true, initial: cookMinutes?.toString() ?? '')
            ..choice('comidas', '¿Para qué comidas?',
                {..._plannedMeals, 'postre': 'Postre', 'entrada': 'Entrada', 'acompanamiento': 'Acompañamiento'},
                multiple: true, initial: const ['almuerzo', 'cena'])
            ..button('Guardar receta', FoodFormAction.nuevaReceta,
                fields: const ['titulo', 'porciones', 'ingredientes', 'pasos', 'preparacion', 'coccion', 'comidas'],
                extra: {'origen': fromPhoto ? 'photo' : 'manual'},
                requiredField: 'titulo',
                requiredMessage: 'Ponele un nombre'))
          .build();

  /// 12. Review (and delete) what the app knows about the household.
  static List<Map<String, Object?>> repasarPreferencias(
    String surfaceId, {
    required List<FoodPreference> prefs,
    FoodProfile profile = const FoodProfile(),
  }) {
    const kinds = {'dislike': 'No les gusta', 'allergy': 'Alergia', 'like': 'Les encanta', 'diet': 'Dieta'};
    final b = A2uiFormBuilder(surfaceId)
      ..title('Lo que sé de ustedes')
      ..text('Cocinan para ${profile.servings}; '
          '${profile.weekdayMaxMinutes == null ? 'sin límite de tiempo' : 'hasta ${profile.weekdayMaxMinutes} min'} entre semana.',
          caption: true);
    if (prefs.isEmpty) {
      b.text('Todavía no guardé gustos ni alergias.');
    } else {
      b
        ..choice('borrar', 'Tildá lo que quieras borrar', {
          for (final p in prefs)
            p.id: '${kinds[p.kind] ?? p.kind}: ${p.label}${p.memberName != null ? ' (${p.memberName})' : ''}',
        }, multiple: true, chips: false)
        ..button('Borrar seleccionadas', FoodFormAction.borrarPreferencias,
            fields: const ['borrar'], requiredField: 'borrar', requiredMessage: 'No elegiste nada');
    }
    return b.build();
  }

  /// 13. Confirm an action that is hard to undo.
  static List<Map<String, Object?>> confirmar(
    String surfaceId, {
    required String message,
    required String action,
    Map<String, Object?> payload = const {},
    String confirmLabel = 'Sí, dale',
  }) =>
      (A2uiFormBuilder(surfaceId)
            ..title('¿Seguro?')
            ..text(message)
            ..buttonRow([
              (b) => b.button('Cancelar', FoodFormAction.cancelar, primary: false),
              (b) => b.button(confirmLabel, FoodFormAction.confirmar, extra: {'accion': action, ...payload}),
            ]))
          .build();

  /// 14. Pick produce in season to cook with.
  static List<Map<String, Object?>> deEstacion(String surfaceId, {required Map<String, String> ingredients}) =>
      (A2uiFormBuilder(surfaceId)
            ..title('De estación este mes')
            ..choice('ingredientes', 'Elegí con qué querés cocinar', ingredients, multiple: true, filterable: true)
            ..button('Buscar recetas', FoodFormAction.deEstacion,
                fields: const ['ingredientes'], requiredField: 'ingredientes', requiredMessage: 'Elegí al menos uno'))
          .build();

  static String _recipeLabel(RecipeSummary r) => [
        r.title,
        if (r.totalMinutes > 0) '${r.totalMinutes} min',
        if (r.countryName.isNotEmpty) r.countryName,
        if (r.omit.isNotEmpty) 'sin ${r.omit.join(', ')}',
      ].join(' · ');

  static String _iso(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
