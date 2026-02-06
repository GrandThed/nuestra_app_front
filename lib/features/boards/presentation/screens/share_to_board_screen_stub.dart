import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Web stub for ShareToBoardScreen - share intents not supported on web
/// This screen should never actually be shown on web, but we need a stub
/// to avoid importing the real implementation which uses receive_sharing_intent
class ShareToBoardScreen extends StatelessWidget {
  const ShareToBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Redirect to home immediately - this should never happen on web
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/');
    });

    return const Scaffold(
      body: Center(
        child: Text('Share intents are not supported on web'),
      ),
    );
  }
}
