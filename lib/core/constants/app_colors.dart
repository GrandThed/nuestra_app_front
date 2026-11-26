import 'package:flutter/material.dart';

/// "Yerba y Miel" palette (see docs/design-system.html).
///
/// - Yerba (green): what is yours and confirmed — main actions, saved data.
/// - Miel (honey): what the app proposes and waits for your OK — fixed
///   expense suggestions, the assistant, expenses to confirm.
///
/// Every text pair passes WCAG AA (4.5:1) in light and dark.
/// Prefer `Theme.of(context).colorScheme` in widgets so dark mode works; the
/// constants below are the light values (with explicit `...Dark` twins).
class AppColors {
  AppColors._();

  // ---------- Yerba (primary) ----------
  static const Color primary = Color(0xFF2E6B4F);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFD6EADD);
  static const Color onPrimaryContainer = Color(0xFF0F3523);
  static const Color primaryLight = Color(0xFF4F8F6E);
  static const Color primaryDark = Color(0xFF1F4A35);

  static const Color primaryOnDark = Color(0xFF82C8A1);
  static const Color onPrimaryOnDark = Color(0xFF0A2A1A);
  static const Color primaryContainerDark = Color(0xFF1F4A35);
  static const Color onPrimaryContainerDark = Color(0xFFCDEBDA);

  // ---------- Miel (app suggestions) ----------
  static const Color accent = Color(0xFFA85A22);
  static const Color accentContainer = Color(0xFFF7E4D1);
  static const Color onAccentContainer = Color(0xFF57290A);

  static const Color accentOnDark = Color(0xFFE8A877);
  static const Color accentContainerDark = Color(0xFF4A2B14);
  static const Color onAccentContainerDark = Color(0xFFF9E2CE);

  /// Legacy names, now the honey accent.
  static const Color secondary = accent;
  static const Color secondaryLight = accentOnDark;
  static const Color secondaryDark = Color(0xFF7A3F14);

  // ---------- Neutrals ----------
  /// Paper: app background.
  static const Color background = Color(0xFFF7F4EE);
  static const Color surface = Color(0xFFFFFFFF);

  /// Sand: chips, tinted icon tiles, assistant bubbles.
  static const Color surfaceVariant = Color(0xFFEFEBE3);
  static const Color border = Color(0xFFDDD7CC);
  static const Color divider = border;

  static const Color backgroundDark = Color(0xFF0F1411);
  static const Color surfaceDark = Color(0xFF161C18);
  static const Color surfaceVariantDark = Color(0xFF202823);
  static const Color surfaceElevatedDark = Color(0xFF222A25);
  static const Color borderDark = Color(0xFF323C35);
  static const Color dividerDark = borderDark;

  // ---------- Ink (text) ----------
  static const Color textPrimary = Color(0xFF1C2420);
  static const Color textSecondary = Color(0xFF56615B);
  static const Color textTertiary = Color(0xFF7A847E);

  static const Color textPrimaryDark = Color(0xFFECE8E0);
  static const Color textSecondaryDark = Color(0xFFAEB6B0);
  static const Color textTertiaryDark = Color(0xFF89938C);

  // ---------- Status ----------
  static const Color success = Color(0xFF2C7A4E);
  static const Color warning = Color(0xFF8C5B10);
  static const Color warningContainer = Color(0xFFFAEED3);
  static const Color error = Color(0xFFB13D2B);
  static const Color errorContainer = Color(0xFFF8DFD9);
  static const Color info = Color(0xFF2E6590);

  static const Color successDark = Color(0xFF82C8A1);
  static const Color warningDark = Color(0xFFE5BA62);
  static const Color warningContainerDark = Color(0xFF3D2E10);
  static const Color errorDark = Color(0xFFF0907E);
  static const Color errorContainerDark = Color(0xFF4A1E17);
  static const Color infoDark = Color(0xFF93BDE2);

  /// Gastos is the core feature: it uses the brand green.
  static const Color expenses = primary;

  // ---------- Household members ----------
  /// Who paid: dot on each expense, avatar background. White initials pass
  /// 5:1 on all of them.
  static const List<Color> members = [
    Color(0xFF2E6B4F),
    Color(0xFFA85A22),
    Color(0xFF3B67A0),
    Color(0xFF8E4A78),
    Color(0xFF5F7426),
    Color(0xFFB13D2B),
  ];

  /// Stable color for a member id.
  static Color memberColor(String id) =>
      members[id.codeUnits.fold(0, (a, b) => a + b) % members.length];

  // Shimmer
  static const Color shimmerBase = surfaceVariant;
  static const Color shimmerHighlight = background;
}

/// Status colors that follow the current brightness.
extension StatusColors on ColorScheme {
  bool get _dark => brightness == Brightness.dark;

  Color get success => _dark ? AppColors.successDark : AppColors.success;
  Color get warning => _dark ? AppColors.warningDark : AppColors.warning;
  Color get warningContainer =>
      _dark ? AppColors.warningContainerDark : AppColors.warningContainer;
  Color get info => _dark ? AppColors.infoDark : AppColors.info;
}
