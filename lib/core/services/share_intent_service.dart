import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

/// Model representing shared content
class SharedContent {
  final String? text;
  final String? url;
  final List<String> imagePaths;

  const SharedContent({
    this.text,
    this.url,
    this.imagePaths = const [],
  });

  bool get hasUrl => url != null && url!.isNotEmpty;
  bool get hasImages => imagePaths.isNotEmpty;
  bool get isEmpty => !hasUrl && !hasImages && (text == null || text!.isEmpty);

  /// Extract URL from text if present
  static String? extractUrl(String? text) {
    if (text == null) return null;
    final urlRegex = RegExp(
      r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );
    final match = urlRegex.firstMatch(text);
    return match?.group(0);
  }

  factory SharedContent.fromText(String? text) {
    final url = extractUrl(text);
    return SharedContent(
      text: text,
      url: url,
      imagePaths: const [],
    );
  }

  factory SharedContent.fromFiles(List<SharedMediaFile> files) {
    final imagePaths = files
        .where((f) => f.type == SharedMediaType.image)
        .map((f) => f.path)
        .toList();
    return SharedContent(imagePaths: imagePaths);
  }
}

/// Provider for the current shared content
final sharedContentProvider = StateProvider<SharedContent?>((ref) => null);

/// Service to handle incoming share intents
class ShareIntentService {
  StreamSubscription? _textSubscription;
  StreamSubscription? _mediaSubscription;
  final Ref _ref;

  ShareIntentService(this._ref);

  /// Initialize listeners for share intents
  void initialize() {
    // Share intents are not supported on web
    if (kIsWeb) return;

    // Handle app opened from share while running
    _textSubscription = ReceiveSharingIntent.instance.getMediaStream().listen(
      (List<SharedMediaFile> files) {
        _handleMediaFiles(files);
      },
      onError: (err) {
        debugPrint('Share intent media stream error: $err');
      },
    );

    // Handle text shares (links)
    ReceiveSharingIntent.instance.getInitialMedia().then((files) {
      if (files.isNotEmpty) {
        _handleMediaFiles(files);
      }
    });
  }

  void _handleMediaFiles(List<SharedMediaFile> files) {
    if (files.isEmpty) return;

    // Check if it's a text/url share
    final textFile = files.firstWhere(
      (f) => f.type == SharedMediaType.text || f.type == SharedMediaType.url,
      orElse: () => SharedMediaFile(path: '', type: SharedMediaType.file),
    );

    if (textFile.path.isNotEmpty ||
        textFile.type == SharedMediaType.text ||
        textFile.type == SharedMediaType.url) {
      // It's a text or URL share
      final text = files.first.path;
      final content = SharedContent.fromText(text);
      if (!content.isEmpty) {
        _ref.read(sharedContentProvider.notifier).state = content;
      }
    } else {
      // It's media files
      final content = SharedContent.fromFiles(files);
      if (!content.isEmpty) {
        _ref.read(sharedContentProvider.notifier).state = content;
      }
    }
  }

  /// Clear the shared content
  void clearSharedContent() {
    _ref.read(sharedContentProvider.notifier).state = null;
    if (!kIsWeb) {
      ReceiveSharingIntent.instance.reset();
    }
  }

  /// Dispose subscriptions
  void dispose() {
    _textSubscription?.cancel();
    _mediaSubscription?.cancel();
  }
}

/// Provider for ShareIntentService
final shareIntentServiceProvider = Provider<ShareIntentService>((ref) {
  final service = ShareIntentService(ref);
  ref.onDispose(() => service.dispose());
  return service;
});
