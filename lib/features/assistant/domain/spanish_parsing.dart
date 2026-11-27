/// Reading amounts, dates and months the way people write them in Argentina.
/// The model copies these from the message as text; converting them is done
/// here, in code, because a small model gets "7.000" (seven thousand) wrong.
library;

/// "7.000" → 7000, "$ 1.029,50" → 1029.5, "7 lucas" / "7k" / "7 mil" → 7000,
/// "1,5 palos" / "1.5 millones" → 1500000, "2500" → 2500. Null if there is no
/// amount in [text].
double? parseAmountAr(String text) {
  final t = text.toLowerCase().replaceAll(' ', ' ');
  final m = RegExp(
    r'(\d{1,3}(?:\.\d{3})+(?:,\d{1,2})?|\d+(?:[.,]\d+)?)\s*(k\b|lucas?\b|mil\b|palos?\b|millones?\b|mill[oó]n\b|m\b)?',
  ).firstMatch(t);
  if (m == null) return null;
  var number = m[1]!;
  final suffix = m[2];

  double? value;
  if (RegExp(r'^\d{1,3}(\.\d{3})+(,\d{1,2})?$').hasMatch(number)) {
    // Thousands with dots, optional decimals with a comma: 1.029,50
    value = double.tryParse(number.replaceAll('.', '').replaceAll(',', '.'));
  } else if (number.contains(',')) {
    // Decimal comma: 1029,5 / 1,5 (palos)
    value = double.tryParse(number.replaceAll(',', '.'));
  } else if (number.contains('.')) {
    // A single dot: decimals only with 1-2 digits after it ("1.5", "99.90");
    // three digits after it is a thousands separator ("7.000" was handled
    // above, so this is e.g. "12.5")
    final decimals = number.split('.').last;
    value = decimals.length == 3
        ? double.tryParse(number.replaceAll('.', ''))
        : double.tryParse(number);
  } else {
    value = double.tryParse(number);
  }
  if (value == null) return null;

  switch (suffix) {
    case 'k' || 'luca' || 'lucas' || 'mil':
      value *= 1000;
    case 'palo' || 'palos' || 'millones' || 'millón' || 'millon' || 'm':
      value *= 1000000;
  }
  return value;
}

const _weekdays = {
  'lunes': 1, 'martes': 2, 'miercoles': 3, 'jueves': 4, 'viernes': 5, 'sabado': 6, 'domingo': 7,
};

/// Lowercase without accents ("Miércoles" → "miercoles").
String _noAccents(String s) => s
    .toLowerCase()
    .replaceAll(RegExp('[áà]'), 'a')
    .replaceAll(RegExp('[éè]'), 'e')
    .replaceAll(RegExp('[íì]'), 'i')
    .replaceAll(RegExp('[óò]'), 'o')
    .replaceAll(RegExp('[úùü]'), 'u');

const _months = {
  'enero': 1, 'febrero': 2, 'marzo': 3, 'abril': 4, 'mayo': 5, 'junio': 6,
  'julio': 7, 'agosto': 8, 'septiembre': 9, 'setiembre': 9, 'octubre': 10,
  'noviembre': 11, 'diciembre': 12,
};

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

/// "hoy", "ayer", "anteayer", "el lunes" (the last one, today included),
/// "el 15" (this month, or last month if the 15th is still ahead), "15/11",
/// "15/11/2026", "2026-11-15", "15 de noviembre". Null when it says nothing
/// about a date.
DateTime? parseDateEs(String text, DateTime now) {
  final t = _noAccents(text).trim();
  final today = _day(now);
  if (t.isEmpty) return null;
  if (t.contains('anteayer') || t.contains('antes de ayer')) {
    return today.subtract(const Duration(days: 2));
  }
  if (t.contains('ayer')) return today.subtract(const Duration(days: 1));
  if (t.contains('hoy')) return today;

  final iso = RegExp(r'(\d{4})-(\d{1,2})-(\d{1,2})').firstMatch(t);
  if (iso != null) {
    return DateTime(int.parse(iso[1]!), int.parse(iso[2]!), int.parse(iso[3]!));
  }
  final slash = RegExp(r'\b(\d{1,2})/(\d{1,2})(?:/(\d{2,4}))?\b').firstMatch(t);
  if (slash != null) {
    var year = slash[3] == null ? now.year : int.parse(slash[3]!);
    if (year < 100) year += 2000;
    final d = DateTime(year, int.parse(slash[2]!), int.parse(slash[1]!));
    // "28/12" said in January means last December
    return slash[3] == null && d.isAfter(today) ? DateTime(year - 1, d.month, d.day) : d;
  }
  final named = RegExp(r'\b(\d{1,2}) de (' + _months.keys.join('|') + r')\b').firstMatch(t);
  if (named != null) {
    final d = DateTime(now.year, _months[named[2]]!, int.parse(named[1]!));
    return d.isAfter(today) ? DateTime(now.year - 1, d.month, d.day) : d;
  }
  for (final entry in _weekdays.entries) {
    if (RegExp('\\b${entry.key}\\b').hasMatch(t)) {
      final back = (today.weekday - entry.value) % 7;
      return today.subtract(Duration(days: back));
    }
  }
  final dayOnly = RegExp(r'\bel (\d{1,2})\b').firstMatch(t);
  if (dayOnly != null) {
    final n = int.parse(dayOnly[1]!);
    if (n >= 1 && n <= 31) {
      final d = DateTime(now.year, now.month, n);
      return d.isAfter(today) ? DateTime(now.year, now.month - 1, n) : d;
    }
  }
  return null;
}

/// "este mes" / "" → this month, "el mes pasado" → last month, "octubre" →
/// the last October up to now, "octubre 2025", "2026-10". Returns
/// (year, month).
(int, int) parseMonthEs(String text, DateTime now) {
  final t = _noAccents(text);
  final iso = RegExp(r'(\d{4})-(\d{1,2})').firstMatch(t);
  if (iso != null) return (int.parse(iso[1]!), int.parse(iso[2]!));
  if (t.contains('pasado') || t.contains('anterior')) {
    final d = DateTime(now.year, now.month - 1);
    return (d.year, d.month);
  }
  for (final entry in _months.entries) {
    if (t.contains(entry.key)) {
      final year = RegExp(r'\b(20\d{2})\b').firstMatch(t);
      if (year != null) return (int.parse(year[1]!), entry.value);
      return (entry.value > now.month ? now.year - 1 : now.year, entry.value);
    }
  }
  return (now.year, now.month);
}

String _plain(String s) => _noAccents(s).replaceAll(RegExp(r'[¡!¿?.,]'), '').trim();

/// A short "yes" ("sí", "dale", "ok, guardalo", "confirmo").
bool isYes(String text) => RegExp(
      r'^(si|sip|dale|ok|okay|okey|listo|confirmo|confirmar|guardalo|guarda|perfecto|de una|obvio|correcto|claro|va|vamos)( (dale|guardalo|confirmo|porfa|por favor|gracias))*$',
    ).hasMatch(_plain(text));

/// A short "no" ("no", "cancelá", "dejalo", "borralo").
bool isNo(String text) => RegExp(
      r'^(no|nop|cancela|cancelar|cancelalo|dejalo|deja|borralo|descartalo|descarta|olvidalo|nada)( (gracias|dejalo|cancela))*$',
    ).hasMatch(_plain(text));

/// Lowercase without accents, to compare names and searches.
String normalizeEs(String s) => _plain(s);
