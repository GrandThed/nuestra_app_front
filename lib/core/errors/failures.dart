import 'package:nuestra_app/core/errors/exceptions.dart';

/// Base failure class for error handling
sealed class Failure {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  factory Failure.fromException(AppException exception) {
    return switch (exception) {
      ServerException() => ServerFailure(
          message: exception.message,
          code: exception.code,
        ),
      NetworkException() => NetworkFailure(message: exception.message),
      UnauthorizedException() => UnauthorizedFailure(message: exception.message),
      ForbiddenException() => ForbiddenFailure(message: exception.message),
      NotFoundException() => NotFoundFailure(message: exception.message),
      ValidationException() => ValidationFailure(
          message: exception.message,
          errors: exception.errors,
        ),
      CacheException() => CacheFailure(message: exception.message),
      TimeoutException() => TimeoutFailure(message: exception.message),
      _ => ServerFailure(message: exception.message),
    };
  }
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code = 'NETWORK_ERROR'});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required super.message,
    super.code = 'UNAUTHORIZED',
  });
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({required super.message, super.code = 'FORBIDDEN'});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.code = 'NOT_FOUND'});
}

class ValidationFailure extends Failure {
  final Map<String, dynamic>? errors;

  const ValidationFailure({
    required super.message,
    this.errors,
    super.code = 'VALIDATION_ERROR',
  });
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code = 'CACHE_ERROR'});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, super.code = 'TIMEOUT'});
}
