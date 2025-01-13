import 'package:hakawati/core/enums/network_exceptions_enum.dart';
import 'package:hakawati/core/errors/failure.dart';
import 'package:hakawati/core/utils/constants.dart';

/// Extensions for providing user-friendly error messages.
extension AppExceptionExtension on Object {
  String get errorMessage {
    final shadow = this;
    if (shadow is Failure) {
      return switch (shadow) {
        NetworkFailure e => e.networkErrorMessage(),
        CacheFailure e => e.cacheErrorMessage(),
        _ => Constants.kUnknownErrorMessage,
      };
    }
    return Constants.kUnknownErrorMessage;
  }
}

extension NetworkFailureExtension on NetworkFailure {
  String networkErrorMessage() {
    return switch (type) {
      NetworkFailureType.connectionTimeout => 'Connection timeout',
      NetworkFailureType.cancel => 'Request canceled',
      NetworkFailureType.noInternetConnection => 'No internet connection',
      NetworkFailureType.badCertificate => 'Bad certificate',
      NetworkFailureType.unknown => Constants.kUnknownErrorMessage,
      NetworkFailureType.internal => 'Internal server error',
      NetworkFailureType.badRequest => 'Bad request: The server could not understand the request.',
      NetworkFailureType.unauthorized => 'Unauthorized: Please log in to access this resource.',
      NetworkFailureType.forbidden => 'Forbidden: You do not have permission to access this resource.',
      NetworkFailureType.notFound => 'Not found: The requested resource was not found.',
      NetworkFailureType.serviceUnavailable => 'Service unavailable: The server is currently unavailable.',
      NetworkFailureType.noInternet => 'No internet connection',
      NetworkFailureType.success => '',
      NetworkFailureType.noContent => 'No content',
      NetworkFailureType.conflict => 'Conflict',
      NetworkFailureType.timeOut => 'Time out',
      NetworkFailureType.backend => message,
      NetworkFailureType.receiveTimeout => 'Receive timeout',
      NetworkFailureType.sendTimeout => 'Send timeout',
      _ => Constants.kUnknownErrorMessage,
    };
  }
}

extension CacheFailureExtension on CacheFailure {
  String cacheErrorMessage() {
    return message;
  }
}
