import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Abstract base for ShareIntentService
abstract class ShareIntentService {
  void initialize();
  void clearSharedContent();
  void dispose();
}

/// Creates the web stub ShareIntentService
ShareIntentService createShareIntentService(Ref ref, StateProvider<dynamic> sharedContentProvider) {
  return ShareIntentServiceWeb(ref, sharedContentProvider);
}

/// Web stub implementation - share intents not supported on web
class ShareIntentServiceWeb implements ShareIntentService {
  final Ref _ref;
  final StateProvider<dynamic> _sharedContentProvider;

  ShareIntentServiceWeb(this._ref, this._sharedContentProvider);

  @override
  void initialize() {
    // Share intents are not supported on web
  }

  @override
  void clearSharedContent() {
    _ref.read(_sharedContentProvider.notifier).state = null;
  }

  @override
  void dispose() {
    // Nothing to dispose on web
  }
}
