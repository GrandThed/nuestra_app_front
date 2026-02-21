import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';

/// Profile screen displaying user info, household, and navigation options.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Extract user data from auth state
    final user = authState is AuthStateAuthenticated ? authState.user : null;
    final userName = user?.name ?? 'Usuario';
    final userEmail = user?.email ?? '';
    final initials = _buildInitials(userName);

    // Get current household name from user's household memberships
    final householdName = user?.households?.isNotEmpty == true
        ? user!.households!.first.name
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMd,
                  vertical: AppSizes.paddingLg,
                ),
                child: Column(
                  children: [
                    // --- Avatar and user info ---
                    const SizedBox(height: AppSizes.md),
                    CircleAvatar(
                      radius: AppSizes.avatarXl / 2,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.fontXxl,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.md),
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      userEmail,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),

                    // --- Household info ---
                    if (householdName != null) ...[
                      const SizedBox(height: AppSizes.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingSm,
                          vertical: AppSizes.paddingXs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusFull),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.home_outlined,
                              size: AppSizes.iconSm,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSizes.xs),
                            Text(
                              householdName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: AppSizes.xl),

                    // --- Menu options card ---
                    Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.home_outlined,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            title: const Text('Ajustes del hogar'),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(AppSizes.radiusMd),
                              ),
                            ),
                            onTap: () =>
                                context.push(AppRoutes.householdSettings),
                          ),
                          const Divider(
                            height: 1,
                            indent: AppSizes.md,
                            endIndent: AppSizes.md,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.settings_outlined,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            title: Text(AppStrings.settings),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(AppSizes.radiusMd),
                              ),
                            ),
                            onTap: () => context.push(AppRoutes.settings),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Sign out button pinned at bottom ---
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingMd,
                AppSizes.paddingSm,
                AppSizes.paddingMd,
                AppSizes.paddingLg,
              ),
              child: SizedBox(
                width: double.infinity,
                height: AppSizes.buttonHeight,
                child: OutlinedButton(
                  onPressed: () =>
                      ref.read(authProvider.notifier).signOut(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusMd),
                    ),
                  ),
                  child: Text(
                    AppStrings.signOut,
                    style: const TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build initials from the user's full name.
  /// Takes the first letter of the first name and the first letter of the
  /// last name. Falls back to a single letter if only one name is provided.
  String _buildInitials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';

    final first = parts.first[0].toUpperCase();
    if (parts.length < 2 || parts.last.isEmpty) return first;

    final last = parts.last[0].toUpperCase();
    return '$first$last';
  }
}
