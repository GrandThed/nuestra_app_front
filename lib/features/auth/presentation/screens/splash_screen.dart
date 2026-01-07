import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';

/// Splash screen shown while checking auth status
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (user) {
          // Check if user has a household
          if (user.householdMembers?.isNotEmpty == true) {
            context.go(AppRoutes.home);
          } else {
            context.go(AppRoutes.householdSetup);
          }
        },
        unauthenticated: () {
          context.go(AppRoutes.login);
        },
        error: (message) {
          context.go(AppRoutes.login);
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.home_rounded,
                size: 60,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            // App name
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 48),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
