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
  bool _isCreating = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  String _selectedHemisphere = 'southern'; // Default for Argentina

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
        title: Text(
            _isCreating ? AppStrings.createHousehold : AppStrings.joinHousehold),
        actions: [
          // Logout option
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout),
            tooltip: AppStrings.signOut,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Form(
            key: _formKey,
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
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.xl),

                // Toggle between create and join
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: true,
                      label: Text('Crear'),
                      icon: Icon(Icons.add_home),
                    ),
                    ButtonSegment(
                      value: false,
                      label: Text('Unirse'),
                      icon: Icon(Icons.group_add),
                    ),
                  ],
                  selected: {_isCreating},
                  onSelectionChanged: isLoading
                      ? null
                      : (selected) {
                          setState(() => _isCreating = selected.first);
                        },
                ),
                const SizedBox(height: AppSizes.xl),

                if (_isCreating) ...[
                  // Create household form
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
                  const SizedBox(height: AppSizes.lg),

                  // Hemisphere selection
                  Text(
                    'Hemisferio',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    'Usado para mostrar vegetales de temporada',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: 'southern',
                        label: Text('Sur'),
                        icon: Icon(Icons.south),
                      ),
                      ButtonSegment(
                        value: 'northern',
                        label: Text('Norte'),
                        icon: Icon(Icons.north),
                      ),
                    ],
                    selected: {_selectedHemisphere},
                    onSelectionChanged: isLoading
                        ? null
                        : (selected) {
                            setState(() => _selectedHemisphere = selected.first);
                          },
                  ),
                ] else ...[
                  // Join household form
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
                  const SizedBox(height: AppSizes.md),
                  Text(
                    'Pide a un miembro del hogar que te comparta el código de invitación.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],

                const Spacer(),

                // Loading indicator
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.only(bottom: AppSizes.md),
                    child: Center(child: CircularProgressIndicator()),
                  ),

                // Submit button
                ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  child: Text(_isCreating ? 'Crear Hogar' : 'Unirse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_isCreating) {
        ref.read(householdNotifierProvider.notifier).createHousehold(
              name: _nameController.text.trim(),
              hemisphere: _selectedHemisphere,
            );
      } else {
        ref.read(householdNotifierProvider.notifier).joinHousehold(
              _codeController.text.trim(),
            );
      }
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
