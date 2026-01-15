import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/features/wishlists/data/models/wishlist_model.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_notifier.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_state.dart';
import 'package:nuestra_app/features/wishlists/presentation/widgets/add_wishlist_item_dialog.dart';
import 'package:nuestra_app/features/wishlists/presentation/widgets/add_category_dialog.dart';

/// Wishlists screen - Shopping lists and wishlists
class WishlistsScreen extends ConsumerStatefulWidget {
  const WishlistsScreen({super.key});

  @override
  ConsumerState<WishlistsScreen> createState() => _WishlistsScreenState();
}

class _WishlistsScreenState extends ConsumerState<WishlistsScreen> {
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(wishlistsNotifierProvider.notifier).loadWishlistsIfNeeded();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(wishlistsNotifierProvider.notifier).loadWishlists();
  }

  void _showAddItemDialog({String? categoryId}) {
    showDialog(
      context: context,
      builder: (context) => AddWishlistItemDialog(
        categoryId: categoryId ?? _selectedCategoryId,
      ),
    );
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddCategoryDialog(),
    );
  }

  void _confirmClearChecked() {
    final state = ref.read(wishlistsNotifierProvider);
    if (state is! WishlistsStateLoaded) return;

    final checkedCount = state.items.where((i) => i.checked).length;
    if (checkedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay items marcados')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpiar items'),
        content: Text(
          '¿Eliminar $checkedCount item${checkedCount > 1 ? 's' : ''} marcado${checkedCount > 1 ? 's' : ''}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(wishlistsNotifierProvider.notifier).clearCheckedItems(
                    categoryId: _selectedCategoryId,
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wishlistsNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.wishlists),
        backgroundColor: AppColors.wishlists,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Nueva categoria',
            onPressed: _showAddCategoryDialog,
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Limpiar marcados',
            onPressed: _confirmClearChecked,
          ),
        ],
      ),
      body: switch (state) {
        WishlistsStateInitial() => const Center(
            child: Text('Cargando listas...'),
          ),
        WishlistsStateLoading() => const Center(
            child: CircularProgressIndicator(color: AppColors.wishlists),
          ),
        WishlistsStateError(:final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                const SizedBox(height: 16),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onRefresh,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        WishlistsStateLoaded(:final categories, :final items) =>
          _buildContent(categories, items),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(),
        backgroundColor: AppColors.wishlists,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildContent(
    List<WishlistCategoryModel> categories,
    List<WishlistItemModel> items,
  ) {
    if (categories.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.wishlists,
      child: Column(
        children: [
          // Category tabs
          _buildCategoryTabs(categories, items),
          // Items list
          Expanded(
            child: _buildItemsList(categories, items),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(
    List<WishlistCategoryModel> categories,
    List<WishlistItemModel> items,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      color: AppColors.surface,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Row(
          children: [
            // "All" tab
            _CategoryChip(
              label: 'Todos',
              count: items.where((i) => !i.checked).length,
              isSelected: _selectedCategoryId == null,
              onTap: () => setState(() => _selectedCategoryId = null),
            ),
            const SizedBox(width: AppSizes.sm),
            // Category tabs
            ...categories.map((category) {
              final categoryItems =
                  items.where((i) => i.category?.id == category.id).toList();
              final uncheckedCount = categoryItems.where((i) => !i.checked).length;
              return Padding(
                padding: const EdgeInsets.only(right: AppSizes.sm),
                child: _CategoryChip(
                  label: category.name,
                  count: uncheckedCount,
                  isSelected: _selectedCategoryId == category.id,
                  onTap: () => setState(() => _selectedCategoryId = category.id),
                  onLongPress: () => _showCategoryOptions(category),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList(
    List<WishlistCategoryModel> categories,
    List<WishlistItemModel> items,
  ) {
    // Filter items by selected category
    final filteredItems = _selectedCategoryId == null
        ? items
        : items.where((i) => i.category?.id == _selectedCategoryId).toList();

    // Sort: unchecked first, then by name
    final sortedItems = List<WishlistItemModel>.from(filteredItems)
      ..sort((a, b) {
        if (a.checked != b.checked) {
          return a.checked ? 1 : -1;
        }
        return a.name.compareTo(b.name);
      });

    if (sortedItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.checklist_outlined,
              size: 64,
              color: AppColors.wishlists.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              _selectedCategoryId != null
                  ? 'No hay items en esta categoria'
                  : 'Lista vacia',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.md),
      itemCount: sortedItems.length,
      itemBuilder: (context, index) {
        final item = sortedItems[index];
        return _WishlistItemTile(
          item: item,
          onToggle: () => _toggleItem(item),
          onEdit: () => _editItem(item),
          onDelete: () => _confirmDeleteItem(item),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist_outlined,
            size: 80,
            color: AppColors.wishlists.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            AppStrings.emptyWishlists,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Crea una categoria para empezar',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showAddCategoryDialog,
            icon: const Icon(Icons.add),
            label: const Text('Nueva categoria'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.wishlists,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleItem(WishlistItemModel item) {
    ref.read(wishlistsNotifierProvider.notifier).toggleItemChecked(
          item.id,
          !item.checked,
        );
  }

  void _editItem(WishlistItemModel item) {
    showDialog(
      context: context,
      builder: (context) => AddWishlistItemDialog(
        categoryId: item.category?.id,
        editingItem: item,
      ),
    );
  }

  void _confirmDeleteItem(WishlistItemModel item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar item'),
        content: Text('¿Eliminar "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(wishlistsNotifierProvider.notifier).deleteItem(item.id);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showCategoryOptions(WishlistCategoryModel category) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Renombrar'),
                onTap: () {
                  Navigator.pop(context);
                  _showRenameCategoryDialog(category);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: AppColors.error),
                title: const Text('Eliminar', style: TextStyle(color: AppColors.error)),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDeleteCategory(category);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRenameCategoryDialog(WishlistCategoryModel category) {
    final controller = TextEditingController(text: category.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Renombrar categoria'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Nombre',
            hintText: 'Ej: Supermercado',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context);
                ref.read(wishlistsNotifierProvider.notifier).updateCategory(
                      id: category.id,
                      name: controller.text.trim(),
                    );
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteCategory(WishlistCategoryModel category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar categoria'),
        content: Text(
          '¿Eliminar "${category.name}" y todos sus items?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(wishlistsNotifierProvider.notifier).deleteCategory(category.id);
              if (_selectedCategoryId == category.id) {
                setState(() => _selectedCategoryId = null);
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _CategoryChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : AppColors.wishlists,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.wishlists : Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.wishlists,
        backgroundColor: AppColors.surfaceVariant,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textPrimary,
        ),
        checkmarkColor: Colors.white,
        showCheckmark: false,
      ),
    );
  }
}

class _WishlistItemTile extends StatelessWidget {
  final WishlistItemModel item;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _WishlistItemTile({
    required this.item,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: InkWell(
        onTap: onToggle,
        onLongPress: onEdit,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.sm,
            vertical: AppSizes.xs,
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: item.checked,
                onChanged: (_) => onToggle(),
                activeColor: AppColors.wishlists,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Item info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (item.preferenceEmoji != null) ...[
                          Text(
                            item.preferenceEmoji!,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 4),
                        ],
                        Expanded(
                          child: Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 16,
                              decoration: item.checked
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: item.checked
                                  ? AppColors.textTertiary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_hasSubtitle) ...[
                      const SizedBox(height: 2),
                      Text(
                        _buildSubtitle(),
                        style: TextStyle(
                          fontSize: 12,
                          color: item.checked
                              ? AppColors.textTertiary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Actions
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                color: AppColors.textTertiary,
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _hasSubtitle =>
      item.quantity != null || item.price != null || item.category != null;

  String _buildSubtitle() {
    final parts = <String>[];
    if (item.quantity != null) {
      parts.add(
        '${item.quantity!.toStringAsFixed(item.quantity! == item.quantity!.roundToDouble() ? 0 : 1)}${item.unit != null ? ' ${item.unit}' : ''}',
      );
    }
    if (item.price != null) {
      parts.add('\$${item.price!.toStringAsFixed(2)}');
    }
    if (item.category != null && parts.isEmpty) {
      parts.add(item.category!.name);
    }
    return parts.join(' • ');
  }
}
