import 'package:intl/intl.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/data/repositories/expense_repository.dart';

/// A tool the on-device model can call. Kept to at most 3 arguments: small
/// on-device models get much less reliable with more.
class AssistantToolSpec {
  final String name;
  final String description;
  final Map<String, dynamic> parameters;

  const AssistantToolSpec({
    required this.name,
    required this.description,
    required this.parameters,
  });
}

/// An expense the model wants to add. Never saved directly: the user
/// confirms it on a card first (amounts from small models can be garbled).
class ExpenseProposal {
  final String description;
  final double amount;
  final String? categoryId;
  final String? categoryName;
  final DateTime date;

  const ExpenseProposal({
    required this.description,
    required this.amount,
    required this.date,
    this.categoryId,
    this.categoryName,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'amount': amount,
        'date': DateTime(date.year, date.month, date.day).toIso8601String(),
        if (categoryId != null) 'categoryId': categoryId,
        if (categoryName != null) 'categoryName': categoryName,
      };

  /// Null when the stored data is not a valid proposal.
  static ExpenseProposal? tryFromJson(Object? json) {
    if (json is! Map) return null;
    final amount = json['amount'];
    final date = DateTime.tryParse('${json['date']}');
    if (json['description'] is! String || amount is! num || date == null) {
      return null;
    }
    return ExpenseProposal(
      description: json['description'] as String,
      amount: amount.toDouble(),
      date: date,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
    );
  }
}

/// Result of running a tool: the data sent back to the model, plus an
/// optional proposal for the UI to confirm.
class ToolOutcome {
  final Map<String, dynamic> response;
  final ExpenseProposal? proposal;

  const ToolOutcome(this.response, {this.proposal});
}

const _monthParam = {
  'type': 'string',
  'description':
      'Mes en formato YYYY-MM, por ejemplo 2026-11. Si se omite, el mes actual.',
};

/// Tools exposed to the assistant. Names and descriptions are in Spanish
/// because the whole conversation is.
const assistantToolSpecs = [
  AssistantToolSpec(
    name: 'resumen_del_mes',
    description:
        'Total gastado en un mes, desglosado por categoría, con el estado de '
        'los presupuestos. Usalo para preguntas sobre cuánto se gastó.',
    parameters: {
      'type': 'object',
      'properties': {'mes': _monthParam},
    },
  ),
  AssistantToolSpec(
    name: 'listar_gastos',
    description:
        'Lista los gastos de un mes (los más recientes primero), opcionalmente '
        'filtrados por categoría.',
    parameters: {
      'type': 'object',
      'properties': {
        'mes': _monthParam,
        'categoria': {
          'type': 'string',
          'description': 'Nombre de la categoría, por ejemplo Supermercado.',
        },
      },
    },
  ),
  AssistantToolSpec(
    name: 'gastos_fijos_sugeridos',
    description:
        'Gastos fijos (servicios, alquiler, suscripciones) que se repiten '
        'todos los meses y todavía no se cargaron en el mes indicado.',
    parameters: {
      'type': 'object',
      'properties': {'mes': _monthParam},
    },
  ),
  AssistantToolSpec(
    name: 'proponer_gasto',
    description:
        'Propone registrar un gasto nuevo con fecha de hoy. No lo guarda: el '
        'usuario lo confirma en pantalla. Pasá el monto como texto, solo '
        'números, por ejemplo "15000" o "1029.50".',
    parameters: {
      'type': 'object',
      'properties': {
        'descripcion': {'type': 'string', 'description': 'Qué se compró.'},
        'monto': {'type': 'string', 'description': 'Monto en pesos.'},
        'categoria': {
          'type': 'string',
          'description': 'Nombre de una categoría existente (opcional).',
        },
      },
      'required': ['descripcion', 'monto'],
    },
  ),
];

/// Runs the assistant's tools against the expenses backend.
class AssistantToolExecutor {
  final ExpenseRepository _repository;
  final String _householdId;
  final DateTime Function() _now;

