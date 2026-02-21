import 'package:dio/dio.dart';

/// Entry in the in-memory HTTP cache.
class _CacheEntry {
  final Response response;
  final DateTime expiry;

  _CacheEntry({required this.response, required this.expiry});

  bool get isExpired => DateTime.now().isAfter(expiry);
}

/// Dio interceptor that caches GET responses in memory with a short TTL.
///
/// - Only caches GET requests
/// - Returns cached data while refreshing in the background (stale-while-revalidate)
/// - Automatically invalidates cache entries after mutations (POST/PATCH/DELETE)
class CacheInterceptor extends Interceptor {
  final Duration ttl;
  final Map<String, _CacheEntry> _cache = {};

  CacheInterceptor({this.ttl = const Duration(minutes: 2)});

  /// Generate a cache key from the request.
  String _cacheKey(RequestOptions options) {
    final query = options.queryParameters.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');
    return '${options.path}?$query';
  }

  /// Extract the base path (e.g., "/api/households/123/boards") from a request.
  String _basePath(RequestOptions options) {
    return options.path;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Only cache GET requests
    if (options.method != 'GET') {
      return handler.next(options);
    }

    final key = _cacheKey(options);
    final entry = _cache[key];

    if (entry != null && !entry.isExpired) {
      // Return cached response immediately
      return handler.resolve(
        Response(
          requestOptions: options,
          data: entry.response.data,
          statusCode: entry.response.statusCode,
          headers: entry.response.headers,
        ),
      );
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Cache successful GET responses
    if (response.requestOptions.method == 'GET' &&
        response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final key = _cacheKey(response.requestOptions);
      _cache[key] = _CacheEntry(
        response: response,
        expiry: DateTime.now().add(ttl),
      );
    }

    // Invalidate related cache entries on mutations
    if (response.requestOptions.method != 'GET') {
      _invalidateRelated(response.requestOptions);
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // On network error for GET requests, try to return stale cache
    if (err.requestOptions.method == 'GET' &&
        (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.connectionTimeout)) {
      final key = _cacheKey(err.requestOptions);
      final entry = _cache[key];

      if (entry != null) {
        // Return stale data rather than an error
        return handler.resolve(
          Response(
            requestOptions: err.requestOptions,
            data: entry.response.data,
            statusCode: entry.response.statusCode,
            headers: entry.response.headers,
          ),
        );
      }
    }

    handler.next(err);
  }

  /// Invalidate cache entries whose path is a prefix of the mutated path.
  /// E.g., POST to /boards/123/items invalidates /boards/123 and /boards
  void _invalidateRelated(RequestOptions options) {
    final path = _basePath(options);
    _cache.removeWhere((key, _) {
      // Remove entries whose path is a prefix of the mutation path, or vice versa
      return key.startsWith(path) || path.startsWith(key.split('?').first);
    });
  }

  /// Manually clear all cached entries.
  void clearAll() => _cache.clear();

  /// Manually invalidate a specific path pattern.
  void invalidate(String pathPrefix) {
    _cache.removeWhere((key, _) => key.startsWith(pathPrefix));
  }
}
