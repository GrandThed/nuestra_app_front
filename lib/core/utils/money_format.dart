import 'package:intl/intl.dart';

/// Argentine pesos the "Yerba y Miel" way: sign first, no ",00" on whole
/// amounts. 48210 -> "$ 48.210", 12500.5 -> "$ 12.500,50", -300 -> "-$ 300".
/// The space after "$" is non-breaking so the sign never wraps alone.
///
/// (intl's es_AR currency pattern puts the sign last and always shows cents.)
class MoneyFormat {
  const MoneyFormat();

  static final _whole = NumberFormat('#,##0', 'es_AR');
  static final _cents = NumberFormat('#,##0.00', 'es_AR');

  String format(num value) {
    final abs = value.abs();
    final hasCents = (abs * 100).round() % 100 != 0;
    final digits = hasCents ? _cents.format(abs) : _whole.format(abs.round());
    return '${value < 0 ? '-' : ''}\$ $digits';
  }
}
