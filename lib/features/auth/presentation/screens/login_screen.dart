import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/household/presentation/providers/pending_invite_provider.dart';

/// Login screen with Google and Apple sign-in options
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthStateLoading;

    // Listen for auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (user) {
          // Check for pending invite code first (from web invitation flow)
          final pendingInviteCode = ref.read(pendingInviteCodeProvider);
          if (pendingInviteCode != null) {
            // Clear the pending code and navigate to join screen
            ref.read(pendingInviteCodeProvider.notifier).state = null;
            context.go('/join/$pendingInviteCode');
            return;
          }

          // Normal flow: navigate based on household membership
          if (user.households?.isNotEmpty == true) {
            context.go(AppRoutes.home);
          } else {
            context.go(AppRoutes.householdSetup);
          }
        },
        unauthenticated: () {},
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
            ),
          );
          // Clear error after showing
          ref.read(authNotifierProvider.notifier).clearError();
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // Logo/Title
              const Icon(
                Icons.home_rounded,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppSizes.md),
              Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                'Organiza tu hogar juntos',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),

              // Google Sign In
              _SocialLoginButton(
                onPressed: isLoading
                    ? null
                    : () {
                        ref.read(authNotifierProvider.notifier).signInWithGoogle();
                      },
                icon: Icons.g_mobiledata,
                label: AppStrings.signInWithGoogle,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                borderColor: AppColors.border,
              ),
              const SizedBox(height: AppSizes.md),

              // Apple Sign In (iOS only, not on web)
              if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) ...[
                _SocialLoginButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          ref.read(authNotifierProvider.notifier).signInWithApple();
                        },
                  icon: Icons.apple,
                  label: AppStrings.signInWithApple,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                const SizedBox(height: AppSizes.md),
              ],

              // Loading indicator
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.md),
                  child: Center(child: CircularProgressIndicator()),
                ),

              const SizedBox(height: AppSizes.xl),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable social login button
class _SocialLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  const _SocialLoginButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
    );
  }
}
