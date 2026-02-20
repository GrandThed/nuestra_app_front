import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';
import 'package:nuestra_app/features/household/data/models/household_model.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_state.dart';

/// Screen for adding a new expense
class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  FocusNode? _descriptionFocusNode;

  DateTime _selectedDate = DateTime.now();
  String? _selectedCategoryId;
  String? _selectedPaidById;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // Load household to get members
      final householdId = ref.read(currentHouseholdIdProvider);
      if (householdId != null) {
        ref.read(householdNotifierProvider.notifier).loadHouseholdIfNeeded(householdId);
      }
      // Set default payer to current user
      final authState = ref.read(authNotifierProvider);
      if (authState is AuthStateAuthenticated) {
        setState(() {
          _selectedPaidById = authState.user.id;
        });
      }
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  /// Get unique descriptions from previous expenses for autocomplete
  List<String> _getDescriptionSuggestions(String query) {
    final state = ref.read(expensesNotifierProvider);
    if (state is! ExpensesStateLoaded) return [];

    final descriptions = state.expenses
        .map((e) => e.description)
        .toSet()
        .where((d) => d.toLowerCase().contains(query.toLowerCase()))
        .take(8)
        .toList();

    return descriptions;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final amount = double.tryParse(
      _amountController.text.replaceAll(',', '.'),
    );

    if (amount == null || amount <= 0) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Monto invalido')),
      );
      return;
    }

    final expense = await ref.read(expensesNotifierProvider.notifier).createExpense(
          description: _descriptionController.text.trim(),
          amount: amount,
          date: _selectedDate,
          categoryId: _selectedCategoryId,
          paidById: _selectedPaidById,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      if (expense != null) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gasto registrado')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al registrar gasto')),
        );
      }
    }
  }

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    final iconController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nueva categoria'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
            ),
            const SizedBox(height: AppSizes.md),
            TextField(
              controller: iconController,
              decoration: const InputDecoration(
                labelText: 'Emoji (opcional)',
                hintText: 'Ej: 🛒',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) return;

              Navigator.pop(dialogContext);
              final result = await ref
                  .read(expensesNotifierProvider.notifier)
                  .createCategory(
                    name: name,
                    icon: iconController.text.trim().isEmpty
                        ? null
                        : iconController.text.trim(),
                  );

              if (mounted && result != null) {
                setState(() => _selectedCategoryId = result.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Categoria creada')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.expenses,
              foregroundColor: Colors.white,
            ),
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expensesState = ref.watch(expensesNotifierProvider);
    final householdState = ref.watch(householdNotifierProvider);
    final categories = expensesState is ExpensesStateLoaded ? expensesState.categories : <ExpenseCategoryModel>[];
    final members = householdState is HouseholdStateLoaded ? householdState.household.members ?? [] : <MemberModel>[];
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'es');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo gasto'),
        backgroundColor: AppColors.expenses,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.lg),
          children: [
            // Amount field
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                _descriptionFocusNode?.requestFocus();
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
              ],
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.expenses,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixText: '\$ ',
                prefixStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.expenses.withValues(alpha: 0.5),
                ),
                hintText: '0.00',
                hintStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                ),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa el monto';
                }
                final amount = double.tryParse(value.replaceAll(',', '.'));
                if (amount == null || amount <= 0) {
                  return 'Monto invalido';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSizes.xl),

            // Description field with autocomplete
            Autocomplete<String>(
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _getDescriptionSuggestions(textEditingValue.text);
              },
              onSelected: (selection) {
                _descriptionController.text = selection;
              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                // Store the focus node reference for keyboard navigation
                _descriptionFocusNode = focusNode;

                // Sync the external controller with the autocomplete's controller
                textEditingController.text = _descriptionController.text;
                textEditingController.addListener(() {
                  if (_descriptionController.text != textEditingController.text) {
                    _descriptionController.text = textEditingController.text;
                  }
                });

                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Descripcion',
                    hintText: 'Ej: Compras del supermercado',
                    prefixIcon: Icon(Icons.description_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa una descripcion';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => onFieldSubmitted(),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);
                          return ListTile(
                            leading: const Icon(Icons.history, size: 20),
                            title: Text(option),
                            onTap: () => onSelected(option),
                            dense: true,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSizes.lg),

            // Who paid selector
            if (members.length > 1) ...[
              Text(
                'Pagado por',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              Wrap(
                spacing: AppSizes.sm,
                runSpacing: AppSizes.sm,
                children: members.map((member) => ChoiceChip(
                      avatar: member.avatarUrl != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(member.avatarUrl!),
                              radius: 12,
                            )
                          : CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.expenses.withValues(alpha: 0.2),
                              child: Text(
                                member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                      label: Text(member.name),
                      selected: _selectedPaidById == member.userId,
                      onSelected: (_) => setState(() => _selectedPaidById = member.userId),
                      selectedColor: AppColors.expenses.withValues(alpha: 0.2),
                    )).toList(),
              ),
              const SizedBox(height: AppSizes.lg),
            ],

            // Date selector
            ListTile(
              leading: const Icon(Icons.calendar_today, color: AppColors.expenses),
              title: const Text('Fecha'),
              subtitle: Text(
                dateFormat.format(_selectedDate),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.chevron_right),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
              ),
              onTap: _selectDate,
            ),
            const SizedBox(height: AppSizes.lg),

            // Category selector
            Text(
              'Categoria',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Wrap(
              spacing: AppSizes.sm,
              runSpacing: AppSizes.sm,
              children: [
                // No category option
                ChoiceChip(
                  label: const Text('Sin categoria'),
                  selected: _selectedCategoryId == null,
                  onSelected: (_) => setState(() => _selectedCategoryId = null),
                  selectedColor: AppColors.expenses.withValues(alpha: 0.2),
                ),
                // Category options
                ...categories.map((category) => ChoiceChip(
                      avatar: category.icon != null
                          ? Text(category.icon!, style: const TextStyle(fontSize: 14))
                          : null,
                      label: Text(category.name),
                      selected: _selectedCategoryId == category.id,
                      onSelected: (_) =>
                          setState(() => _selectedCategoryId = category.id),
                      selectedColor: AppColors.expenses.withValues(alpha: 0.2),
                    )),
                // Add new category
                ActionChip(
                  avatar: const Icon(Icons.add, size: 18),
                  label: const Text('Nueva'),
                  onPressed: _showAddCategoryDialog,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.xl),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.expenses,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Guardar gasto',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
