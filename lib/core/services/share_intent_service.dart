import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/providers/shared_content_provider.dart';

// Re-export SharedContent and sharedContentProvider for backward compatibility
export 'package:nuestra_app/core/providers/shared_content_provider.dart';

// Only import the mobile implementation on non-web platforms
// On web, we use a stub implementation defined in this file
import 'share_intent_service_impl.dart'
    if (dart.library.html) 'share_intent_service_web.dart'
    as platform;

/// Provider for ShareIntentService
final shareIntentServiceProvider = Provider<platform.ShareIntentService>((ref) {
  // On web, this will use the stub implementation
  final service = platform.createShareIntentService(ref, sharedContentProvider);
  ref.onDispose(() => service.dispose());
  return service;
});
