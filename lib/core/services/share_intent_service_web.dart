import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'share_intent_service.dart';

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
    _ref.read(sharedContentProvider.notifier).state = null;
  }

  @override
  void dispose() {
    // Nothing to dispose on web
  }
}
