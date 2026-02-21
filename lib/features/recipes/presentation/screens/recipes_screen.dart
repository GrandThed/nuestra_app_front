import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/features/recipes/data/models/recipe_model.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_state.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/shared/widgets/app_network_image.dart';

class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});

  @override
  ConsumerState<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends ConsumerState<RecipesScreen> {
  final _searchController = TextEditingController();
  String? _selectedSeason;
  bool _showFavoritesOnly = false;
  int? _maxPrepTime;
  int? _maxCookTime;

  static const _seasons = ['Primavera', 'Verano', 'Oto\u00f1o', 'Invierno'];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(recipesProvider.notifier).loadRecipesIfNeeded();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    ref.read(recipesProvider.notifier).loadRecipes(
          search: _searchController.text.isEmpty ? null : _searchController.text,
          season: _selectedSeason,
          favorites: _showFavoritesOnly ? true : null,
          maxPrepTime: _maxPrepTime,
          maxCookTime: _maxCookTime,
        );
  }

  void _onSeasonChanged(String? season) {
    setState(() {
      _selectedSeason = season;
    });
    _onSearch();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipesProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas'),
        backgroundColor: AppColors.recipesDark,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.eco_outlined),
            tooltip: 'Verduras de temporada',
            onPressed: () => context.push(AppRoutes.seasonalVegetables),
          ),
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoritesOnly ? Colors.red : Colors.white,
            ),
            tooltip: 'Favoritas',
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
              _onSearch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: colorScheme.surface,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar recetas...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearch();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.recipes, width: 2),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
              ),
              onSubmitted: (_) => _onSearch(),
            ),
          ),

          // Active filter chips
          if (_selectedSeason != null || _maxPrepTime != null || _maxCookTime != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: colorScheme.surface,
              child: Row(
                children: [
                  if (_selectedSeason != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(_selectedSeason!),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => _onSeasonChanged(null),
                        backgroundColor: AppColors.recipes.withValues(alpha: 0.1),
                        labelStyle: const TextStyle(color: AppColors.recipes),
                        deleteIconColor: AppColors.recipes,
                      ),
                    ),
                  if (_maxPrepTime != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text('Prep < $_maxPrepTime min'),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() {
                            _maxPrepTime = null;
                          });
                          _onSearch();
                        },
                        backgroundColor: AppColors.recipes.withValues(alpha: 0.1),
                        labelStyle: const TextStyle(color: AppColors.recipes),
                        deleteIconColor: AppColors.recipes,
                      ),
                    ),
                  if (_maxCookTime != null)
                    Chip(
                      label: Text('Cocci\u00f3n < $_maxCookTime min'),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () {
                        setState(() {
                          _maxCookTime = null;
                        });
                        _onSearch();
                      },
                      backgroundColor: AppColors.recipes.withValues(alpha: 0.1),
                      labelStyle: const TextStyle(color: AppColors.recipes),
                      deleteIconColor: AppColors.recipes,
                    ),
                ],
              ),
            ),

          // Content
          Expanded(
            child: switch (state) {
              RecipesStateInitial() => const Center(
                  child: Text('Cargando recetas...'),
                ),
              RecipesStateLoading() => const Center(
                  child: CircularProgressIndicator(color: AppColors.recipes),
                ),
              RecipesStateError(:final message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                      const SizedBox(height: 16),
                      Text(message, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(recipesProvider.notifier).loadRecipes(),
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              RecipesStateLoaded(:final recipes) => recipes.isEmpty
                  ? _buildEmptyState()
                  : _buildRecipesList(recipes),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/recipes/new'),
        backgroundColor: AppColors.recipesDark,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
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
            Icons.restaurant_menu,
            size: 80,
            color: AppColors.recipes.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay recetas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega tu primera receta',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesList(List<RecipeModel> recipes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return _RecipeCard(
          key: ValueKey(recipe.id),
          recipe: recipe,
          onTap: () => context.push('/recipes/${recipe.id}'),
          onDelete: () => _confirmDelete(recipe),
        );
      },
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filtrar por temporada',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Todas'),
                    selected: _selectedSeason == null,
                    onSelected: (_) {
                      Navigator.pop(context);
                      _onSeasonChanged(null);
                    },
                    selectedColor: AppColors.recipes.withValues(alpha: 0.2),
                    checkmarkColor: AppColors.recipes,
                  ),
                  ..._seasons.map((season) => FilterChip(
                        label: Text(season),
                        selected: _selectedSeason == season,
                        onSelected: (_) {
                          Navigator.pop(context);
                          _onSeasonChanged(season);
                        },
                        selectedColor: AppColors.recipes.withValues(alpha: 0.2),
                        checkmarkColor: AppColors.recipes,
                      )),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Filtrar por tiempo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('< 30 min'),
                    selected: _maxPrepTime == 30 && _maxCookTime == 30,
                    onSelected: (selected) {
                      Navigator.pop(context);
                      setState(() {
                        if (selected) {
                          _maxPrepTime = 30;
                          _maxCookTime = 30;
                        } else {
                          _maxPrepTime = null;
                          _maxCookTime = null;
                        }
                      });
                      _onSearch();
                    },
                    selectedColor: AppColors.recipes.withValues(alpha: 0.2),
                  ),
                  ChoiceChip(
                    label: const Text('< 60 min'),
                    selected: _maxPrepTime == 60 && _maxCookTime == 60,
                    onSelected: (selected) {
                      Navigator.pop(context);
                      setState(() {
                        if (selected) {
                          _maxPrepTime = 60;
                          _maxCookTime = 60;
                        } else {
                          _maxPrepTime = null;
                          _maxCookTime = null;
                        }
                      });
                      _onSearch();
                    },
                    selectedColor: AppColors.recipes.withValues(alpha: 0.2),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(RecipeModel recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar receta'),
        content: Text('\u00bfSeguro que quieres eliminar "${recipe.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(recipesProvider.notifier).deleteRecipe(recipe.id);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Recipe image with favorite indicator
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  recipe.imageUrl != null
                      ? AppNetworkImage(
                          imageUrl: recipe.imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: AppColors.recipes.withValues(alpha: 0.1),
                          child: const Icon(
                            Icons.restaurant,
                            size: 40,
                            color: AppColors.recipes,
                          ),
                        ),
                  if (recipe.isFavorite)
                    const Positioned(
                      top: 6,
                      right: 6,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                ],
              ),
            ),

            // Recipe info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (recipe.servings != null)
                      Row(
                        children: [
                          Icon(Icons.people, size: 16, color: colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.servings} porciones',
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    if (recipe.ingredients != null && recipe.ingredients!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${recipe.ingredients!.length} ingredientes',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    if (recipe.averageRating != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 3),
                            Text(
                              recipe.averageRating!.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Delete button
            IconButton(
              icon: Icon(Icons.delete_outline, color: colorScheme.onSurfaceVariant),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
