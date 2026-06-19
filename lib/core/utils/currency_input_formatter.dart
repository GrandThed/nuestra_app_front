import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Formats numeric input as an Argentine-style amount while typing: groups the
/// integer part with '.' as the thousands separator and allows an optional ','
/// decimal separator with up to two digits (e.g. "1.234,50").
///
/// Use [CurrencyInputFormatter.parse] to turn the formatted text back into a
/// double, and [CurrencyInputFormatter.formatValue] to seed a field with an
/// existing amount.
class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.decimalDigits = 2});

  final int decimalDigits;
  static final NumberFormat _groupFormat = NumberFormat.decimalPattern('es_AR');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    // Split into integer / decimal parts around the first comma.
    final hasComma = text.contains(',');
    final commaIndex = text.indexOf(',');
    var intPart = hasComma ? text.substring(0, commaIndex) : text;
    var decPart = hasComma ? text.substring(commaIndex + 1) : null;

    intPart = intPart.replaceAll(RegExp(r'[^0-9]'), '');
    decPart = decPart?.replaceAll(RegExp(r'[^0-9]'), '');

    if (intPart.isEmpty && (decPart == null || decPart.isEmpty)) {
      return const TextEditingValue(text: '');
    }

    final intValue = intPart.isEmpty ? 0 : int.parse(intPart);
    var formatted = _groupFormat.format(intValue);

    if (hasComma) {
      final limited = (decPart ?? '').length > decimalDigits
          ? decPart!.substring(0, decimalDigits)
          : (decPart ?? '');
      formatted = '$formatted,$limited';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Parse formatted Argentine amount text back into a double.
  static double? parse(String text) {
    if (text.trim().isEmpty) return null;
    final normalized = text.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(normalized);
  }

  /// Format a numeric value into the same grouped representation, for seeding a
  /// text field with an existing amount. Returns '' for zero.
  static String formatValue(double value) {
    if (value == 0) return '';
    if (value == value.roundToDouble()) {
      return _groupFormat.format(value.round());
    }
    return NumberFormat.currency(locale: 'es_AR', symbol: '', decimalDigits: 2)
        .format(value)
        .trim();
  }
}
