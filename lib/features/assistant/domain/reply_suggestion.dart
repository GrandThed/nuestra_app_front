import 'package:nuestra_app/features/assistant/domain/chat_items.dart';
import 'package:nuestra_app/features/assistant/domain/spanish_parsing.dart';

const _monthNames = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
];

String _month(int year, int month, DateTime now) {
  if (year == now.year && month == now.month) return 'este mes';
  final previous = DateTime(now.year, now.month - 1);
  if (year == previous.year && month == previous.month) return 'el mes pasado';
  return 'en ${_monthNames[month - 1]}';
}

/// The one reply worth offering after what the assistant just showed, or
/// null. Picked in code from the last card, so it is always something the
/// app can answer, and worded like the requests the model reads best.
String? replySuggestion(List<ChatItem> items, DateTime now) {
  if (items.isEmpty) return null;
  final last = items.last;
  final suggestion = switch (last) {
    ExpenseDraftCard(:final status, :final date) => status == DraftStatus.saved
        ? '¿Cuánto gastamos ${_month(date.year, date.month, now)}?'
        : null,
    SpendingCard(:final year, :final month) => '¿Cuánto gastamos ${_month(year, month, now)} en total?',
    MonthSummaryCard(:final year, :final month) =>
      year == now.year && month == now.month ? '¿Qué gastos fijos faltan?' : '¿Cuánto gastamos este mes?',
    FixedExpensesCard() => '¿Cuánto gastamos este mes?',
    RecipesCard(:final recipes) => recipes.isEmpty ? 'Una receta rápida para hoy' : 'Arma el menú de la semana',
    MenuCard() => 'Muéstrame la lista de compras',
    PreferenceCard(:final undone) => undone ? null : 'Una receta para esta noche',
    _ => null,
  };
  if (suggestion == null) return null;

  // Never offer what the user just asked
  final lastUser = items.reversed.whereType<UserMessage>().firstOrNull;
  if (lastUser != null && normalizeEs(lastUser.text) == normalizeEs(suggestion)) return null;
  return suggestion;
}
