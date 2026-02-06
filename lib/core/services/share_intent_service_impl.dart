import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/providers/shared_content_provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

/// Abstract base for ShareIntentService
abstract class ShareIntentService {
  void initialize();
  void clearSharedContent();
  void dispose();
}

/// Creates the platform-specific ShareIntentService
ShareIntentService createShareIntentService(Ref ref, StateProvider<SharedContent?> sharedContentProvider) {
  return ShareIntentServiceImpl(ref, sharedContentProvider);
}

/// Mobile implementation of ShareIntentService
class ShareIntentServiceImpl implements ShareIntentService {
  StreamSubscription? _textSubscription;
  StreamSubscription? _mediaSubscription;
  final Ref _ref;
  final StateProvider<SharedContent?> _sharedContentProvider;

  ShareIntentServiceImpl(this._ref, this._sharedContentProvider);

  @override
  void initialize() {
    _textSubscription = ReceiveSharingIntent.instance.getMediaStream().listen(
      (List<SharedMediaFile> files) {
        _handleMediaFiles(files);
      },
      onError: (err) {
        debugPrint('Share intent media stream error: $err');
      },
    );

    ReceiveSharingIntent.instance.getInitialMedia().then((files) {
      if (files.isNotEmpty) {
        _handleMediaFiles(files);
      }
    });
  }

  void _handleMediaFiles(List<SharedMediaFile> files) {
    if (files.isEmpty) return;

    final textFile = files.firstWhere(
      (f) => f.type == SharedMediaType.text || f.type == SharedMediaType.url,
      orElse: () => SharedMediaFile(path: '', type: SharedMediaType.file),
    );

    if (textFile.path.isNotEmpty ||
        textFile.type == SharedMediaType.text ||
        textFile.type == SharedMediaType.url) {
      final text = files.first.path;
      _ref.read(_sharedContentProvider.notifier).state = SharedContent.fromText(text);
    } else {
      final imagePaths = files
          .where((f) => f.type == SharedMediaType.image)
          .map((f) => f.path)
          .toList();
      if (imagePaths.isNotEmpty) {
        _ref.read(_sharedContentProvider.notifier).state = SharedContent(
          imagePaths: imagePaths,
        );
      }
    }
  }

  @override
  void clearSharedContent() {
    _ref.read(_sharedContentProvider.notifier).state = null;
    ReceiveSharingIntent.instance.reset();
  }

  @override
  void dispose() {
    _textSubscription?.cancel();
    _mediaSubscription?.cancel();
  }
}
