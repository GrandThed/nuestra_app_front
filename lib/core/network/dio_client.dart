import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/core/network/api_interceptor.dart';
import 'package:nuestra_app/core/network/cache_interceptor.dart';

/// Provider for Dio client
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref);
});

/// HTTP client wrapper using Dio
class DioClient {
  late final Dio _dio;
  final Ref _ref;

  DioClient(this._ref) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll([
      AuthInterceptor(_ref),
      CacheInterceptor(ttl: const Duration(minutes: 2)),
      if (kDebugMode) LoggingInterceptor(),
    ]);
  }

  /// Get the underlying Dio instance (for multipart uploads, etc.)
  Dio get dio => _dio;

  /// GET request
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST request
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PATCH request
  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE request
  Future<T?> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      // Handle 204 No Content responses
      if (response.statusCode == 204 || response.data == null) {
        return null;
      }
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle successful response
  T _handleResponse<T>(Response<T> response) {
    final data = response.data;

    // Check for API error format
    if (data is Map<String, dynamic>) {
      if (data['success'] == false) {
        throw ServerException(
          message: data['error'] ?? 'Unknown error',
          statusCode: response.statusCode,
        );
      }
    }

    return data as T;
  }

  /// Convert DioException to AppException
  AppException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return const AppException(message: 'Request cancelled');

      default:
        return ServerException(
          message: error.message ?? 'Unknown error',
        );
    }
  }

  /// Handle bad response (4xx, 5xx)
  AppException _handleBadResponse(Response? response) {
    if (response == null) {
      return const ServerException(message: 'No response from server');
    }

    final statusCode = response.statusCode;
    final data = response.data;

    // Extract error message from response
    String message = 'Error desconocido';
    if (data is Map<String, dynamic>) {
      message = data['error'] ?? data['message'] ?? message;
    } else if (data is String) {
      message = data;
    }

    return switch (statusCode) {
      400 => ValidationException(message: message, statusCode: statusCode),
      401 => UnauthorizedException(message: message),
      403 => ForbiddenException(message: message),
      404 => NotFoundException(message: message),
      _ => ServerException(message: message, statusCode: statusCode),
    };
  }
}
