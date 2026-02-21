import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Dark background color for cooking mode (easy to read in a kitchen).
const _kCookingBg = Color(0xFF1A1A2E);

/// Slightly lighter surface for cards/panels in cooking mode.
const _kCookingSurface = Color(0xFF222244);

/// Accent color used for buttons and active indicators.
const _kCookingAccent = AppColors.recipes;

/// Text color on the dark background.
const _kCookingText = Color(0xFFF0F0F0);

/// Dimmed text for secondary information.
const _kCookingTextDim = Color(0xFFA0A0B0);

/// Minimum tap target size for wet/messy hands.
const _kMinTapTarget = 56.0;

class CookingModeScreen extends ConsumerStatefulWidget {
  final String recipeId;

  const CookingModeScreen({super.key, required this.recipeId});

  @override
  ConsumerState<CookingModeScreen> createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends ConsumerState<CookingModeScreen> {
  late final PageController _pageController;
  int _currentPage = 0;
  int _servingMultiplier = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Keep screen on while cooking
    WakelockPlus.enable();

    // Force dark status bar for immersive experience
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Load recipe if needed
    Future.microtask(() {
      ref
          .read(recipeDetailProvider(widget.recipeId).notifier)
          .loadRecipeIfNeeded();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String _formatQuantity(double quantity) {
    final scaled = quantity * _servingMultiplier;
    // Show as integer if it's a whole number
    if (scaled == scaled.roundToDouble()) {
      return scaled.toInt().toString();
    }
    // Otherwise show one decimal place
    return scaled.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeDetailProvider(widget.recipeId));

    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _kCookingBg,
        appBarTheme: const AppBarTheme(
          backgroundColor: _kCookingBg,
          foregroundColor: _kCookingText,
          elevation: 0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Modo Cocina',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.fontLg,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close, size: 28),
              tooltip: 'Cerrar',
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: AppSizes.sm),
          ],
        ),
        body: switch (state) {
          RecipeDetailStateInitial() => const Center(
              child: CircularProgressIndicator(color: _kCookingAccent),
            ),
          RecipeDetailStateLoading() => const Center(
              child: CircularProgressIndicator(color: _kCookingAccent),
            ),
          RecipeDetailStateError(:final message) =>
            _buildErrorState(message),
          RecipeDetailStateLoaded(:final recipe) =>
            _buildCookingContent(context, recipe),
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: AppSizes.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _kCookingText, fontSize: AppSizes.fontMd),
            ),
            const SizedBox(height: AppSizes.lg),
            SizedBox(
              height: _kMinTapTarget,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kCookingAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingXl),
                ),
                onPressed: () {
                  ref
                      .read(recipeDetailProvider(widget.recipeId).notifier)
                      .loadRecipe();
                },
                child: const Text('Reintentar', style: TextStyle(fontSize: AppSizes.fontMd)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCookingContent(BuildContext context, RecipeModel recipe) {
    final instructions = recipe.instructions ?? [];
    final totalSteps = instructions.length;

    if (totalSteps == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_menu,
                size: 64,
                color: _kCookingTextDim,
              ),
              const SizedBox(height: AppSizes.lg),
              const Text(
                'Esta receta no tiene instrucciones',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _kCookingText,
                  fontSize: AppSizes.fontXl,
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              if (recipe.ingredients != null && recipe.ingredients!.isNotEmpty)
                _buildIngredientsCard(recipe),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Step counter
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd,
            vertical: AppSizes.paddingSm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Paso ${_currentPage + 1} de $totalSteps',
                style: const TextStyle(
                  color: _kCookingAccent,
                  fontSize: AppSizes.fontLg,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Ingredients floating button
              if (recipe.ingredients != null && recipe.ingredients!.isNotEmpty)
                SizedBox(
                  height: _kMinTapTarget,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kCookingSurface,
                      foregroundColor: _kCookingText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                        side: const BorderSide(color: _kCookingAccent, width: 1),
                      ),
                    ),
                    icon: const Icon(Icons.restaurant, size: 20),
                    label: const Text('Ingredientes'),
                    onPressed: () => _showIngredientsSheet(context, recipe),
                  ),
                ),
            ],
          ),
        ),

        // PageView with instruction steps
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: totalSteps,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
            itemBuilder: (context, index) {
              return _buildStepPage(
                stepNumber: index + 1,
                totalSteps: totalSteps,
                instruction: instructions[index],
              );
            },
          ),
        ),

        // Navigation dots
        if (totalSteps > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.sm),
            child: _buildDots(totalSteps),
          ),

        // Navigation buttons
        _buildNavigationButtons(totalSteps),

        const SizedBox(height: AppSizes.md),
      ],
    );
  }

  Widget _buildStepPage({
    required int stepNumber,
    required int totalSteps,
    required String instruction,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLg,
        vertical: AppSizes.paddingMd,
      ),
      child: Column(
        children: [
          // Step number badge
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: _kCookingAccent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.fontXxl,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.xl),

          // Instruction text
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  instruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _kCookingText,
                    fontSize: 22,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots(int totalSteps) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? _kCookingAccent : _kCookingTextDim.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons(int totalSteps) {
    final isFirstStep = _currentPage == 0;
    final isLastStep = _currentPage == totalSteps - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd),
      child: Row(
        children: [
          // Previous button
          Expanded(
            child: SizedBox(
              height: _kMinTapTarget,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: isFirstStep
                      ? _kCookingTextDim.withValues(alpha: 0.4)
                      : _kCookingText,
                  side: BorderSide(
                    color: isFirstStep
                        ? _kCookingTextDim.withValues(alpha: 0.2)
                        : _kCookingTextDim,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                onPressed: isFirstStep
                    ? null
                    : () => _goToPage(_currentPage - 1),
                icon: const Icon(Icons.arrow_back, size: 20),
                label: const Text(
                  'Anterior',
                  style: TextStyle(fontSize: AppSizes.fontMd),
                ),
              ),
            ),
          ),

          const SizedBox(width: AppSizes.md),

          // Next button
          Expanded(
            child: SizedBox(
              height: _kMinTapTarget,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLastStep
                      ? AppColors.success
                      : _kCookingAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                onPressed: isLastStep
                    ? () => Navigator.of(context).pop()
                    : () => _goToPage(_currentPage + 1),
                icon: Icon(
                  isLastStep ? Icons.check : Icons.arrow_forward,
                  size: 20,
                ),
                label: Text(
                  isLastStep ? 'Finalizar' : 'Siguiente',
                  style: const TextStyle(fontSize: AppSizes.fontMd),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsCard(RecipeModel recipe) {
    final ingredients = recipe.ingredients ?? [];
    if (ingredients.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      decoration: BoxDecoration(
        color: _kCookingSurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ingredientes',
            style: TextStyle(
              color: _kCookingAccent,
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.md),
          ...ingredients.map(
            (ingredient) => _buildIngredientRow(ingredient),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientRow(IngredientModel ingredient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
              color: _kCookingAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: _kCookingText,
                  fontSize: AppSizes.fontLg,
                  height: 1.4,
                ),
                children: [
                  if (ingredient.quantity != null)
                    TextSpan(
                      text: '${_formatQuantity(ingredient.quantity!)} ',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  if (ingredient.unit != null)
                    TextSpan(
                      text: '${ingredient.unit} ',
                      style: const TextStyle(color: _kCookingTextDim),
                    ),
                  TextSpan(text: ingredient.name),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showIngredientsSheet(BuildContext context, RecipeModel recipe) {
    final ingredients = recipe.ingredients ?? [];
    if (ingredients.isEmpty) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: _kCookingBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLg),
        ),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (builderContext, setSheetState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              expand: false,
              builder: (_, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle bar
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: AppSizes.md),
                          decoration: BoxDecoration(
                            color: _kCookingTextDim.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      // Title row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ingredientes',
                            style: TextStyle(
                              color: _kCookingAccent,
                              fontSize: AppSizes.fontXxl,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: _kCookingText),
                            onPressed: () => Navigator.of(sheetContext).pop(),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.sm),

                      // Serving multiplier
                      _buildMultiplierSelector(setSheetState, recipe),

                      const SizedBox(height: AppSizes.md),

                      // Ingredients list
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: ingredients.length,
                          itemBuilder: (_, index) {
                            return _buildIngredientRow(ingredients[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildMultiplierSelector(
    void Function(void Function()) setSheetState,
    RecipeModel recipe,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.servings != null
              ? 'Porciones: ${recipe.servings! * _servingMultiplier}'
              : 'Multiplicador',
          style: const TextStyle(
            color: _kCookingTextDim,
            fontSize: AppSizes.fontMd,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Row(
          children: [1, 2, 3, 4].map((multiplier) {
            final isSelected = _servingMultiplier == multiplier;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  height: _kMinTapTarget,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? _kCookingAccent
                          : _kCookingSurface,
                      foregroundColor: isSelected
                          ? Colors.white
                          : _kCookingText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        side: BorderSide(
                          color: isSelected
                              ? _kCookingAccent
                              : _kCookingTextDim.withValues(alpha: 0.3),
                        ),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      // Update parent state and bottom sheet state
                      setState(() => _servingMultiplier = multiplier);
                      setSheetState(() {});
                    },
                    child: Text(
                      '${multiplier}x',
                      style: TextStyle(
                        fontSize: AppSizes.fontLg,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
