import 'package:dio/dio.dart';
import 'package:hakawati/core/enums/network_exceptions_enum.dart';
import 'package:hakawati/core/errors/failure.dart';

/// Handles Dio exceptions and converts them into [Failure] instances.
class DioErrorHandler {
  const DioErrorHandler();

  static Failure handle(dynamic e) {
    if (e is DioException) {
      return _handleDioError(e);
    } else {
      return NetworkFailure(
        type: NetworkFailureType.unknown,
      );
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.badResponse:
        return _dioBadResponseExceptionToAppException(error);
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          type: NetworkFailureType.connectionTimeout,
          code: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return NetworkFailure(type: NetworkFailureType.cancel);
      case DioExceptionType.connectionError:
        return NetworkFailure(
          type: NetworkFailureType.noInternetConnection,
        );
      case DioExceptionType.badCertificate:
        return NetworkFailure(
          type: NetworkFailureType.badCertificate,
        );
      case DioExceptionType.unknown:
        return NetworkFailure(type: NetworkFailureType.unknown);
    }
  }

  static NetworkFailure _dioBadResponseExceptionToAppException(DioException error) {
    final statusCode = error.response?.statusCode;

    return switch (statusCode) {
      400 => NetworkFailure(type: NetworkFailureType.badRequest),
      401 => NetworkFailure(type: NetworkFailureType.unauthorized),
      403 => NetworkFailure(type: NetworkFailureType.forbidden),
      404 => NetworkFailure(type: NetworkFailureType.notFound),
      500 || 502 => NetworkFailure(type: NetworkFailureType.internal),
      503 => NetworkFailure(type: NetworkFailureType.serviceUnavailable),
      _ => _backendErrorResponseToAppException(error),
    };
  }

  static NetworkFailure _backendErrorResponseToAppException(DioException error) {
    return error.response != null
        ? NetworkFailure(
            type: NetworkFailureType.backend,
            code: error.response!.statusCode,
            message: error.response!.data != null
                ? ErrorResponse.fromJson(error.response!.data as Map<String, dynamic>).message ??
                    'No error message provided'
                : 'No error message provided',
          )
        : NetworkFailure(type: NetworkFailureType.unknown);
  }
}

class ErrorResponse {
  final int? code;
  final String? message;

  ErrorResponse({
    this.code,
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      code: json['code'],
      message: json['message'],
    );
  }
}
