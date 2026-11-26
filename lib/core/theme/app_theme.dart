import 'package:flutter/material.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/theme/text_styles.dart';

/// "Yerba y Miel" theme (see docs/design-system.html).
///
/// Flat surfaces with 1px borders; shadows only on what floats (FAB, sheets,
/// dialogs). Radii: 12 buttons/inputs, 16 cards, 24 sheets/dialogs, pill
/// chips and navigation.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(
        const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          primaryContainer: AppColors.primaryContainer,
          onPrimaryContainer: AppColors.onPrimaryContainer,
          // Quiet green-grey for secondary emphasis
          secondary: Color(0xFF4E665A),
          onSecondary: Colors.white,
          secondaryContainer: Color(0xFFE2EAE4),
          onSecondaryContainer: Color(0xFF1C2A22),
          // Miel: what the app proposes
          tertiary: AppColors.accent,
          onTertiary: Colors.white,
          tertiaryContainer: AppColors.accentContainer,
          onTertiaryContainer: AppColors.onAccentContainer,
          error: AppColors.error,
          onError: Colors.white,
          errorContainer: AppColors.errorContainer,
          onErrorContainer: Color(0xFF5C1A10),
          surface: AppColors.background,
          onSurface: AppColors.textPrimary,
          onSurfaceVariant: AppColors.textSecondary,
          surfaceContainerLowest: AppColors.surface,
          surfaceContainerLow: AppColors.surface,
          surfaceContainer: AppColors.surface,
          surfaceContainerHigh: AppColors.surface,
          surfaceContainerHighest: AppColors.surfaceVariant,
          outline: AppColors.textTertiary,
          outlineVariant: AppColors.border,
          inverseSurface: Color(0xFF2A322D),
          onInverseSurface: Color(0xFFF1EEE8),
          inversePrimary: AppColors.primaryOnDark,
          shadow: Color(0xFF1C2420),
          scrim: Colors.black,
        ),
      );

  static ThemeData get dark => _build(
        const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primaryOnDark,
          onPrimary: AppColors.onPrimaryOnDark,
          primaryContainer: AppColors.primaryContainerDark,
          onPrimaryContainer: AppColors.onPrimaryContainerDark,
          secondary: Color(0xFFA9C4B4),
          onSecondary: Color(0xFF14261C),
          secondaryContainer: Color(0xFF2A3630),
          onSecondaryContainer: Color(0xFFDCE7E0),
          tertiary: AppColors.accentOnDark,
          onTertiary: Color(0xFF3A1E08),
          tertiaryContainer: AppColors.accentContainerDark,
          onTertiaryContainer: AppColors.onAccentContainerDark,
          error: AppColors.errorDark,
          onError: Color(0xFF3A0E07),
          errorContainer: AppColors.errorContainerDark,
          onErrorContainer: Color(0xFFFBDCD5),
          surface: AppColors.backgroundDark,
          onSurface: AppColors.textPrimaryDark,
          onSurfaceVariant: AppColors.textSecondaryDark,
          surfaceContainerLowest: Color(0xFF0B0F0D),
          surfaceContainerLow: AppColors.surfaceDark,
          surfaceContainer: AppColors.surfaceDark,
          surfaceContainerHigh: AppColors.surfaceElevatedDark,
          surfaceContainerHighest: AppColors.surfaceVariantDark,
          outline: AppColors.textTertiaryDark,
          outlineVariant: AppColors.borderDark,
          inverseSurface: AppColors.textPrimaryDark,
          onInverseSurface: AppColors.backgroundDark,
          inversePrimary: AppColors.primary,
          shadow: Colors.black,
          scrim: Colors.black,
        ),
      );

  static ThemeData _build(ColorScheme cs) {
    final isDark = cs.brightness == Brightness.dark;
    final cardColor = cs.surfaceContainerLow;
    final border = BorderSide(color: cs.outlineVariant);
    final radius12 = BorderRadius.circular(AppSizes.radiusMd);
    final base = ThemeData(
      useMaterial3: true,
      brightness: cs.brightness,
      colorScheme: cs,
    );
    final text = AppTextStyles.textTheme(base.textTheme).apply(
      bodyColor: cs.onSurface,
      displayColor: cs.onSurface,
    );

    return base.copyWith(
      textTheme: text,
      scaffoldBackgroundColor: cs.surface,
      dividerColor: cs.outlineVariant,
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: AppTextStyles.screenTitle(cs.onSurface),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          side: border,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(borderRadius: radius12),
          textStyle: text.labelLarge,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(borderRadius: radius12),
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(borderRadius: radius12),
          side: border,
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          shape: RoundedRectangleBorder(borderRadius: radius12),
          textStyle: text.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMd,
          vertical: AppSizes.paddingMd,
        ),
        border: OutlineInputBorder(borderRadius: radius12, borderSide: border),
        enabledBorder: OutlineInputBorder(borderRadius: radius12, borderSide: border),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius12,
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius12,
          borderSide: BorderSide(color: cs.error),
        ),
        labelStyle: TextStyle(color: cs.onSurfaceVariant),
        hintStyle: TextStyle(color: cs.outline),
      ),
      dividerTheme: DividerThemeData(
        color: cs.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 68,
        indicatorColor: cs.primaryContainer,
        indicatorShape: const StadiumBorder(),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => text.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? cs.onSurface
                : cs.onSurfaceVariant,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? cs.onPrimaryContainer
                : cs.onSurfaceVariant,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: cardColor,
        indicatorColor: cs.primaryContainer,
        indicatorShape: const StadiumBorder(),
        selectedIconTheme: IconThemeData(color: cs.onPrimaryContainer),
        unselectedIconTheme: IconThemeData(color: cs.onSurfaceVariant),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 3,
        highlightElevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
        extendedTextStyle: text.labelLarge,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: cardColor,
        selectedColor: cs.primaryContainer,
        secondarySelectedColor: cs.primaryContainer,
        checkmarkColor: cs.onPrimaryContainer,
        // Selected = filled yerba container; no checkmark covering avatars
        showCheckmark: false,
        labelStyle: text.labelMedium?.copyWith(color: cs.onSurfaceVariant),
        secondaryLabelStyle: text.labelMedium?.copyWith(color: cs.onPrimaryContainer),
        side: border,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        ),
        titleTextStyle: text.titleLarge,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: cs.outlineVariant,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXl),
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: radius12,
          side: border,
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: cs.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: radius12),
      ),
      switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.transparent
              : cs.outlineVariant,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: cs.primary,
        linearTrackColor: cs.surfaceContainerHighest,
        circularTrackColor: Colors.transparent,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: cs.inverseSurface,
        contentTextStyle: text.bodyMedium?.copyWith(color: cs.onInverseSurface),
        actionTextColor: isDark ? AppColors.primary : AppColors.primaryOnDark,
        shape: RoundedRectangleBorder(borderRadius: radius12),
      ),
    );
  }
}
