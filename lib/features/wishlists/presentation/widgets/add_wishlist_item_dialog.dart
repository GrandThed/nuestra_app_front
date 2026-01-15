import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/wishlists/data/models/wishlist_model.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_notifier.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_state.dart';

/// Dialog to add or edit a wishlist item
class AddWishlistItemDialog extends ConsumerStatefulWidget {
  final String? categoryId;
  final WishlistItemModel? editingItem;

  const AddWishlistItemDialog({
    super.key,
    this.categoryId,
    this.editingItem,
  });

  @override
  ConsumerState<AddWishlistItemDialog> createState() =>
      _AddWishlistItemDialogState();
}

class _AddWishlistItemDialogState extends ConsumerState<AddWishlistItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _priceController = TextEditingController();

  String? _selectedCategoryId;
  String? _selectedEmoji;
  bool _isLoading = false;

  bool get _isEditing => widget.editingItem != null;


  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.categoryId;

    if (_isEditing) {
      final item = widget.editingItem!;
      _nameController.text = item.name;
      _selectedCategoryId = item.category?.id;
      _selectedEmoji = item.preferenceEmoji;
      if (item.quantity != null) {
        _quantityController.text = item.quantity!.toStringAsFixed(
          item.quantity! == item.quantity!.roundToDouble() ? 0 : 1,
        );
      }
      if (item.unit != null) {
        _unitController.text = item.unit!;
      }
      if (item.price != null) {
        _priceController.text = item.price!.toStringAsFixed(2);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una categoria')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final quantity = _quantityController.text.trim().isNotEmpty
        ? double.tryParse(_quantityController.text.trim())
        : null;
    final price = _priceController.text.trim().isNotEmpty
        ? double.tryParse(_priceController.text.trim())
        : null;
    final unit =
        _unitController.text.trim().isNotEmpty ? _unitController.text.trim() : null;

    dynamic result;

    if (_isEditing) {
      result = await ref.read(wishlistsNotifierProvider.notifier).updateItem(
            id: widget.editingItem!.id,
            name: _nameController.text.trim(),
            categoryId: _selectedCategoryId,
            quantity: quantity,
            unit: unit,
            price: price,
            preferenceEmoji: _selectedEmoji,
          );
    } else {
      result = await ref.read(wishlistsNotifierProvider.notifier).createItem(
            categoryId: _selectedCategoryId!,
            name: _nameController.text.trim(),
            quantity: quantity,
            unit: unit,
            price: price,
            preferenceEmoji: _selectedEmoji,
          );
    }

    setState(() => _isLoading = false);

    if (mounted) {
      if (result != null) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Error al actualizar item' : 'Error al crear item',
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wishlistsNotifierProvider);
    final categories =
        state is WishlistsStateLoaded ? state.categories : <WishlistCategoryModel>[];

    return AlertDialog(
      title: Text(_isEditing ? 'Editar item' : 'Nuevo item'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name field
              TextFormField(
                controller: _nameController,
                autofocus: !_isEditing,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Nombre *',
                  hintText: 'Ej: Leche, Pan...',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.md),

              // Category dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedCategoryId,
                decoration: const InputDecoration(
                  labelText: 'Categoria *',
                ),
                items: categories.map((c) {
                  return DropdownMenuItem(
                    value: c.id,
                    child: Text(c.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCategoryId = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecciona una categoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.md),

              // Quantity and unit row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Cantidad',
                        hintText: '1',
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _unitController,
                      decoration: const InputDecoration(
                        labelText: 'Unidad',
                        hintText: 'kg, lt, un...',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),

              // Price field
              TextFormField(
                controller: _priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Precio estimado',
                  prefixText: '\$ ',
                ),
              ),
              const SizedBox(height: AppSizes.md),

              // Priority emoji selector
              const Text(
                'Prioridad',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSizes.xs),
              Wrap(
                spacing: AppSizes.sm,
                children: [
                  _EmojiChip(
                    emoji: null,
                    label: 'Normal',
                    isSelected: _selectedEmoji == null,
                    onTap: () => setState(() => _selectedEmoji = null),
                  ),
                  _EmojiChip(
                    emoji: '!',
                    label: 'Importante',
                    isSelected: _selectedEmoji == '!',
                    onTap: () => setState(() => _selectedEmoji = '!'),
                  ),
                  _EmojiChip(
                    emoji: '?',
                    label: 'Opcional',
                    isSelected: _selectedEmoji == '?',
                    onTap: () => setState(() => _selectedEmoji = '?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(_isEditing ? 'Guardar' : 'Agregar'),
        ),
      ],
    );
  }
}

class _EmojiChip extends StatelessWidget {
  final String? emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _EmojiChip({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (emoji != null) ...[
            Text(emoji!, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 4),
          ],
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.wishlists.withValues(alpha: 0.2),
      checkmarkColor: AppColors.wishlists,
      showCheckmark: false,
    );
  }
}
