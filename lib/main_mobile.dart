import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/services/share_intent_service.dart';

/// Creates the app wrapper for mobile (with share intent support)
Widget createAppWrapper(Widget app) {
  return _ShareIntentInitializer(child: app);
}

/// Widget that initializes share intent listening (mobile only)
class _ShareIntentInitializer extends ConsumerStatefulWidget {
  final Widget child;

  const _ShareIntentInitializer({required this.child});

  @override
  ConsumerState<_ShareIntentInitializer> createState() =>
      _ShareIntentInitializerState();
}

class _ShareIntentInitializerState
    extends ConsumerState<_ShareIntentInitializer> {
  @override
  void initState() {
    super.initState();
    // Initialize share intent service after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shareIntentServiceProvider).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
