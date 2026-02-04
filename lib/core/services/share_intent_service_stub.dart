import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Stub implementation for web - share intents not supported
class ShareIntentService {
  ShareIntentService(Ref ref);

  void initialize() {
    // Not supported on web
  }

  void clearSharedContent() {
    // Not supported on web
  }

  void dispose() {
    // Not supported on web
  }
}

/// Stub types for web compatibility
class SharedMediaFile {
  final String path;
  final SharedMediaType type;

  SharedMediaFile({required this.path, required this.type});
}

enum SharedMediaType { text, url, image, video, file }
