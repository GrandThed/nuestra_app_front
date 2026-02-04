import 'package:flutter_riverpod/flutter_riverpod.dart';

// Conditional import - use web stub when compiling for web
import 'share_intent_service_impl.dart'
    if (dart.library.html) 'share_intent_service_web.dart'
    as platform;

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
}

/// Provider for the current shared content (using dynamic to avoid type issues with conditional imports)
final sharedContentProvider = StateProvider<dynamic>((ref) => null);

/// Provider for ShareIntentService
final shareIntentServiceProvider = Provider<platform.ShareIntentService>((ref) {
  final service = platform.createShareIntentService(ref, sharedContentProvider);
  ref.onDispose(() => service.dispose());
  return service;
});
