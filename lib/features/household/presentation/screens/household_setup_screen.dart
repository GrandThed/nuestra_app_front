import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_state.dart';

/// Screen for creating or joining a household
class HouseholdSetupScreen extends ConsumerStatefulWidget {
  const HouseholdSetupScreen({super.key});

  @override
  ConsumerState<HouseholdSetupScreen> createState() =>
      _HouseholdSetupScreenState();
}

class _HouseholdSetupScreenState extends ConsumerState<HouseholdSetupScreen> {
  final _createFormKey = GlobalKey<FormState>();
  final _joinFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  String _selectedHemisphere = 'south'; // Default for Argentina

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final householdState = ref.watch(householdNotifierProvider);
    final isLoading = householdState is HouseholdStateLoading;

    // Listen for household state changes
    ref.listen<HouseholdState>(householdNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        loaded: (household) {
          // Navigate to home on success
          context.go(AppRoutes.home);
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar hogar'),
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout),
            tooltip: AppStrings.signOut,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome text
              Text(
                'Bienvenido a ${AppStrings.appName}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                'Para comenzar, crea un nuevo hogar o únete a uno existente.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.xl),

              // --- Create household section ---
              Text(
                AppStrings.createHousehold,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSizes.sm),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingMd),
                  child: Form(
                    key: _createFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          enabled: !isLoading,
                          decoration: const InputDecoration(
                            labelText: AppStrings.householdName,
                            hintText: 'Ej: Casa de Juan y María',
                            prefixIcon: Icon(Icons.home),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa un nombre';
                            }
                            if (value.length < 3) {
                              return 'El nombre debe tener al menos 3 caracteres';
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: AppSizes.md),

                        // Hemisphere selection
                        Text(
                          'Hemisferio',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSizes.xs),
                        Text(
                          'Usado para mostrar vegetales de temporada',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: AppSizes.sm),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(
                              value: 'south',
                              label: Text('Sur'),
                              icon: Icon(Icons.south),
                            ),
                            ButtonSegment(
                              value: 'north',
                              label: Text('Norte'),
                              icon: Icon(Icons.north),
                            ),
                          ],
                          selected: {_selectedHemisphere},
                          onSelectionChanged: isLoading
                              ? null
                              : (selected) {
                                  setState(
                                      () => _selectedHemisphere = selected.first);
                                },
                        ),
                        const SizedBox(height: AppSizes.md),
                        ElevatedButton(
                          onPressed: isLoading ? null : _submitCreate,
                          child: const Text('Crear Hogar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.lg),

              // --- "or" divider ---
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSizes.md),
                    child: Text(
                      'o',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: AppSizes.lg),

              // --- Join household section ---
              Text(
                AppStrings.joinHousehold,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSizes.sm),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingMd),
                  child: Form(
                    key: _joinFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _codeController,
                          enabled: !isLoading,
                          decoration: const InputDecoration(
                            labelText: AppStrings.inviteCode,
                            hintText: 'Ingresa el código de invitación',
                            prefixIcon: Icon(Icons.vpn_key),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa el código';
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.characters,
                        ),
                        const SizedBox(height: AppSizes.sm),
                        Text(
                          'Pide a un miembro del hogar que te comparta el código de invitación.',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSizes.md),
                        OutlinedButton(
                          onPressed: isLoading ? null : _submitJoin,
                          child: const Text('Unirse'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Loading indicator
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: AppSizes.lg),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitCreate() {
    if (_createFormKey.currentState!.validate()) {
      ref.read(householdNotifierProvider.notifier).createHousehold(
            name: _nameController.text.trim(),
            hemisphere: _selectedHemisphere,
          );
    }
  }

  void _submitJoin() {
    if (_joinFormKey.currentState!.validate()) {
      ref.read(householdNotifierProvider.notifier).joinHousehold(
            _codeController.text.trim(),
          );
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.signOut),
        content: const Text('¿Estás seguro que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ref.read(authNotifierProvider.notifier).signOut();
              context.go(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text(AppStrings.signOut),
          ),
        ],
      ),
    );
  }
}
