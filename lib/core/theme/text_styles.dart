import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';

/// Custom text styles
class AppTextStyles {
  AppTextStyles._();

  // Display
  static final TextStyle displayLarge = GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static final TextStyle displayMedium = GoogleFonts.plusJakartaSans(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Headlines
  static final TextStyle headlineLarge = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontXxl,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static final TextStyle headlineMedium = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontXl,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static final TextStyle headlineSmall = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontLg,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Titles
  static final TextStyle titleLarge = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontLg,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static final TextStyle titleMedium = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontMd,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static final TextStyle titleSmall = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontSm,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body
  static final TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontMd,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static final TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontSm,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static final TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontXs,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Labels
  static final TextStyle labelLarge = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontSm,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static final TextStyle labelMedium = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontXs,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static final TextStyle labelSmall = GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    letterSpacing: 0.5,
  );

  // Button
  static final TextStyle button = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontMd,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Caption
  static final TextStyle caption = GoogleFonts.plusJakartaSans(
    fontSize: AppSizes.fontXs,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
    height: 1.4,
  );
}
