import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/features/food/presentation/menu_tab.dart';
import 'package:nuestra_app/features/food/presentation/preferences_tab.dart';
import 'package:nuestra_app/features/food/presentation/recipes_tab.dart';

/// Comida: weekly menu, recipes and the household's food preferences.
class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _FoodAppBar(),
        body: TabBarView(children: [MenuTab(), RecipesTab(), PreferencesTab()]),
      ),
    );
  }
}

class _FoodAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _FoodAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Comida'),
      bottom: const TabBar(
        tabs: [Tab(text: 'Menú'), Tab(text: 'Recetas'), Tab(text: 'Preferencias')],
      ),
    );
  }
}
