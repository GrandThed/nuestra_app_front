import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  static const _collapsedKey = 'wishlist_collapsed_categories';

  String? _selectedCategoryId;
  String? _ownerTypeFilter; // null = all, 'shared', 'personal'
  Set<String> _collapsedCategories = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(wishlistsNotifierProvider.notifier).loadWishlistsIfNeeded();
      _loadCollapsedState();
    });
  }

  Future<void> _loadCollapsedState() async {
    final prefs = await SharedPreferences.getInstance();
    final collapsed = prefs.getStringList(_collapsedKey) ?? [];
    if (mounted) {
      setState(() {
        _collapsedCategories = collapsed.toSet();
      });
    }
  }

  Future<void> _toggleCategoryCollapsed(String categoryId) async {
    setState(() {
      if (_collapsedCategories.contains(categoryId)) {
        _collapsedCategories.remove(categoryId);
      } else {
        _collapsedCategories.add(categoryId);
      }
    });

    // Persist to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_collapsedKey, _collapsedCategories.toList());
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
      appBar: AppBar(
        title: const Text(AppStrings.wishlists),
        backgroundColor: AppColors.wishlistsDark,
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
        backgroundColor: AppColors.wishlistsDark,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
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

    // Filter items by owner type
    final filteredItems = _ownerTypeFilter == null
        ? items
        : items.where((i) => i.ownerType == _ownerTypeFilter).toList();

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.wishlists,
      child: Column(
        children: [
          // Category tabs
          _buildCategoryTabs(categories, filteredItems),
          // Owner type filter
          _buildOwnerTypeFilter(items),
          // Items list
          Expanded(
            child: _buildItemsList(categories, filteredItems),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerTypeFilter(List<WishlistItemModel> allItems) {
    final colorScheme = Theme.of(context).colorScheme;
    final sharedCount = allItems.where((i) => i.ownerType == 'shared' && !i.checked).length;
    final personalCount = allItems.where((i) => i.ownerType == 'personal' && !i.checked).length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.xs),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_list, size: 18, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSizes.sm),
          Text(
            'Tipo:',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          _OwnerTypeChip(
            label: 'Todos',
            count: null,
            isSelected: _ownerTypeFilter == null,
            onTap: () => setState(() => _ownerTypeFilter = null),
          ),
          const SizedBox(width: AppSizes.xs),
          _OwnerTypeChip(
            label: 'Compartidos',
            count: sharedCount,
            isSelected: _ownerTypeFilter == 'shared',
            onTap: () => setState(() => _ownerTypeFilter = 'shared'),
          ),
          const SizedBox(width: AppSizes.xs),
          _OwnerTypeChip(
            label: 'Personales',
            count: personalCount,
            isSelected: _ownerTypeFilter == 'personal',
            onTap: () => setState(() => _ownerTypeFilter = 'personal'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(
    List<WishlistCategoryModel> categories,
    List<WishlistItemModel> items,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      color: colorScheme.surface,
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
    // If a category is selected, show flat list
    if (_selectedCategoryId != null) {
      return _buildFlatItemsList(
        items.where((i) => i.category?.id == _selectedCategoryId).toList(),
      );
    }

    // For "All" tab, group by category
    return _buildGroupedItemsList(categories, items);
  }

  Widget _buildFlatItemsList(List<WishlistItemModel> items) {
    // Sort: unchecked first, then by name
    final sortedItems = List<WishlistItemModel>.from(items)
      ..sort((a, b) {
        if (a.checked != b.checked) {
          return a.checked ? 1 : -1;
        }
        return a.name.compareTo(b.name);
      });

    return ListView(
      padding: const EdgeInsets.all(AppSizes.md),
      children: [
        ...sortedItems.map((item) => _WishlistItemTile(
              item: item,
              onToggle: () => _toggleItem(item),
              onEdit: () => _editItem(item),
              onDelete: () => _confirmDeleteItem(item),
            )),
        // Quick add at the bottom
        _QuickAddItem(
          categoryId: _selectedCategoryId!,
          onAdd: _quickAddItem,
        ),
      ],
    );
  }

  Future<void> _quickAddItem(String categoryId, String name) async {
    await ref.read(wishlistsNotifierProvider.notifier).createItem(
          categoryId: categoryId,
          name: name,
        );
  }

  Widget _buildGroupedItemsList(
    List<WishlistCategoryModel> categories,
    List<WishlistItemModel> items,
  ) {
    if (items.isEmpty) {
      final colorScheme = Theme.of(context).colorScheme;
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
              'Lista vacia',
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    // Group items by category
    final itemsByCategory = <String, List<WishlistItemModel>>{};
    for (final item in items) {
      final categoryId = item.category?.id ?? 'uncategorized';
      itemsByCategory.putIfAbsent(categoryId, () => []).add(item);
    }

    // Sort items within each category: unchecked first, then by name
    for (final categoryItems in itemsByCategory.values) {
      categoryItems.sort((a, b) {
        if (a.checked != b.checked) {
          return a.checked ? 1 : -1;
        }
        return a.name.compareTo(b.name);
      });
    }

    // Build list of category sections (only categories with items)
    final categoriesWithItems = categories
        .where((c) => itemsByCategory.containsKey(c.id))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.md),
      itemCount: categoriesWithItems.length,
      itemBuilder: (context, index) {
        final category = categoriesWithItems[index];
        final categoryItems = itemsByCategory[category.id] ?? [];

        return _CategorySection(
          categoryId: category.id,
          categoryName: category.name,
          items: categoryItems,
          isCollapsed: _collapsedCategories.contains(category.id),
          onToggleCollapsed: () => _toggleCategoryCollapsed(category.id),
          onToggleItem: _toggleItem,
          onEditItem: _editItem,
          onDeleteItem: _confirmDeleteItem,
          onQuickAdd: _quickAddItem,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

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
          Text(
            AppStrings.emptyWishlists,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crea una categoria para empezar',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showAddCategoryDialog,
            icon: const Icon(Icons.add),
            label: const Text('Nueva categoria'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.wishlistsDark,
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

  void _deleteItem(WishlistItemModel item) {
    ref.read(wishlistsNotifierProvider.notifier).deleteItem(item.id);
  }

  void _confirmDeleteItem(WishlistItemModel item) {
    // If item is checked, delete without confirmation
    if (item.checked) {
      _deleteItem(item);
      return;
    }

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
              _deleteItem(item);
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
    final colorScheme = Theme.of(context).colorScheme;

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
                  color: isSelected ? colorScheme.surface : AppColors.wishlists,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.wishlists : colorScheme.surface,
                  ),
                ),
              ),
            ],
          ],
        ),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.wishlists,
        backgroundColor: colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(
          color: isSelected ? colorScheme.surface : colorScheme.onSurface,
        ),
        checkmarkColor: colorScheme.surface,
        showCheckmark: false,
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final List<WishlistItemModel> items;
  final bool isCollapsed;
  final VoidCallback onToggleCollapsed;
  final void Function(WishlistItemModel) onToggleItem;
  final void Function(WishlistItemModel) onEditItem;
  final void Function(WishlistItemModel) onDeleteItem;
  final Future<void> Function(String categoryId, String name) onQuickAdd;

  const _CategorySection({
    required this.categoryId,
    required this.categoryName,
    required this.items,
    required this.isCollapsed,
    required this.onToggleCollapsed,
    required this.onToggleItem,
    required this.onEditItem,
    required this.onDeleteItem,
    required this.onQuickAdd,
  });

  @override
  Widget build(BuildContext context) {
    final uncheckedCount = items.where((i) => !i.checked).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header (tappable to collapse/expand)
        GestureDetector(
          onTap: onToggleCollapsed,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.sm,
            ),
            margin: const EdgeInsets.only(bottom: AppSizes.sm),
            decoration: BoxDecoration(
              color: AppColors.wishlists.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Row(
              children: [
                // Expand/collapse icon
                AnimatedRotation(
                  turns: isCollapsed ? -0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.expand_more,
                    color: AppColors.wishlists,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSizes.xs),
                Expanded(
                  child: Text(
                    categoryName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.wishlists,
                    ),
                  ),
                ),
                if (uncheckedCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.wishlists,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      uncheckedCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Items in this category (animated collapse)
        AnimatedCrossFade(
          firstChild: Column(
            children: [
              ...items.map((item) => _WishlistItemTile(
                    item: item,
                    onToggle: () => onToggleItem(item),
                    onEdit: () => onEditItem(item),
                    onDelete: () => onDeleteItem(item),
                  )),
              // Quick add at the bottom of each category
              _QuickAddItem(
                categoryId: categoryId,
                onAdd: onQuickAdd,
              ),
            ],
          ),
          secondChild: const SizedBox.shrink(),
          crossFadeState:
              isCollapsed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        const SizedBox(height: AppSizes.md),
      ],
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
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSizes.md),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      child: Card(
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
                                    ? colorScheme.onSurface.withValues(alpha: 0.5)
                                    : colorScheme.onSurface,
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
                                ? colorScheme.onSurface.withValues(alpha: 0.4)
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
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

class _OwnerTypeChip extends StatelessWidget {
  final String label;
  final int? count;
  final bool isSelected;
  final VoidCallback onTap;

  const _OwnerTypeChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.wishlists.withValues(alpha: 0.2)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.wishlists
                : colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppColors.wishlists : colorScheme.onSurfaceVariant,
              ),
            ),
            if (count != null && count! > 0) ...[
              const SizedBox(width: 4),
              Text(
                '($count)',
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? AppColors.wishlists.withValues(alpha: 0.8)
                      : colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuickAddItem extends StatefulWidget {
  final String categoryId;
  final Future<void> Function(String categoryId, String name) onAdd;

  const _QuickAddItem({
    required this.categoryId,
    required this.onAdd,
  });

  @override
  State<_QuickAddItem> createState() => _QuickAddItemState();
}

class _QuickAddItemState extends State<_QuickAddItem> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    // Optimistic - fire and forget
    widget.onAdd(widget.categoryId, name);

    _controller.clear();
    // Keep focus for adding another item
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.sm,
          vertical: AppSizes.xs,
        ),
        child: Row(
          children: [
            // Add icon (same position as checkbox)
            const SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                Icons.add_circle_outline,
                color: AppColors.wishlists,
              ),
            ),
            // Text field
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Agregar item...',
                  hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    borderSide: BorderSide.none,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.only(
                    left: AppSizes.sm,
                    top: 12,
                    bottom: 12,
                  ),
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
              ),
            ),
            // Submit button
            IconButton(
              icon: const Icon(Icons.check, size: 20),
              color: AppColors.wishlists,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
