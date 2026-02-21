import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_content_provider.g.dart';

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

/// Provider for the current shared content
@Riverpod(keepAlive: true)
class SharedContentNotifier extends _$SharedContentNotifier {
  @override
  SharedContent? build() => null;

  void set(SharedContent? content) => state = content;

  void clear() => state = null;
}