  AssistantToolExecutor(
    this._repository,
    this._householdId, {
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  Future<ToolOutcome> run(String name, Map<String, dynamic> args) async {
    try {
      switch (name) {
        case 'resumen_del_mes':
          return ToolOutcome(await _monthSummary(args));
        case 'listar_gastos':
          return ToolOutcome(await _listExpenses(args));
        case 'gastos_fijos_sugeridos':
          return ToolOutcome(await _fixedSuggestions(args));
        case 'proponer_gasto':
          return await _proposeExpense(args);
        default:
          return ToolOutcome({'error': 'Herramienta desconocida: $name'});
      }
    } catch (e) {
      return ToolOutcome({'error': 'No se pudo completar: $e'});
    }
  }

  /// Parse "YYYY-MM" (also tolerates "YYYY-M" and month names are not
  /// accepted on purpose: the prompt asks for the numeric form).
  (int month, int year) parseMonth(Object? raw) {
    final now = _now();
    final match = RegExp(r'^(\d{4})-(\d{1,2})$').firstMatch('${raw ?? ''}'.trim());
    if (match == null) return (now.month, now.year);
    final year = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    if (month < 1 || month > 12) return (now.month, now.year);
    return (month, year);
  }

  String _label(int month, int year) =>
      DateFormat.yMMMM('es').format(DateTime(year, month));

  Future<Map<String, dynamic>> _monthSummary(Map<String, dynamic> args) async {
    final (month, year) = parseMonth(args['mes']);
    final results = await Future.wait([
      _repository.getExpenses(_householdId, month: month, year: year),
      _repository.getBudgetStatus(_householdId, month, year),
    ]);
    final expenses = results[0] as List<ExpenseModel>;
    final budgets = results[1] as List<BudgetStatusModel>;

    final byCategory = <String, double>{};
    for (final e in expenses) {
      final name = e.category?.name ?? 'Sin categoría';
      byCategory[name] = (byCategory[name] ?? 0) + e.amount;
    }
    final sorted = byCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return {
      'mes': _label(month, year),
      'total': _round(expenses.fold(0.0, (s, e) => s + e.amount)),
      'cantidad_de_gastos': expenses.length,
      'por_categoria': [
        for (final c in sorted) {'categoria': c.key, 'total': _round(c.value)},
      ],
      'presupuestos': [
        for (final b in budgets.where((b) => b.budgetLimit > 0))
          {
            'categoria': b.categoryName,
            'limite': _round(b.budgetLimit),
            'gastado': _round(b.actualSpent),
            'porcentaje_usado': b.percentUsed.round(),
          },
      ],
    };
  }

  Future<Map<String, dynamic>> _listExpenses(Map<String, dynamic> args) async {
    final (month, year) = parseMonth(args['mes']);
    final category = '${args['categoria'] ?? ''}'.trim().toLowerCase();
    var expenses =
        await _repository.getExpenses(_householdId, month: month, year: year);
    if (category.isNotEmpty) {
      expenses = expenses
          .where((e) => (e.category?.name ?? '').toLowerCase().contains(category))
          .toList();
    }
    expenses.sort((a, b) => b.date.compareTo(a.date));
    const limit = 15;

    return {
      'mes': _label(month, year),
      'total_listado': _round(expenses.fold(0.0, (s, e) => s + e.amount)),
      'cantidad': expenses.length,
      'gastos': [
        for (final e in expenses.take(limit))
          {
            'descripcion': e.description,
            'monto': _round(e.amount),
            'fecha': DateFormat('d/M').format(e.date),
            'categoria': e.category?.name,
            'pagado_por': e.paidBy.name,
          },
      ],
      if (expenses.length > limit) 'nota': 'Se muestran los $limit más recientes.',
    };
  }

  Future<Map<String, dynamic>> _fixedSuggestions(
      Map<String, dynamic> args) async {
    final (month, year) = parseMonth(args['mes']);
    final predictions =
        await _repository.getPredictions(_householdId, month: month, year: year);
    return {
      'mes': _label(month, year),
      'sugerencias': [
        for (final p in predictions)
          {
            'descripcion': p.description,
            'monto_sugerido': _round(p.suggestedAmount),
            'dia': p.suggestedDate.day,
            'meses_pagado': '${p.monthsSeen} de ${p.lookbackMonths}',
          },
      ],
      'nota': 'El usuario puede cargarlas desde el aviso en la pantalla Gastos.',
    };
  }

  Future<ToolOutcome> _proposeExpense(Map<String, dynamic> args) async {
    final description = '${args['descripcion'] ?? ''}'.trim();
    final amount = parseAmount(args['monto']);
    if (description.isEmpty || amount == null || amount <= 0) {
      return const ToolOutcome({
        'error': 'Falta la descripción o el monto no es un número válido. '
            'Pedile al usuario el dato que falta.',
      });
    }

    final categoryQuery = '${args['categoria'] ?? ''}'.trim().toLowerCase();
    ExpenseCategoryModel? category;
    if (categoryQuery.isNotEmpty) {
      final categories = await _repository.getCategories(_householdId);
      for (final c in categories) {
        if (c.name.toLowerCase() == categoryQuery) category = c;
      }
      category ??= categories
          .where((c) => c.name.toLowerCase().contains(categoryQuery))
          .firstOrNull;
    }

    final now = _now();
    final proposal = ExpenseProposal(
      description: description,
      amount: amount,
      categoryId: category?.id,
      categoryName: category?.name,
      date: DateTime(now.year, now.month, now.day),
    );
    return ToolOutcome(
      {
        'estado': 'esperando_confirmacion_del_usuario',
        'descripcion': description,
        'monto': amount,
        'categoria': category?.name ?? 'sin categoría',
        'nota': 'Todavía NO está guardado. Decile al usuario que lo confirme '
            'en la tarjeta.',
      },
      proposal: proposal,
    );
  }

  /// Parse an amount written by the model or the user: "15000", "1029.50",
  /// "1.029,50", "\$ 15.000". Returns null when it is not a clean number.
  static double? parseAmount(Object? raw) {
    if (raw is num) return raw.toDouble();
    var text = '${raw ?? ''}'.replaceAll(RegExp(r'[\s\$]|ARS', caseSensitive: false), '');
    if (text.isEmpty) return null;

    final lastComma = text.lastIndexOf(',');
    final lastDot = text.lastIndexOf('.');
    if (lastComma >= 0 && lastDot >= 0) {
      // Both: the later one is the decimal separator
      text = lastComma > lastDot
          ? text.replaceAll('.', '').replaceAll(',', '.')
          : text.replaceAll(',', '');
    } else if (lastComma >= 0) {
      // "1029,50" -> decimal; "15,000" -> thousands
      text = RegExp(r',\d{3}$').hasMatch(text) && text.indexOf(',') == lastComma
          ? text.replaceAll(',', '')
          : text.replaceAll(',', '.');
    } else if (lastDot >= 0 &&
        RegExp(r'^\d{1,3}(\.\d{3})+$').hasMatch(text)) {
      // "15.000" or "1.029.000" -> thousands separators (es_AR)
      text = text.replaceAll('.', '');
    }
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(text)) return null;
    return double.tryParse(text);
  }

  static double _round(double v) => (v * 100).roundToDouble() / 100;
}
