import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';

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

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreating ? AppStrings.createHousehold : AppStrings.joinHousehold),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  onSelectionChanged: (selected) {
                    setState(() => _isCreating = selected.first);
                  },
                ),
                const SizedBox(height: AppSizes.xl),

                if (_isCreating) ...[
                  // Create household form
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.householdName,
                      hintText: 'Ej: Casa de Juan y María',
                      prefixIcon: Icon(Icons.home),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un nombre';
                      }
                      return null;
                    },
                  ),
                ] else ...[
                  // Join household form
                  TextFormField(
                    controller: _codeController,
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
                  ),
                ],

                const Spacer(),

                ElevatedButton(
                  onPressed: _submit,
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
        // TODO: Create household API call
      } else {
        // TODO: Join household API call
      }
    }
  }
}
