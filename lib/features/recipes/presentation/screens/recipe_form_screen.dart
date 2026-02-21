import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/services/image_picker_service.dart';
import 'package:nuestra_app/core/utils/file_utils.dart';
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

  // Inline ingredient input controllers
  final _ingredientNameController = TextEditingController();
  final _ingredientQuantityController = TextEditingController();
  final _ingredientUnitController = TextEditingController();

  // FocusNodes for ingredient field navigation
  final _ingredientNameFocus = FocusNode();
  final _ingredientQuantityFocus = FocusNode();
  FocusNode? _ingredientUnitFocus;

  // Inline instruction input controller
  final _instructionController = TextEditingController();

  List<IngredientModel> _ingredients = [];
  List<String> _instructions = [];
  File? _selectedImage;
  String? _existingImageUrl;
  bool _isLoading = false;

  // Index for editing existing items (-1 means adding new)
  int _editingIngredientIndex = -1;
  int _editingInstructionIndex = -1;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _loadExistingRecipe();
    }
  }

  void _loadExistingRecipe() {
    Future.microtask(() {
      final state = ref.read(recipeDetailProvider(widget.recipeId!));
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
    _ingredientNameController.dispose();
    _ingredientQuantityController.dispose();
    _ingredientUnitController.dispose();
    _ingredientNameFocus.dispose();
    _ingredientQuantityFocus.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for recipe data when editing
    if (widget.isEditing) {
      final state = ref.watch(recipeDetailProvider(widget.recipeId!));
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
                  fileImage(_selectedImage!.path, fit: BoxFit.cover),
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
        const Text(
          'Ingredientes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.sm),

        // List of existing ingredients
        if (_ingredients.isNotEmpty)
          ...List.generate(_ingredients.length, (index) {
            final ingredient = _ingredients[index];
            final isEditing = _editingIngredientIndex == index;

            if (isEditing) {
              // Inline editing mode
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.recipes.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  border: Border.all(color: AppColors.recipes),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _ingredientNameController,
                            decoration: const InputDecoration(
                              hintText: 'Ingrediente',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: _ingredientQuantityController,
                            decoration: const InputDecoration(
                              hintText: 'Cant.',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Autocomplete<String>(
                            optionsBuilder: (textEditingValue) {
                              return _getUnitSuggestions(textEditingValue.text);
                            },
                            onSelected: (selection) {
                              _ingredientUnitController.text = selection;
                            },
                            initialValue: TextEditingValue(text: _ingredientUnitController.text),
                            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  hintText: 'Unidad',
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  border: OutlineInputBorder(),
                                ),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) {
                                  _ingredientUnitController.text = controller.text;
                                  onFieldSubmitted();
                                  _saveIngredientEdit();
                                },
                                onChanged: (value) {
                                  _ingredientUnitController.text = value;
                                },
                              );
                            },
                            optionsViewBuilder: (context, onSelected, options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(8),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 200, maxWidth: 150),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: options.length,
                                      itemBuilder: (context, index) {
                                        final option = options.elementAt(index);
                                        return ListTile(
                                          dense: true,
                                          title: Text(option),
                                          onTap: () => onSelected(option),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _cancelIngredientEdit,
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _saveIngredientEdit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.recipes,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('Guardar'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            // Display mode
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                dense: true,
                title: Text(ingredient.name),
                subtitle: ingredient.quantity != null || ingredient.unit != null
                    ? Text('${ingredient.quantity?.toString() ?? ''} ${ingredient.unit ?? ''}'.trim())
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: () => _startEditingIngredient(index),
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20, color: AppColors.error),
                      onPressed: () {
                        setState(() {
                          _ingredients.removeAt(index);
                        });
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
            );
          }),

        // Inline input for new ingredient (only show when not editing an existing one)
        if (_editingIngredientIndex == -1) ...[
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _ingredientNameController,
                  focusNode: _ingredientNameFocus,
                  decoration: const InputDecoration(
                    hintText: 'Ingrediente',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _ingredientQuantityFocus.requestFocus(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _ingredientQuantityController,
                  focusNode: _ingredientQuantityFocus,
                  decoration: const InputDecoration(
                    hintText: 'Cant.',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => _ingredientUnitFocus?.requestFocus(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Autocomplete<String>(
                  optionsBuilder: (textEditingValue) {
                    return _getUnitSuggestions(textEditingValue.text);
                  },
                  onSelected: (selection) {
                    _ingredientUnitController.text = selection;
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    // Store reference to Autocomplete's focus node
                    _ingredientUnitFocus = focusNode;
                    // Sync with our controller
                    if (controller.text != _ingredientUnitController.text) {
                      controller.text = _ingredientUnitController.text;
                    }
                    _ingredientUnitController.addListener(() {
                      if (controller.text != _ingredientUnitController.text) {
                        controller.text = _ingredientUnitController.text;
                      }
                    });
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Unidad',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        _ingredientUnitController.text = controller.text;
                        onFieldSubmitted();
                        _addIngredient();
                      },
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 200, maxWidth: 150),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);
                              return ListTile(
                                dense: true,
                                title: Text(option),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _addIngredient,
              icon: const Icon(Icons.add),
              label: const Text('Agregar ingrediente'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.recipes,
                side: const BorderSide(color: AppColors.recipes),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInstructionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Instrucciones',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.sm),

        // List of existing instructions
        if (_instructions.isNotEmpty)
          ...List.generate(_instructions.length, (index) {
            final instruction = _instructions[index];
            final isEditing = _editingInstructionIndex == index;

            if (isEditing) {
              // Inline editing mode
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.recipes.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  border: Border.all(color: AppColors.recipes),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.recipes,
                          foregroundColor: Colors.white,
                          radius: 14,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _instructionController,
                            decoration: const InputDecoration(
                              hintText: 'Describe el paso...',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 3,
                            minLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _cancelInstructionEdit,
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _saveInstructionEdit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.recipes,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('Guardar'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            // Display mode
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                dense: true,
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
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: () => _startEditingInstruction(index),
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20, color: AppColors.error),
                      onPressed: () {
                        setState(() {
                          _instructions.removeAt(index);
                        });
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
            );
          }),

        // Inline input for new instruction (only show when not editing an existing one)
        if (_editingInstructionIndex == -1) ...[
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.recipes.withValues(alpha: 0.3),
                foregroundColor: Colors.white,
                radius: 14,
                child: Text(
                  '${_instructions.length + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _instructionController,
                  decoration: const InputDecoration(
                    hintText: 'Describe el paso...',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                  minLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _addInstruction,
              icon: const Icon(Icons.add),
              label: const Text('Agregar paso'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.recipes,
                side: const BorderSide(color: AppColors.recipes),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _pickImage() async {
    final choice = await ImagePickerService.showImageSourcePicker(
      context,
      allowMultiple: false,
    );
    if (choice == null) return;

    final imagePickerService = ImagePickerService();
    final source = choice == ImagePickerChoice.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    final image = await imagePickerService.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = image;
        _existingImageUrl = null;
      });
    }
  }

  // Ingredient inline methods
  void _addIngredient() {
    final name = _ingredientNameController.text.trim();
    if (name.isEmpty) return;

    final ingredient = IngredientModel(
      name: name,
      quantity: _ingredientQuantityController.text.trim().isEmpty
          ? null
          : double.tryParse(_ingredientQuantityController.text.trim()),
      unit: _ingredientUnitController.text.trim().isEmpty
          ? null
          : _ingredientUnitController.text.trim(),
    );

    setState(() {
      _ingredients.add(ingredient);
    });

    _clearIngredientFields();
    _ingredientNameFocus.requestFocus();
  }

  void _startEditingIngredient(int index) {
    final ingredient = _ingredients[index];
    _ingredientNameController.text = ingredient.name;
    _ingredientQuantityController.text = ingredient.quantity?.toString() ?? '';
    _ingredientUnitController.text = ingredient.unit ?? '';
    setState(() {
      _editingIngredientIndex = index;
    });
  }

  void _saveIngredientEdit() {
    final name = _ingredientNameController.text.trim();
    if (name.isEmpty) return;

    final ingredient = IngredientModel(
      name: name,
      quantity: _ingredientQuantityController.text.trim().isEmpty
          ? null
          : double.tryParse(_ingredientQuantityController.text.trim()),
      unit: _ingredientUnitController.text.trim().isEmpty
          ? null
          : _ingredientUnitController.text.trim(),
    );

    setState(() {
      _ingredients[_editingIngredientIndex] = ingredient;
      _editingIngredientIndex = -1;
    });

    _clearIngredientFields();
  }

  void _cancelIngredientEdit() {
    setState(() {
      _editingIngredientIndex = -1;
    });
    _clearIngredientFields();
  }

  void _clearIngredientFields() {
    _ingredientNameController.clear();
    _ingredientQuantityController.clear();
    _ingredientUnitController.clear();
  }

  /// Returns unit suggestions ordered by relevance based on quantity
  List<String> _getUnitSuggestions(String query) {
    final quantity = double.tryParse(_ingredientQuantityController.text.trim());

    // Base units list
    final List<String> allUnits = [
      'gr', 'kg', 'ml', 'l', 'unidad', 'unidades',
      'paquete', 'paquetes', 'taza', 'tazas',
      'cucharada', 'cucharadas', 'cucharadita', 'cucharaditas',
      'diente', 'dientes', 'rodaja', 'rodajas',
      'pizca', 'pizcas', 'puñado', 'puñados',
    ];

    // Smart ordering based on quantity
    List<String> orderedUnits;
    if (quantity != null && quantity > 10) {
      // For quantities > 10, suggest gramos first
      orderedUnits = ['gr', 'ml', 'unidades', 'paquetes', 'kg', 'l', ...allUnits];
    } else if (quantity != null && quantity <= 9) {
      // For quantities <= 9, suggest paquetes, kilos first
      orderedUnits = ['paquete', 'paquetes', 'kg', 'unidad', 'unidades', 'l', 'taza', 'tazas', ...allUnits];
    } else {
      orderedUnits = allUnits;
    }

    // Remove duplicates while preserving order
    final seen = <String>{};
    orderedUnits = orderedUnits.where((unit) => seen.add(unit)).toList();

    // Filter by query if provided
    if (query.isEmpty) {
      return orderedUnits.take(8).toList();
    }

    return orderedUnits
        .where((unit) => unit.toLowerCase().contains(query.toLowerCase()))
        .take(8)
        .toList();
  }

  // Instruction inline methods
  void _addInstruction() {
    final text = _instructionController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _instructions.add(text);
    });

    _instructionController.clear();
  }

  void _startEditingInstruction(int index) {
    _instructionController.text = _instructions[index];
    setState(() {
      _editingInstructionIndex = index;
    });
  }

  void _saveInstructionEdit() {
    final text = _instructionController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _instructions[_editingInstructionIndex] = text;
      _editingInstructionIndex = -1;
    });

    _instructionController.clear();
  }

  void _cancelInstructionEdit() {
    setState(() {
      _editingInstructionIndex = -1;
    });
    _instructionController.clear();
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
        result = await ref.read(recipeDetailProvider(widget.recipeId!).notifier).updateRecipe(
              title: _titleController.text.trim(),
              ingredients: _ingredients.isEmpty ? null : _ingredients,
              instructions: _instructions.isEmpty ? null : _instructions,
              servings: servings,
              sourceUrl: sourceUrl,
              image: _selectedImage,
            );
      } else {
        result = await ref.read(recipesProvider.notifier).createRecipe(
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
