import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

/// Screen for managing recurring expenses
class RecurringExpensesScreen extends ConsumerStatefulWidget {
  const RecurringExpensesScreen({super.key});

  @override
  ConsumerState<RecurringExpensesScreen> createState() =>
      _RecurringExpensesScreenState();
}

class _RecurringExpensesScreenState
    extends ConsumerState<RecurringExpensesScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'es_AR', symbol: '\$');
  final _dateFormat = DateFormat('dd/MM/yyyy');
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(recurringExpensesProvider.notifier).loadIfNeeded();
      // Load household to get members for the add dialog
      final householdId = ref.read(currentHouseholdIdProvider);
      if (householdId != null) {
        ref
            .read(householdProvider.notifier)
            .loadHouseholdIfNeeded(householdId);
      }
    });
  }

  String _recurrenceLabel(String recurrence) {
    switch (recurrence.toLowerCase()) {
      case 'monthly':
        return 'Mensual';
      case 'weekly':
        return 'Semanal';
      case 'yearly':
        return 'Anual';
      default:
        return recurrence;
    }
  }

  IconData _recurrenceIcon(String recurrence) {
    switch (recurrence.toLowerCase()) {
      case 'monthly':
        return Icons.calendar_month;
      case 'weekly':
        return Icons.calendar_view_week;
      case 'yearly':
        return Icons.calendar_today;
      default:
        return Icons.repeat;
    }
  }

  Future<void> _onRefresh() async {
    await ref.read(recurringExpensesProvider.notifier).load();
  }

  Future<void> _generateFromRecurring() async {
    setState(() => _isGenerating = true);
    try {
      final result = await ref
          .read(recurringExpensesProvider.notifier)
          .generateFromRecurring();

      if (mounted) {
        if (result != null && result.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Se generaron ${result.length} gasto(s) pendiente(s)',
              ),
              backgroundColor: AppColors.success,
            ),
          );
        } else if (result != null && result.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No hay gastos recurrentes pendientes de generar'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al generar gastos'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  Future<void> _confirmDelete(RecurringExpenseModel expense) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar gasto recurrente'),
        content: Text(
          '¿Eliminar "${expense.description}"? Esto no afectara los gastos ya generados.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              minimumSize: const Size(0, AppSizes.buttonHeight),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref
          .read(recurringExpensesProvider.notifier)
          .delete(expense.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Gasto recurrente eliminado' : 'Error al eliminar',
            ),
            backgroundColor: success ? null : AppColors.error,
          ),
        );
      }
    }
  }

  void _showAddRecurringExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLg),
        ),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: _AddRecurringExpenseSheet(
          currencyFormat: _currencyFormat,
          onSave: (description, amount, recurrence, nextDueDate, paidById,
              categoryId) async {
            Navigator.pop(sheetContext);
            final result = await ref
                .read(recurringExpensesProvider.notifier)
                .create(
                  description: description,
                  amount: amount,
                  recurrence: recurrence,
                  nextDueDate: nextDueDate,
                  paidById: paidById,
                  categoryId: categoryId,
                );

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    result != null
                        ? 'Gasto recurrente creado'
                        : 'Error al crear gasto recurrente',
                  ),
                  backgroundColor: result != null ? null : AppColors.error,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _toggleActive(RecurringExpenseModel expense) async {
    final result = await ref
        .read(recurringExpensesProvider.notifier)
        .update(expense.id, {'isActive': !expense.isActive});

    if (mounted && result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al actualizar estado'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recurringExpensesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos Recurrentes'),
        backgroundColor: AppColors.expensesDark,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: _isGenerating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.play_arrow),
            tooltip: 'Generar gastos pendientes',
            onPressed: _isGenerating ? null : _generateFromRecurring,
          ),
        ],
      ),
      body: switch (state) {
        RecurringExpensesStateInitial() => const Center(
            child: Text('Cargando gastos recurrentes...'),
          ),
        RecurringExpensesStateLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.expenses),
          ),
        RecurringExpensesStateError(:final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    size: 48, color: AppColors.error),
                const SizedBox(height: AppSizes.md),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: AppSizes.md),
                ElevatedButton(
                  onPressed: _onRefresh,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        RecurringExpensesStateLoaded(:final expenses) =>
          _buildContent(expenses),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRecurringExpenseSheet,
        backgroundColor: AppColors.expensesDark,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(List<RecurringExpenseModel> expenses) {
    if (expenses.isEmpty) {
      return _buildEmptyState();
    }

    final activeExpenses =
        expenses.where((e) => e.isActive).toList();
    final inactiveExpenses =
        expenses.where((e) => !e.isActive).toList();

    final totalMonthly = activeExpenses
        .where((e) => e.recurrence.toLowerCase() == 'monthly')
        .fold(0.0, (sum, e) => sum + e.amount);

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.expenses,
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          // Summary card
          _buildSummaryCard(activeExpenses.length, totalMonthly),
          const SizedBox(height: AppSizes.md),

          // Active recurring expenses
          if (activeExpenses.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.sm),
              child: Text(
                'Activos (${activeExpenses.length})',
                style: TextStyle(
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            ...activeExpenses.map(
              (expense) => _RecurringExpenseCard(
                expense: expense,
                currencyFormat: _currencyFormat,
                dateFormat: _dateFormat,
                recurrenceLabel: _recurrenceLabel(expense.recurrence),
                recurrenceIcon: _recurrenceIcon(expense.recurrence),
                onToggleActive: () => _toggleActive(expense),
                onDismissed: () => _confirmDelete(expense),
              ),
            ),
          ],

          // Inactive recurring expenses
          if (inactiveExpenses.isNotEmpty) ...[
            const SizedBox(height: AppSizes.md),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.sm),
              child: Text(
                'Inactivos (${inactiveExpenses.length})',
                style: TextStyle(
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            ...inactiveExpenses.map(
              (expense) => _RecurringExpenseCard(
                expense: expense,
                currencyFormat: _currencyFormat,
                dateFormat: _dateFormat,
                recurrenceLabel: _recurrenceLabel(expense.recurrence),
                recurrenceIcon: _recurrenceIcon(expense.recurrence),
                onToggleActive: () => _toggleActive(expense),
                onDismissed: () => _confirmDelete(expense),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryCard(int activeCount, double totalMonthly) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      color: AppColors.expenses.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.expenses.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.repeat, color: AppColors.expenses),
            ),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$activeCount gasto(s) activo(s)',
                    style: TextStyle(
                      fontSize: AppSizes.fontSm,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    '${_currencyFormat.format(totalMonthly)} / mes',
                    style: const TextStyle(
                      fontSize: AppSizes.fontXl,
                      fontWeight: FontWeight.bold,
                      color: AppColors.expenses,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.repeat,
            size: 80,
            color: AppColors.expenses.withValues(alpha: 0.3),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            'Sin gastos recurrentes',
            style: TextStyle(
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            'Agrega gastos que se repiten cada mes, semana o anio',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.lg),
          ElevatedButton.icon(
            onPressed: _showAddRecurringExpenseSheet,
            icon: const Icon(Icons.add),
            label: const Text('Agregar gasto recurrente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.expensesDark,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// Card for displaying a single recurring expense
class _RecurringExpenseCard extends StatelessWidget {
  final RecurringExpenseModel expense;
  final NumberFormat currencyFormat;
  final DateFormat dateFormat;
  final String recurrenceLabel;
  final IconData recurrenceIcon;
  final VoidCallback onToggleActive;
  final VoidCallback onDismissed;

  const _RecurringExpenseCard({
    required this.expense,
    required this.currencyFormat,
    required this.dateFormat,
    required this.recurrenceLabel,
    required this.recurrenceIcon,
    required this.onToggleActive,
    required this.onDismissed,
  });

  bool get _isDueSoon {
    final daysUntilDue = expense.nextDueDate.difference(DateTime.now()).inDays;
    return daysUntilDue <= 3 && daysUntilDue >= 0;
  }

  bool get _isOverdue {
    return expense.nextDueDate.isBefore(DateTime.now()) && expense.isActive;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(expense.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onDismissed();
        return false;
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSizes.md),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: AppSizes.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
        child: Opacity(
          opacity: expense.isActive ? 1.0 : 0.5,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Row(
              children: [
                // Category icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.expenses.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    expense.category?.icon ?? '💰',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                // Description and metadata
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.description,
                        style: const TextStyle(
                          fontSize: AppSizes.fontMd,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSizes.xs),
                      Row(
                        children: [
                          Icon(
                            recurrenceIcon,
                            size: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSizes.xs),
                          Text(
                            recurrenceLabel,
                            style: TextStyle(
                              fontSize: AppSizes.fontXs,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: AppSizes.sm),
                          Icon(
                            Icons.event,
                            size: 14,
                            color: _isOverdue
                                ? AppColors.error
                                : _isDueSoon
                                    ? AppColors.warning
                                    : colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSizes.xs),
                          Text(
                            dateFormat.format(expense.nextDueDate),
                            style: TextStyle(
                              fontSize: AppSizes.fontXs,
                              color: _isOverdue
                                  ? AppColors.error
                                  : _isDueSoon
                                      ? AppColors.warning
                                      : colorScheme.onSurfaceVariant,
                              fontWeight: (_isOverdue || _isDueSoon)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      if (expense.paidBy != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Paga: ${expense.paidBy!.name}',
                          style: TextStyle(
                            fontSize: AppSizes.fontXs,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Amount and active toggle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currencyFormat.format(expense.amount),
                      style: const TextStyle(
                        fontSize: AppSizes.fontMd,
                        fontWeight: FontWeight.bold,
                        color: AppColors.expenses,
                      ),
                    ),
                    const SizedBox(height: AppSizes.xs),
                    SizedBox(
                      height: 24,
                      child: Switch(
                        value: expense.isActive,
                        onChanged: (_) => onToggleActive(),
                        activeThumbColor: AppColors.expenses,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet for adding a new recurring expense
class _AddRecurringExpenseSheet extends ConsumerStatefulWidget {
  final NumberFormat currencyFormat;
  final Future<void> Function(
    String description,
    double amount,
    String recurrence,
    String nextDueDate,
    String paidById,
    String? categoryId,
  ) onSave;

  const _AddRecurringExpenseSheet({
    required this.currencyFormat,
    required this.onSave,
  });

  @override
  ConsumerState<_AddRecurringExpenseSheet> createState() =>
      _AddRecurringExpenseSheetState();
}

class _AddRecurringExpenseSheetState
    extends ConsumerState<_AddRecurringExpenseSheet> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedRecurrence = 'monthly';
  DateTime _nextDueDate = DateTime.now();
  String? _selectedPaidById;
  String? _selectedCategoryId;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final authState = ref.read(authProvider);
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

  Future<void> _selectNextDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _nextDueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _nextDueDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedPaidById == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona quien paga')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      await widget.onSave(
        _descriptionController.text.trim(),
        double.parse(_amountController.text.trim()),
        _selectedRecurrence,
        _nextDueDate.toIso8601String(),
        _selectedPaidById!,
        _selectedCategoryId,
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final householdState = ref.watch(householdProvider);
    final expensesState = ref.watch(expensesProvider);

    final members = householdState is HouseholdStateLoaded
        ? householdState.household.members ?? []
        : <MemberModel>[];

    final categories = expensesState is ExpensesStateLoaded
        ? expensesState.categories
        : <ExpenseCategoryModel>[];

    final dateFormat = DateFormat('dd/MM/yyyy');

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSizes.md),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                const Text(
                  'Nuevo gasto recurrente',
                  style: TextStyle(
                    fontSize: AppSizes.fontLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.md),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripcion',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description_outlined),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa una descripcion';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.md),

                // Amount
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Monto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa un monto';
                    }
                    final amount = double.tryParse(value.trim());
                    if (amount == null || amount <= 0) {
                      return 'Ingresa un monto valido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.md),

                // Recurrence selector
                DropdownButtonFormField<String>(
                  initialValue: _selectedRecurrence,
                  decoration: const InputDecoration(
                    labelText: 'Recurrencia',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.repeat),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'weekly',
                      child: Text('Semanal'),
                    ),
                    DropdownMenuItem(
                      value: 'monthly',
                      child: Text('Mensual'),
                    ),
                    DropdownMenuItem(
                      value: 'yearly',
                      child: Text('Anual'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedRecurrence = value);
                    }
                  },
                ),
                const SizedBox(height: AppSizes.md),

                // Next due date
                InkWell(
                  onTap: _selectNextDueDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Proxima fecha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.event),
                    ),
                    child: Text(dateFormat.format(_nextDueDate)),
                  ),
                ),
                const SizedBox(height: AppSizes.md),

                // Paid by selector
                if (members.isNotEmpty)
                  DropdownButtonFormField<String>(
                    initialValue: _selectedPaidById,
                    decoration: const InputDecoration(
                      labelText: 'Quien paga',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    items: members
                        .map(
                          (m) => DropdownMenuItem(
                            value: m.userId,
                            child: Text(m.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedPaidById = value);
                    },
                  ),
                const SizedBox(height: AppSizes.md),

                // Category selector (optional)
                if (categories.isNotEmpty)
                  DropdownButtonFormField<String?>(
                    initialValue: _selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Categoria (opcional)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Sin categoria'),
                      ),
                      ...categories.map(
                        (c) => DropdownMenuItem(
                          value: c.id,
                          child: Row(
                            children: [
                              if (c.icon != null) ...[
                                Text(c.icon!),
                                const SizedBox(width: AppSizes.sm),
                              ],
                              Text(c.name),
                            ],
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedCategoryId = value);
                    },
                  ),
                const SizedBox(height: AppSizes.lg),

                // Save button
                ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.expensesDark,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Crear gasto recurrente'),
                ),
                const SizedBox(height: AppSizes.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
