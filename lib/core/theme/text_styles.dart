import 'dart:ui' show FontFeature;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// "Yerba y Miel" type: Fraunces (soft serif) for screen titles and big
/// amounts, Figtree for everything else. Amounts always use tabular figures
/// so they line up in lists.
class AppTextStyles {
  AppTextStyles._();

  static const _tabular = [FontFeature.tabularFigures()];

  /// Text theme for a given base (light or dark), colors come from the theme.
  static TextTheme textTheme(TextTheme base) {
    final ui = GoogleFonts.figtreeTextTheme(base);
    TextStyle display(TextStyle? s, double size, double height) =>
        GoogleFonts.fraunces(
          textStyle: s,
          fontSize: size,
          height: height / size,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        );
    return ui.copyWith(
      displayLarge: display(ui.displayLarge, 40, 44),
      displayMedium: display(ui.displayMedium, 34, 40),
      displaySmall: display(ui.displaySmall, 30, 36),
      headlineLarge: display(ui.headlineLarge, 28, 34),
      headlineMedium: display(ui.headlineMedium, 26, 32),
      headlineSmall: display(ui.headlineSmall, 22, 28),
      titleLarge: ui.titleLarge?.copyWith(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w700),
      titleMedium: ui.titleMedium?.copyWith(fontSize: 16, height: 22 / 16, fontWeight: FontWeight.w600),
      titleSmall: ui.titleSmall?.copyWith(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w600),
      bodyLarge: ui.bodyLarge?.copyWith(fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w500),
      bodyMedium: ui.bodyMedium?.copyWith(fontSize: 14, height: 20 / 14),
      bodySmall: ui.bodySmall?.copyWith(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w500),
      labelLarge: ui.labelLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0),
      labelMedium: ui.labelMedium?.copyWith(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0),
      labelSmall: ui.labelSmall?.copyWith(fontSize: 11.5, fontWeight: FontWeight.w600, letterSpacing: 0),
    );
  }

  /// Screen title in app bars (Fraunces).
  static TextStyle screenTitle(Color color) => GoogleFonts.fraunces(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: -0.2,
      );

  /// Big amount (month total, new expense, confirmation cards): Fraunces,
  /// tabular figures.
  static TextStyle bigAmount({required double size, required Color color}) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.1,
        letterSpacing: -0.3,
        fontFeatures: _tabular,
      );

  /// Amount in lists and rows: Figtree bold, tabular figures.
  static TextStyle amount({double size = 15, Color? color}) =>
      GoogleFonts.figtree(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
        fontFeatures: _tabular,
      );
}
