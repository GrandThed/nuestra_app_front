import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Secondary colors
  static const Color secondary = Color(0xFF8B5CF6); // Purple
  static const Color secondaryLight = Color(0xFFA78BFA);
  static const Color secondaryDark = Color(0xFF7C3AED);

  // Surface colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color background = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF111827);

  // Text colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Feature colors (for different modules)
  static const Color boards = Color(0xFFEC4899); // Pink
  static const Color recipes = Color(0xFFF97316); // Orange
  static const Color menus = Color(0xFF14B8A6); // Teal
  static const Color wishlists = Color(0xFF8B5CF6); // Purple
  static const Color expenses = Color(0xFF22C55E); // Green
  static const Color calendar = Color(0xFF3B82F6); // Blue

  // Border colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);

  // Divider
  static const Color divider = Color(0xFFE5E7EB);
  static const Color dividerDark = Color(0xFF374151);

  // Surface variants
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  static const Color surfaceVariantDark = Color(0xFF374151);

  // Shimmer colors
  static const Color shimmerBase = Color(0xFFE5E7EB);
  static const Color shimmerHighlight = Color(0xFFF9FAFB);
}
