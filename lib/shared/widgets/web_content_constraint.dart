import 'package:flutter/material.dart';
import 'package:nuestra_app/core/utils/responsive.dart';

/// Constrains content to [Breakpoints.maxContentWidth] on wide screens.
/// On compact screens, returns the child unchanged.
class WebContentConstraint extends StatelessWidget {
  final Widget child;

  const WebContentConstraint({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (context.isCompact) return child;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.maxContentWidth,
        ),
        child: child,
      ),
    );
  }
}
