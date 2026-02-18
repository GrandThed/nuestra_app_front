import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/settings/presentation/providers/settings_notifier.dart';

/// Settings screen for app-level configuration
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd),
        children: [
          // Theme section
          _buildSectionHeader(context, 'Tema'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMd,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apariencia',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: AppSizes.sm),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<ThemeMode>(
                        segments: const [
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.system,
                            label: Text('Sistema'),
                            icon: Icon(Icons.settings_brightness),
                          ),
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.light,
                            label: Text('Claro'),
                            icon: Icon(Icons.light_mode),
                          ),
                          ButtonSegment<ThemeMode>(
                            value: ThemeMode.dark,
                            label: Text('Oscuro'),
                            icon: Icon(Icons.dark_mode),
                          ),
                        ],
                        selected: {themeMode},
                        onSelectionChanged: (selection) {
                          ref
                              .read(themeModeNotifierProvider.notifier)
                              .setThemeMode(selection.first);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.lg),
          const Divider(indent: AppSizes.paddingMd, endIndent: AppSizes.paddingMd),
          const SizedBox(height: AppSizes.lg),

          // About section
          _buildSectionHeader(context, 'Acerca de'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMd,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.home_outlined,
                      color: AppColors.primary,
                    ),
                    title: const Text(AppStrings.appName),
                    subtitle: Text(
                      'Tu hogar, organizado',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                    ),
                  ),
                  const Divider(height: 1, indent: AppSizes.paddingMd),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: AppColors.textSecondary,
                    ),
                    title: const Text('Versi\u00f3n'),
                    trailing: Text(
                      '1.0.0',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSizes.xl),
          const Divider(indent: AppSizes.paddingMd, endIndent: AppSizes.paddingMd),
          const SizedBox(height: AppSizes.lg),

          // Sign out button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMd,
            ),
            child: TextButton(
              onPressed: () {
                _showSignOutDialog(context, ref);
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
              ),
              child: const Text(
                AppStrings.signOut,
                style: TextStyle(
                  fontSize: AppSizes.fontMd,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.xl),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingMd,
        0,
        AppSizes.paddingMd,
        AppSizes.sm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.signOut),
        content: const Text(
          '\u00bfEst\u00e1s seguro que deseas cerrar sesi\u00f3n?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ref.read(authNotifierProvider.notifier).signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, AppSizes.buttonHeight),
            ),
            child: const Text(AppStrings.signOut),
          ),
        ],
      ),
    );
  }
}
