import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/services/image_picker_service.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';
import 'package:nuestra_app/shared/widgets/app_network_image.dart';

class RecipeFormScreen extends ConsumerStatefulWidget {
  final String? recipeId;

  const RecipeFormScreen({super.key, this.recipeId});

  bool get isEditing => recipeId != null;

  @override
  ConsumerState<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends ConsumerState<RecipeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _servingsController = TextEditingController();
  final _sourceUrlController = TextEditingController();

  List<IngredientModel> _ingredients = [];
  List<String> _instructions = [];
  File? _selectedImage;
  String? _existingImageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _loadExistingRecipe();
    }
  }

  void _loadExistingRecipe() {
    Future.microtask(() {
      final state = ref.read(recipeDetailNotifierProvider(widget.recipeId!));
      if (state is RecipeDetailStateLoaded) {
        _populateForm(state.recipe);
      }
    });
  }

  void _populateForm(RecipeModel recipe) {
    _titleController.text = recipe.title;
    _servingsController.text = recipe.servings?.toString() ?? '';
    _sourceUrlController.text = recipe.sourceUrl ?? '';
    setState(() {
      _ingredients = List.from(recipe.ingredients ?? []);
      _instructions = List.from(recipe.instructions ?? []);
      _existingImageUrl = recipe.imageUrl;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _servingsController.dispose();
    _sourceUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for recipe data when editing
    if (widget.isEditing) {
      final state = ref.watch(recipeDetailNotifierProvider(widget.recipeId!));
      if (state is RecipeDetailStateLoading) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cargando...'),
            backgroundColor: AppColors.recipes,
            foregroundColor: Colors.white,
          ),
          body: const Center(
            child: CircularProgressIndicator(color: AppColors.recipes),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Editar receta' : 'Nueva receta'),
        backgroundColor: AppColors.recipes,
        foregroundColor: Colors.white,
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _saveRecipe,
              child: const Text(
                'Guardar',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.paddingMd),
          children: [
            // Image picker
            _buildImagePicker(),
            const SizedBox(height: AppSizes.lg),

            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título *',
                hintText: 'Nombre de la receta',
                prefixIcon: Icon(Icons.restaurant_menu),
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El título es requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSizes.md),

            // Servings
            TextFormField(
              controller: _servingsController,
              decoration: const InputDecoration(
                labelText: 'Porciones',
                hintText: '4',
                prefixIcon: Icon(Icons.people),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSizes.md),

            // Source URL
            TextFormField(
              controller: _sourceUrlController,
              decoration: const InputDecoration(
                labelText: 'URL de origen',
                hintText: 'https://...',
                prefixIcon: Icon(Icons.link),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: AppSizes.xl),

            // Ingredients section
            _buildIngredientsSection(),
            const SizedBox(height: AppSizes.xl),

            // Instructions section
            _buildInstructionsSection(),
            const SizedBox(height: AppSizes.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: _selectedImage != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(_selectedImage!, fit: BoxFit.cover),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () => setState(() => _selectedImage = null),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black54,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : _existingImageUrl != null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      AppNetworkImage(
                        imageUrl: _existingImageUrl!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          onPressed: () => setState(() => _existingImageUrl = null),
                          icon: const Icon(Icons.close),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black54,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 48,
                        color: AppColors.recipes.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Agregar foto',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ingredientes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: _addIngredient,
              icon: const Icon(Icons.add),
              label: const Text('Agregar'),
              style: TextButton.styleFrom(foregroundColor: AppColors.recipes),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        if (_ingredients.isEmpty)
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: const Center(
              child: Text(
                'No hay ingredientes',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          )
        else
          ...List.generate(_ingredients.length, (index) {
            final ingredient = _ingredients[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.restaurant, color: AppColors.recipes),
                title: Text(ingredient.name),
                subtitle: ingredient.quantity != null || ingredient.unit != null
                    ? Text('${ingredient.quantity?.toString() ?? ''} ${ingredient.unit ?? ''}'.trim())
                    : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () {
                    setState(() {
                      _ingredients.removeAt(index);
                    });
                  },
                ),
                onTap: () => _editIngredient(index),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildInstructionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Instrucciones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: _addInstruction,
              icon: const Icon(Icons.add),
              label: const Text('Agregar'),
              style: TextButton.styleFrom(foregroundColor: AppColors.recipes),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        if (_instructions.isEmpty)
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: const Center(
              child: Text(
                'No hay instrucciones',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          )
        else
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _instructions.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = _instructions.removeAt(oldIndex);
                _instructions.insert(newIndex, item);
              });
            },
            itemBuilder: (context, index) {
              final instruction = _instructions[index];
              return Card(
                key: ValueKey('instruction_$index'),
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.recipes,
                    foregroundColor: Colors.white,
                    radius: 14,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  title: Text(
                    instruction,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
                        onPressed: () => _editInstruction(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.error),
                        onPressed: () {
                          setState(() {
                            _instructions.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final source = await ImagePickerService.showImageSourcePicker(context);
    if (source == null) return;

    final imagePickerService = ImagePickerService();
    final image = await imagePickerService.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = image;
        _existingImageUrl = null;
      });
    }
  }

  void _addIngredient() {
    _showIngredientDialog();
  }

  void _editIngredient(int index) {
    _showIngredientDialog(
      existingIngredient: _ingredients[index],
      index: index,
    );
  }

  void _showIngredientDialog({IngredientModel? existingIngredient, int? index}) {
    final nameController = TextEditingController(text: existingIngredient?.name ?? '');
    final quantityController = TextEditingController(text: existingIngredient?.quantity?.toString() ?? '');
    final unitController = TextEditingController(text: existingIngredient?.unit ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(existingIngredient != null ? 'Editar ingrediente' : 'Agregar ingrediente'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre *',
                hintText: 'Ej: Harina',
              ),
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                      hintText: 'Ej: 250',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: unitController,
                    decoration: const InputDecoration(
                      labelText: 'Unidad',
                      hintText: 'Ej: gr',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isEmpty) return;

              final ingredient = IngredientModel(
                name: name,
                quantity: quantityController.text.trim().isEmpty
                    ? null
                    : double.tryParse(quantityController.text.trim()),
                unit: unitController.text.trim().isEmpty
                    ? null
                    : unitController.text.trim(),
              );

              setState(() {
                if (index != null) {
                  _ingredients[index] = ingredient;
                } else {
                  _ingredients.add(ingredient);
                }
              });

              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.recipes),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _addInstruction() {
    _showInstructionDialog();
  }

  void _editInstruction(int index) {
    _showInstructionDialog(existingInstruction: _instructions[index], index: index);
  }

  void _showInstructionDialog({String? existingInstruction, int? index}) {
    final controller = TextEditingController(text: existingInstruction ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(existingInstruction != null
            ? 'Editar paso ${(index ?? 0) + 1}'
            : 'Agregar paso ${_instructions.length + 1}'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Instrucción',
            hintText: 'Describe el paso...',
          ),
          textCapitalization: TextCapitalization.sentences,
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return;

              setState(() {
                if (index != null) {
                  _instructions[index] = text;
                } else {
                  _instructions.add(text);
                }
              });

              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.recipes),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveRecipe() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final servings = int.tryParse(_servingsController.text.trim());
      final sourceUrl = _sourceUrlController.text.trim().isEmpty
          ? null
          : _sourceUrlController.text.trim();

      RecipeModel? result;

      if (widget.isEditing) {
        result = await ref.read(recipeDetailNotifierProvider(widget.recipeId!).notifier).updateRecipe(
              title: _titleController.text.trim(),
              ingredients: _ingredients.isEmpty ? null : _ingredients,
              instructions: _instructions.isEmpty ? null : _instructions,
              servings: servings,
              sourceUrl: sourceUrl,
              image: _selectedImage,
            );
      } else {
        result = await ref.read(recipesNotifierProvider.notifier).createRecipe(
              title: _titleController.text.trim(),
              ingredients: _ingredients.isEmpty ? null : _ingredients,
              instructions: _instructions.isEmpty ? null : _instructions,
              servings: servings,
              sourceUrl: sourceUrl,
              image: _selectedImage,
            );
      }

      if (mounted) {
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.isEditing ? 'Receta actualizada' : 'Receta creada'),
              backgroundColor: AppColors.success,
            ),
          );
          context.pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al guardar la receta'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
