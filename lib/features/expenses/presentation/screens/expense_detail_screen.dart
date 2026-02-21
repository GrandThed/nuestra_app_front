import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/expenses/data/models/expense_model.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_state.dart';

/// Screen for viewing and managing expense details
class ExpenseDetailScreen extends ConsumerStatefulWidget {
  final String expenseId;

  const ExpenseDetailScreen({
    super.key,
    required this.expenseId,
  });

  @override
  ConsumerState<ExpenseDetailScreen> createState() => _ExpenseDetailScreenState();
}

class _ExpenseDetailScreenState extends ConsumerState<ExpenseDetailScreen> {
  final _currencyFormat = NumberFormat.currency(locale: 'es_AR', symbol: '\$');
  final _dateFormat = DateFormat('EEEE, d MMMM yyyy', 'es');

  ExpenseModel? _getExpense() {
    final state = ref.read(expensesProvider);
    if (state is ExpensesStateLoaded) {
      try {
        return state.expenses.firstWhere((e) => e.id == widget.expenseId);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> _toggleSettled(ExpenseModel expense) async {
    await ref.read(expensesProvider.notifier).settleExpense(
          id: expense.id,
          settled: !expense.allSettled,
        );
  }

  Future<void> _toggleSplitSettled(ExpenseModel expense, ExpenseSplitModel split) async {
    await ref.read(expensesProvider.notifier).settleExpense(
          id: expense.id,
          userId: split.userId,
          settled: !split.settled,
        );
  }

  Future<void> _deleteExpense(ExpenseModel expense) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar gasto'),
        content: Text('¿Eliminar "${expense.description}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success =
          await ref.read(expensesProvider.notifier).deleteExpense(expense.id);
      if (mounted && success) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gasto eliminado')),
        );
      }
    }
  }

  void _showReceiptFullScreen(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: const Text('Comprobante'),
          ),
          body: Center(
            child: InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stack) => const Icon(
                  Icons.broken_image_outlined,
                  size: 64,
                  color: Colors.white54,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes
    ref.watch(expensesProvider);
    final expense = _getExpense();

    if (expense == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de gasto'),
          backgroundColor: AppColors.expenses,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('Gasto no encontrado'),
        ),
      );
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de gasto'),
        backgroundColor: AppColors.expenses,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar',
            onPressed: () => context.push(AppRoutes.expenseEdit(expense.id)),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Eliminar',
            onPressed: () => _deleteExpense(expense),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.lg),
        children: [
          // Amount card
          Card(
            color: AppColors.expenses.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.xl),
              child: Column(
                children: [
                  if (expense.category?.icon != null)
                    Text(
                      expense.category!.icon!,
                      style: const TextStyle(fontSize: 40),
                    ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    _currencyFormat.format(expense.amount),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.expenses,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    expense.description,
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.lg),

          // Info section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.md),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.calendar_today,
                    label: 'Fecha',
                    value: _dateFormat.format(expense.date),
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.person,
                    label: 'Pagado por',
                    value: expense.paidBy.name,
                  ),
                  if (expense.category != null) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.category,
                      label: 'Categoría',
                      value: expense.category!.name,
                      trailing: expense.category!.icon != null
                          ? Text(
                              expense.category!.icon!,
                              style: const TextStyle(fontSize: 20),
                            )
                          : null,
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Receipt image
          if (expense.receiptUrl != null && expense.receiptUrl!.isNotEmpty) ...[
            const SizedBox(height: AppSizes.lg),
            Text(
              'Comprobante',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _showReceiptFullScreen(context, expense.receiptUrl!),
                child: Image.network(
                  expense.receiptUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    height: 100,
                    color: colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: Icon(Icons.broken_image_outlined, size: 40),
                    ),
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSizes.lg),

          // Splits section
          Row(
            children: [
              Text(
                'Division de gastos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              Text(
                'Toca para cambiar estado',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.md),
              child: Column(
                children: expense.splits.asMap().entries.map((entry) {
                  final index = entry.key;
                  final split = entry.value;
                  final isLast = index == expense.splits.length - 1;

                  return Column(
                    children: [
                      InkWell(
                        onTap: () => _toggleSplitSettled(expense, split),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
                          child: Row(
                            children: [
                              // User avatar/initial
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.expenses.withValues(alpha: 0.2),
                                child: Text(
                                  split.user?.name.substring(0, 1).toUpperCase() ?? '?',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.expenses,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSizes.md),
                              // Name
                              Expanded(
                                child: Text(
                                  split.user?.name ?? 'Usuario',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              // Amount
                              Text(
                                _currencyFormat.format(split.amount),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: AppSizes.sm),
                              // Settled badge (tappable indicator)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: split.settled
                                      ? Colors.green.withValues(alpha: 0.1)
                                      : Colors.orange.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      split.settled ? Icons.check_circle : Icons.pending,
                                      size: 14,
                                      color: split.settled ? Colors.green : Colors.orange,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      split.settled ? 'Saldado' : 'Pendiente',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: split.settled ? Colors.green : Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isLast) const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.xl),

          // Settle/Unsettle button
          OutlinedButton.icon(
            onPressed: () => _toggleSettled(expense),
            icon: Icon(
              expense.allSettled ? Icons.undo : Icons.check_circle_outline,
            ),
            label: Text(
              expense.allSettled ? 'Marcar como pendiente' : 'Marcar como saldado',
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: expense.allSettled ? Colors.orange : Colors.green,
              side: BorderSide(
                color: expense.allSettled ? Colors.orange : Colors.green,
              ),
              padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSizes.md),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSizes.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}
