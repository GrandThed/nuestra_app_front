import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// DateTime extensions
extension DateTimeExtensions on DateTime {
  /// Format as "dd/MM/yyyy"
  String toDateString() => DateFormat('dd/MM/yyyy').format(this);

  /// Format as "dd MMM yyyy" (e.g., "15 Ene 2024")
  String toShortDateString() => DateFormat('dd MMM yyyy', 'es').format(this);

  /// Format as "HH:mm"
  String toTimeString() => DateFormat('HH:mm').format(this);

  /// Format as "dd/MM/yyyy HH:mm"
  String toDateTimeString() => DateFormat('dd/MM/yyyy HH:mm').format(this);

  /// Format as "EEEE, dd MMMM" (e.g., "Lunes, 15 Enero")
  String toLongDateString() => DateFormat('EEEE, dd MMMM', 'es').format(this);

  /// Format as "MMMM yyyy" (e.g., "Enero 2024")
  String toMonthYearString() => DateFormat('MMMM yyyy', 'es').format(this);

  /// Check if same day
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Check if today
  bool get isToday => isSameDay(DateTime.now());

  /// Check if yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(yesterday);
  }

  /// Check if tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(tomorrow);
  }

  /// Get start of day
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  /// Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of month
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59);
}

/// String extensions
extension StringExtensions on String {
  /// Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize each word
  String capitalizeWords() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Check if valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Truncate with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

/// Number extensions
extension NumberExtensions on num {
  /// Format as currency (ARS)
  String toCurrency() {
    return NumberFormat.currency(
      locale: 'es_AR',
      symbol: '\$',
      decimalDigits: 2,
    ).format(this);
  }

  /// Format with thousand separators
  String toFormattedString() {
    return NumberFormat('#,###', 'es_AR').format(this);
  }

  /// Format as percentage
  String toPercentage({int decimals = 1}) {
    return '${toStringAsFixed(decimals)}%';
  }
}

/// BuildContext extensions
extension ContextExtensions on BuildContext {
  /// Get theme
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get padding
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// Show snackbar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
      ),
    );
  }

  /// Show loading dialog
  void showLoadingDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Hide dialog
  void hideDialog() {
    Navigator.of(this).pop();
  }
}

/// List extensions
extension ListExtensions<T> on List<T> {
  /// Safe get at index
  T? safeGet(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}
