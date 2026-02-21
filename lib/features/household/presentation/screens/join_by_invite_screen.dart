import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_state.dart';
import 'package:nuestra_app/features/household/presentation/providers/pending_invite_provider.dart';

/// Screen for joining a household via invite deeplink
class JoinByInviteScreen extends ConsumerStatefulWidget {
  final String inviteCode;

  const JoinByInviteScreen({
    super.key,
    required this.inviteCode,
  });

  @override
  ConsumerState<JoinByInviteScreen> createState() => _JoinByInviteScreenState();
}

class _JoinByInviteScreenState extends ConsumerState<JoinByInviteScreen> {
  bool _isJoining = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Check if user is already in a household
    Future.microtask(() => _checkUserStatus());
  }

  void _checkUserStatus() {
    final authState = ref.read(authProvider);
    if (authState is AuthStateAuthenticated) {
      final hasHousehold = authState.user.households?.isNotEmpty ?? false;
      if (hasHousehold) {
        // User already has a household, show warning
        setState(() {
          _errorMessage =
              'Ya perteneces a un hogar. Debes abandonarlo primero para unirte a otro.';
        });
      }
    }
  }

  Future<void> _joinHousehold() async {
    setState(() {
      _isJoining = true;
      _errorMessage = null;
    });

    final household = await ref
        .read(householdProvider.notifier)
        .joinHousehold(widget.inviteCode);

    if (!mounted) return;

    setState(() => _isJoining = false);

    if (household != null) {
      // Success - navigate to home
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Te uniste a "${household.name}"'),
          backgroundColor: AppColors.success,
        ),
      );
      context.go(AppRoutes.home);
    } else {
      // Error
      final state = ref.read(householdProvider);
      setState(() {
        _errorMessage = state is HouseholdStateError
            ? state.message
            : 'Error al unirse al hogar';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isAuthenticated = authState is AuthStateAuthenticated;
    final hasHousehold = isAuthenticated &&
        (authState.user.households?.isNotEmpty ?? false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unirse a un hogar'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Navigate based on auth state
            if (isAuthenticated) {
              context.go(AppRoutes.home);
            } else {
              context.go(AppRoutes.login);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon
              const Icon(
                Icons.home_outlined,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppSizes.xl),

              // Title
              Text(
                'Invitación para unirse',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.md),

              // Description
              Text(
                'Has recibido una invitación para unirte a un hogar en Nuestra App.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.lg),

              // Invite code display
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.lg,
                  vertical: AppSizes.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Código de invitación',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      widget.inviteCode.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.xl),

              // Error message
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    border: Border.all(color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.error,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
              ],

              // Action buttons
              if (!isAuthenticated) ...[
                // Not logged in - store invite code and redirect to login
                ElevatedButton.icon(
                  onPressed: () {
                    // Store the invite code so we can return after login
                    ref.read(pendingInviteCodeProvider.notifier).set(
                        widget.inviteCode);
                    context.go(AppRoutes.login);
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Iniciar sesión para continuar'),
                ),
              ] else if (hasHousehold) ...[
                // Already has household
                OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutes.householdSettings),
                  icon: const Icon(Icons.settings),
                  label: const Text('Ir a configuración del hogar'),
                ),
                const SizedBox(height: AppSizes.sm),
                TextButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: const Text('Cancelar'),
                ),
              ] else ...[
                // Can join
                ElevatedButton.icon(
                  onPressed: _isJoining ? null : _joinHousehold,
                  icon: _isJoining
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check),
                  label: Text(_isJoining ? 'Uniéndose...' : 'Unirse al hogar'),
                ),
                const SizedBox(height: AppSizes.sm),
                TextButton(
                  onPressed: _isJoining ? null : () => context.go(AppRoutes.home),
                  child: const Text('Cancelar'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
