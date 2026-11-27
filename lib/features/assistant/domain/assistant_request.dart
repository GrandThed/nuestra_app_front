import 'dart:convert';

/// What the user asked for, as read by the model from one message.
///
/// The model only classifies and copies text: amounts, dates and months come
/// back as written ("7.000", "ayer", "el mes pasado") and are converted in
/// code (see spanish_parsing.dart). Everything the user then sees (totals,
/// lists, the expense to save) is computed by the app, never written by the
/// model.
enum RequestAction {
  anotarGasto('anotar_gasto'),
  corregirGasto('corregir_gasto'),
  consultarGastos('consultar_gastos'),
  resumenMes('resumen_mes'),
  gastosFijos('gastos_fijos'),
  buscarReceta('buscar_receta'),
  cocinarConLoQueHay('cocinar_con_lo_que_hay'),
  armarMenu('armar_menu'),
  verMenu('ver_menu'),
  listaCompras('lista_compras'),
  guardarGusto('guardar_gusto'),
  repasarGustos('repasar_gustos'),
  invitados('invitados'),
  deEstacion('de_estacion'),
  charlar('charlar');

  final String wire;
  const RequestAction(this.wire);

  static RequestAction fromWire(Object? value) =>
      values.where((a) => a.wire == value).firstOrNull ?? RequestAction.charlar;
}

class AssistantRequest {
  final RequestAction action;

  /// What was bought / what to fix it to.
  final String description;

  /// Amount as the user wrote it ("7.000", "7 lucas").
  final String amount;

  /// Date as the user wrote it ("ayer", "el lunes").
  final String date;

  /// One of the household's category names, or empty.
  final String category;

  /// Month as the user wrote it ("este mes", "octubre").
  final String month;

  /// Word to look for (expenses or recipes): "nafta", "milanesas".
  final String search;
  final List<String> ingredients;

  /// no_le_gusta | le_encanta | alergia
  final String taste;
  final String ingredient;
  final String person;

  const AssistantRequest(
    this.action, {
    this.description = '',
    this.amount = '',
    this.date = '',
    this.category = '',
    this.month = '',
    this.search = '',
    this.ingredients = const [],
    this.taste = '',
    this.ingredient = '',
    this.person = '',
  });

  factory AssistantRequest.fromJson(Map<String, dynamic> json) {
    String s(String key) => '${json[key] ?? ''}'.trim();
    return AssistantRequest(
      RequestAction.fromWire(json['accion']),
      description: s('descripcion'),
      amount: s('monto'),
      date: s('fecha'),
      category: s('categoria'),
      month: s('mes'),
      search: s('buscar'),
      ingredients: [
        for (final i in json['ingredientes'] as List? ?? const [])
          if ('$i'.trim().isNotEmpty) '$i'.trim(),
      ],
      taste: s('gusto'),
      ingredient: s('ingrediente'),
      person: s('persona'),
    );
  }

  @override
  String toString() => 'AssistantRequest(${action.wire}, desc: $description, monto: $amount, fecha: $date, '
      'cat: $category, mes: $month, buscar: $search, ingr: $ingredients, gusto: $taste $ingredient $person)';
}

/// JSON schema for the model's answer (constrained decoding). The category
/// is limited to the household's own names.
Map<String, Object?> requestSchema(List<String> categoryNames) => {
      'type': 'object',
      'properties': {
        'accion': {
          'type': 'string',
          'enum': [for (final a in RequestAction.values) a.wire],
        },
        'descripcion': {'type': 'string'},
        'monto': {'type': 'string'},
        'fecha': {'type': 'string'},
        'categoria': {
          'type': 'string',
          'enum': [...categoryNames, ''],
        },
        'mes': {'type': 'string'},
        'buscar': {'type': 'string'},
        'ingredientes': {
          'type': 'array',
          'items': {'type': 'string'},
        },
        'gusto': {
          'type': 'string',
          'enum': ['no_le_gusta', 'le_encanta', 'alergia', ''],
        },
        'ingrediente': {'type': 'string'},
        'persona': {'type': 'string'},
      },
      'required': ['accion'],
      'additionalProperties': false,
    };

