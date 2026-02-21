import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/providers/shared_content_provider.dart';

/// Abstract base for ShareIntentService
abstract class ShareIntentService {
  void initialize();
  void clearSharedContent();
  void dispose();
}

/// Creates the web stub ShareIntentService
ShareIntentService createShareIntentService(Ref ref) {
  return ShareIntentServiceWeb(ref);
}

/// Web stub implementation - share intents not supported on web
class ShareIntentServiceWeb implements ShareIntentService {
  final Ref _ref;

  ShareIntentServiceWeb(this._ref);

  @override
  void initialize() {
    // Share intents are not supported on web
  }

  @override
  void clearSharedContent() {
    _ref.read(sharedContentProvider.notifier).clear();
  }

  @override
  void dispose() {
    // Nothing to dispose on web
  }
}
