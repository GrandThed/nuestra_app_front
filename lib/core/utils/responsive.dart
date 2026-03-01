import 'package:flutter/material.dart';

/// Material 3 window size class breakpoints.
class Breakpoints {
  Breakpoints._();

  /// Compact: phones in portrait (< 600dp)
  static const double compact = 600;

  /// Medium: tablets, foldables (600–840dp)
  static const double medium = 840;

  /// Expanded: large tablets, desktops (> 840dp)
  static const double expanded = 1200;

  /// Maximum content width for detail screens
  static const double maxContentWidth = 840;

  /// Maximum content width for shell screens (needs room for grids)
  static const double maxShellContentWidth = 960;
}

/// Convenience extensions for responsive checks.
extension ResponsiveExtension on BuildContext {
  double get _width => MediaQuery.sizeOf(this).width;

  /// True when width < 600dp (phone)
  bool get isCompact => _width < Breakpoints.compact;

  /// True when 600dp <= width < 840dp (tablet)
  bool get isMedium =>
      _width >= Breakpoints.compact && _width < Breakpoints.medium;

  /// True when width >= 840dp (desktop / large tablet)
  bool get isExpanded => _width >= Breakpoints.medium;

  /// Adaptive grid column count for card/board grids.
  int get adaptiveGridColumns {
    if (_width >= Breakpoints.expanded) return 4;
    if (_width >= Breakpoints.medium) return 3;
    return 2;
  }
}
