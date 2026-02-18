import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nuestra_app/core/constants/app_colors.dart';
import 'package:nuestra_app/core/constants/app_sizes.dart';
import 'package:nuestra_app/core/router/app_router.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_state.dart';

/// Expandable FAB with quick actions on the home dashboard
class QuickActionsFab extends ConsumerStatefulWidget {
  const QuickActionsFab({super.key});

  @override
  ConsumerState<QuickActionsFab> createState() => _QuickActionsFabState();
}

class _QuickActionsFabState extends ConsumerState<QuickActionsFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _close() {
    if (_isOpen) {
      setState(() {
        _isOpen = false;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 280,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Backdrop to close on tap outside
          if (_isOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _close,
                child: Container(color: Colors.transparent),
              ),
            ),

          // Action buttons
          _buildActionButton(
            index: 2,
            icon: Icons.attach_money,
            label: 'Agregar gasto',
            color: AppColors.expensesDark,
            onTap: () {
              _close();
              context.push(AppRoutes.addExpense);
            },
          ),
          _buildActionButton(
            index: 1,
            icon: Icons.book_outlined,
            label: 'Nueva receta',
            color: AppColors.recipesDark,
            onTap: () {
              _close();
              context.push(AppRoutes.recipeNew);
            },
          ),
          _buildActionButton(
            index: 0,
            icon: Icons.restaurant_menu,
            label: 'Planificar comida',
            color: AppColors.menusDark,
            onTap: () {
              _close();
              _navigateToAddMeal(context);
            },
          ),

          // Main FAB
          FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            child: AnimatedRotation(
              turns: _isOpen ? 0.125 : 0, // 45 degrees
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required int index,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final offset = 70.0 + (index * 56.0);
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _expandAnimation,
      builder: (context, child) {
        return Positioned(
          right: 0,
          bottom: offset * _expandAnimation.value,
          child: Opacity(
            opacity: _expandAnimation.value,
            child: Transform.scale(
              scale: _expandAnimation.value,
              child: child,
            ),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            color: colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sm,
                vertical: AppSizes.xs,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          // Button
          FloatingActionButton.small(
            heroTag: 'fab_action_$index',
            onPressed: onTap,
            backgroundColor: color,
            foregroundColor: Colors.white,
            child: Icon(icon),
          ),
        ],
      ),
    );
  }

  void _navigateToAddMeal(BuildContext context) {
    // Get current menu plan ID or create one
    final menuPlansState = ref.read(menuPlansNotifierProvider);

    if (menuPlansState is MenuPlansStateLoaded && menuPlansState.plans.isNotEmpty) {
      final menuId = menuPlansState.plans.first.id;
      final today = DateTime.now();
      context.push('${AppRoutes.menus}/$menuId/add-meal?date=${today.toIso8601String().split('T').first}');
    } else {
      // Navigate to menus screen to create a plan first
      context.go(AppRoutes.menus);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Crea un plan de menu primero'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
