/// Custom exceptions for the app
class AppException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;

  const AppException({
    required this.message,
    this.code,
    this.statusCode,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Server returned an error response
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    super.statusCode,
  });
}

/// Network/connection error
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Error de conexión. Verifica tu internet.',
    super.code = 'NETWORK_ERROR',
  });
}

/// Authentication error (401)
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Sesión expirada. Inicia sesión nuevamente.',
    super.code = 'UNAUTHORIZED',
    super.statusCode = 401,
  });
}

/// Forbidden error (403)
class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message = 'No tienes permiso para realizar esta acción.',
    super.code = 'FORBIDDEN',
    super.statusCode = 403,
  });
}

/// Not found error (404)
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Recurso no encontrado.',
    super.code = 'NOT_FOUND',
    super.statusCode = 404,
  });
}

/// Validation error (400)
class ValidationException extends AppException {
  final Map<String, dynamic>? errors;

  const ValidationException({
    required super.message,
    this.errors,
    super.code = 'VALIDATION_ERROR',
    super.statusCode = 400,
  });
}

/// Cache/storage error
class CacheException extends AppException {
  const CacheException({
    super.message = 'Error al acceder al almacenamiento local.',
    super.code = 'CACHE_ERROR',
  });
}

/// Timeout error
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'La solicitud tardó demasiado. Intenta de nuevo.',
    super.code = 'TIMEOUT',
  });
}
