import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Provider for secure storage
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
});

/// Provider for auth token
final authTokenProvider = StateProvider<String?>((ref) => null);

/// Interceptor to add JWT token to requests
class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for public endpoints
    final publicEndpoints = ['/auth/google', '/auth/apple', '/auth/dev-login'];
    if (publicEndpoints.any((e) => options.path.contains(e))) {
      return handler.next(options);
    }

    // Get token from provider or storage
    var token = ref.read(authTokenProvider);
    if (token == null) {
      final storage = ref.read(secureStorageProvider);
      token = await storage.read(key: 'auth_token');
      if (token != null) {
        ref.read(authTokenProvider.notifier).state = token;
      }
    }

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 - clear token and redirect to login
    if (err.response?.statusCode == 401) {
      final storage = ref.read(secureStorageProvider);
      await storage.delete(key: 'auth_token');
      ref.read(authTokenProvider.notifier).state = null;
    }
    handler.next(err);
  }
}

/// Interceptor for logging requests/responses in debug mode
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌─────────────────────────────────────────────────');
      debugPrint('│ REQUEST: ${options.method} ${options.uri}');
      if (options.data != null) {
        debugPrint('│ DATA: ${options.data}');
      }
      debugPrint('└─────────────────────────────────────────────────');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌─────────────────────────────────────────────────');
      debugPrint('│ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
      debugPrint('│ DATA: ${response.data}');
      debugPrint('└─────────────────────────────────────────────────');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌─────────────────────────────────────────────────');
      debugPrint('│ ERROR: ${err.response?.statusCode} ${err.requestOptions.uri}');
      debugPrint('│ MESSAGE: ${err.message}');
      debugPrint('│ DATA: ${err.response?.data}');
      debugPrint('└─────────────────────────────────────────────────');
    }
    handler.next(err);
  }
}
