import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/constants/app_strings.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/core/utils/responsive.dart';
import 'package:nuestra_app/shared/widgets/more_drawer.dart';

/// A top-level destination in the shell navigation.
class _Destination {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;

  const _Destination(this.icon, this.selectedIcon, this.label, this.route);
}

const _destinations = [
  _Destination(
    Icons.account_balance_wallet_outlined,
    Icons.account_balance_wallet,
    AppStrings.expenses,
    AppRoutes.expenses,
  ),
  _Destination(Icons.restaurant_menu_outlined, Icons.restaurant_menu, 'Comida', AppRoutes.food),
  _Destination(Icons.auto_awesome_outlined, Icons.auto_awesome, AppStrings.assistant, AppRoutes.chat),
];

/// Switch tab. Bottom sheets and dialogs opened in the current tab are
/// closed first, so they don't stay over (or come back on) the next tab.
void _goToTab(BuildContext context, int index) {
  // The last item is "Más": it opens the drawer instead of a tab
  if (index >= _destinations.length) {
    Scaffold.of(context).openEndDrawer();
    return;
  }
  for (final navigator in [shellNavigatorKey.currentState, rootNavigatorKey.currentState]) {
    navigator?.popUntil((route) => route.settings is Page);
  }
  context.go(_destinations[index].route);
}

int _selectedIndex(String location) {
  final index = _destinations.indexWhere((d) => location.startsWith(d.route));
  return index < 0 ? 0 : index;
}

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
      return Scaffold(body: child, bottomNavigationBar: const _BottomNavBar(), endDrawer: const MoreDrawer());
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
      endDrawer: const MoreDrawer(),
      body: Row(
        children: [
          Builder(
            builder: (context) => NavigationRail(
              extended: isExpanded,
              selectedIndex: _selectedIndex(location),
              onDestinationSelected: (index) => _goToTab(context, index),
              labelType: isExpanded ? NavigationRailLabelType.none : NavigationRailLabelType.all,
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                  ),
                const NavigationRailDestination(icon: Icon(Icons.menu), label: Text('Más')),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: Breakpoints.maxShellContentWidth),
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
          style: theme.elevatedButtonTheme.style?.copyWith(minimumSize: const WidgetStatePropertyAll(btnSize)),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: theme.outlinedButtonTheme.style?.copyWith(minimumSize: const WidgetStatePropertyAll(btnSize)),
        ),
      ),
      child: child,
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return NavigationBar(
      selectedIndex: _selectedIndex(location),
      onDestinationSelected: (index) => _goToTab(context, index),
      destinations: [
        for (final d in _destinations)
          NavigationDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selectedIcon), label: d.label),
        const NavigationDestination(icon: Icon(Icons.menu), label: 'Más'),
      ],
    );
  }
}
