import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/core/utils/responsive.dart';

/// Main shell widget with adaptive navigation:
/// - Compact (<600dp): bottom NavigationBar
/// - Medium (600–840dp): NavigationRail (icons only)
/// - Expanded (>840dp): NavigationRail with extended labels
class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isCompact = context.isCompact;

    if (isCompact) {
      return Scaffold(body: child, bottomNavigationBar: const _BottomNavBar());
    }

    return _WideLayout(child: child);
  }
}

/// Layout for medium and expanded screens using NavigationRail.
class _WideLayout extends StatelessWidget {
  final Widget child;

  const _WideLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isExpanded = context.isExpanded;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            selectedIndex: _getSelectedIndex(location),
            onDestinationSelected: (index) => _onItemTapped(context, index),
            labelType: isExpanded
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text(AppStrings.home),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text(AppStrings.boards),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.restaurant_menu_outlined),
                selectedIcon: Icon(Icons.restaurant_menu),
                label: Text(AppStrings.recipes),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.auto_awesome_outlined),
                selectedIcon: Icon(Icons.auto_awesome),
                label: Text(AppStrings.assistant),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.checklist_outlined),
                selectedIcon: Icon(Icons.checklist),
                label: Text(AppStrings.wishlists),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet),
                label: Text(AppStrings.expenses),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: Text(AppStrings.calendar),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: Breakpoints.maxShellContentWidth,
                ),
                child: _wideButtonTheme(context, child),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Override button theme so buttons don't stretch full-width on wide screens.
  Widget _wideButtonTheme(BuildContext context, Widget child) {
    final theme = Theme.of(context);
    const btnSize = Size(0, AppSizes.buttonHeight);
    return Theme(
      data: theme.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: theme.elevatedButtonTheme.style?.copyWith(
            minimumSize: const WidgetStatePropertyAll(btnSize),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: theme.outlinedButtonTheme.style?.copyWith(
            minimumSize: const WidgetStatePropertyAll(btnSize),
          ),
        ),
      ),
      child: child,
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith(AppRoutes.boards)) return 1;
    if (location.startsWith(AppRoutes.recipes)) return 2;
    if (location.startsWith(AppRoutes.chat)) return 3;
    if (location.startsWith(AppRoutes.wishlists)) return 4;
    if (location.startsWith(AppRoutes.expenses)) return 5;
    if (location.startsWith(AppRoutes.calendar)) return 6;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.boards);
      case 2:
        context.go(AppRoutes.recipes);
      case 3:
        context.go(AppRoutes.chat);
      case 4:
        context.go(AppRoutes.wishlists);
      case 5:
        context.go(AppRoutes.expenses);
      case 6:
        context.go(AppRoutes.calendar);
    }
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return NavigationBar(
      selectedIndex: _getSelectedIndex(location),
      onDestinationSelected: (index) => _onItemTapped(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: AppStrings.home,
        ),
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: AppStrings.boards,
        ),
        NavigationDestination(
          icon: Icon(Icons.auto_awesome_outlined),
          selectedIcon: Icon(Icons.auto_awesome),
          label: AppStrings.assistant,
        ),
        NavigationDestination(
          icon: Icon(Icons.checklist_outlined),
          selectedIcon: Icon(Icons.checklist),
          label: AppStrings.wishlists,
        ),
        NavigationDestination(
          icon: Icon(Icons.account_balance_wallet_outlined),
          selectedIcon: Icon(Icons.account_balance_wallet),
          label: AppStrings.expenses,
        ),
      ],
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith(AppRoutes.boards)) return 1;
    if (location.startsWith(AppRoutes.chat)) return 2;
    if (location.startsWith(AppRoutes.wishlists)) return 3;
    if (location.startsWith(AppRoutes.expenses)) return 4;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.boards);
      case 2:
        context.go(AppRoutes.chat);
      case 3:
        context.go(AppRoutes.wishlists);
      case 4:
        context.go(AppRoutes.expenses);
    }
  }
}
