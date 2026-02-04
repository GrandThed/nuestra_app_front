import 'package:flutter/material.dart';

/// Creates the app wrapper for web (no share intent support)
Widget createAppWrapper(Widget app) {
  // On web, just return the app directly without share intent wrapper
  return app;
}
