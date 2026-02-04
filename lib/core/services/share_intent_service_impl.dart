import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'share_intent_service.dart';

/// Creates the platform-specific ShareIntentService
ShareIntentService createShareIntentService(Ref ref) {
  return ShareIntentServiceImpl(ref);
}

/// Mobile implementation of ShareIntentService
class ShareIntentServiceImpl implements ShareIntentService {
  StreamSubscription? _textSubscription;
  StreamSubscription? _mediaSubscription;
  final Ref _ref;

  ShareIntentServiceImpl(this._ref);

  @override
  void initialize() {
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
      final imagePaths = files
          .where((f) => f.type == SharedMediaType.image)
          .map((f) => f.path)
          .toList();
      final content = SharedContent(imagePaths: imagePaths);
      if (!content.isEmpty) {
        _ref.read(sharedContentProvider.notifier).state = content;
      }
    }
  }

  @override
  void clearSharedContent() {
    _ref.read(sharedContentProvider.notifier).state = null;
    ReceiveSharingIntent.instance.reset();
  }

  @override
  void dispose() {
    _textSubscription?.cancel();
    _mediaSubscription?.cancel();
  }
}