/// Instructions for reading a message. Short on purpose (the phone reads the
/// whole prompt before answering) and built around examples, which a small
/// model follows far better than rules.
String requestPrompt({
  required List<String> categoryNames,
  String? pendingExpense,
  String? lastAssistant,
}) {
  final categories = categoryNames.isEmpty ? '(ninguna)' : categoryNames.join(', ');
  return '''
Leés un mensaje de una app de hogar (gastos y comida) y devolvés solo un JSON con lo que pide.
Copiá montos, fechas y meses TAL CUAL los escribió (no los conviertas).
Categorías de gastos del hogar: $categories. Elegí la que corresponda o "".

Acciones:
anotar_gasto: cuenta algo que compró o pagó.
corregir_gasto: cambia un dato del gasto pendiente (monto, categoría, fecha, descripción).
consultar_gastos: pregunta cuánto gastó en algo o qué gastos hubo.
resumen_mes: pide el total o un resumen del mes.
gastos_fijos: pregunta por gastos fijos o qué falta cargar.
buscar_receta: quiere una receta o idea de comida.
cocinar_con_lo_que_hay: dice qué ingredientes tiene.
armar_menu: quiere planear el menú de la semana.
ver_menu: pregunta qué comen o qué hay en el menú.
lista_compras: pide la lista de compras.
guardar_gusto: cuenta que algo no le gusta, le encanta o le da alergia.
repasar_gustos: pregunta qué sabe la app de sus gustos.
invitados: vienen invitados a comer.
de_estacion: pregunta qué frutas o verduras hay de estación.
charlar: cualquier otra cosa.

Ejemplos:
"gasté 7.000 de nafta" → {"accion":"anotar_gasto","descripcion":"Nafta","monto":"7.000","fecha":"hoy","categoria":"${_example(categoryNames, 'transporte')}"}
"ayer 15 lucas en el súper" → {"accion":"anotar_gasto","descripcion":"Supermercado","monto":"15 lucas","fecha":"ayer","categoria":"${_example(categoryNames, 'super')}"}
"pagué la luz 23.500,50 el lunes" → {"accion":"anotar_gasto","descripcion":"Luz","monto":"23.500,50","fecha":"el lunes","categoria":"${_example(categoryNames, 'servic')}"}
"no, eran 8000" → {"accion":"corregir_gasto","monto":"8000"}
"ponele transporte" → {"accion":"corregir_gasto","categoria":"${_example(categoryNames, 'transporte')}"}
"cuánto gastamos de nafta este mes?" → {"accion":"consultar_gastos","buscar":"nafta","mes":"este mes"}
"cuánto gastamos en octubre" → {"accion":"resumen_mes","mes":"octubre"}
"qué gastos fijos me faltan" → {"accion":"gastos_fijos","mes":"este mes"}
"una receta con pollo para hoy" → {"accion":"buscar_receta","buscar":"pollo"}
"tengo arroz, huevos y zapallo" → {"accion":"cocinar_con_lo_que_hay","ingredientes":["arroz","huevos","zapallo"]}
"armame el menú de la semana" → {"accion":"armar_menu"}
"a Juan no le gusta la remolacha" → {"accion":"guardar_gusto","gusto":"no_le_gusta","ingrediente":"remolacha","persona":"Juan"}
"hola, cómo andás" → {"accion":"charlar"}
${pendingExpense == null ? '' : '\nHay un gasto sin guardar en pantalla: $pendingExpense. Si el mensaje cambia un dato de ese gasto, es corregir_gasto.'}${lastAssistant == null ? '' : '\nLo último que dijo la app: "$lastAssistant"'}''';
}

/// A category name that contains [hint], for the examples; empty when the
/// household has none like it (an unrelated name would teach a wrong match).
String _example(List<String> names, String hint) =>
    names.where((n) => n.toLowerCase().contains(hint)).firstOrNull ?? '';

/// Lenient read of a model answer: the first {...} in [text].
Map<String, dynamic>? decodeJsonObject(String text) {
  final start = text.indexOf('{');
  final end = text.lastIndexOf('}');
  if (start < 0 || end <= start) return null;
  try {
    final decoded = jsonDecode(text.substring(start, end + 1));
    return decoded is Map<String, dynamic> ? decoded : null;
  } on FormatException {
    return null;
  }
}
