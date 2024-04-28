import 'dart:math' show min;

import 'package:dio/dio.dart' show DioException, DioExceptionType;
import 'package:hakawati/core/api/status_code.dart';

class Failure {
  final String message;
  final int? statusCode;

  Failure({
    required this.message,
    this.statusCode,
  });

  // Helper method to handle different types of Dio exceptions
  static String fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "timeout_occurred";
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          if (error.response!.data is String) {
            return error.response?.data ?? "bad_request";
          } else {
            switch (statusCode) {
              case StatusCode.badRequest:
                return error.response?.data['message'] ?? "bad_request";
              case StatusCode.unauthorized:
              case StatusCode.forbidden:
                return error.response?.data['message'] ?? "unauthorized";
              case StatusCode.notFound:
                return error.response?.data['message'] ?? "not_found";
              case StatusCode.conflict:
                return error.response?.data['message'] ?? "conflict";
              case StatusCode.internalServerError:
                return "internal_server_error";
            }
          }
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        return "unknown_error";
      case DioExceptionType.badCertificate:
        return "internal_server_error";
      case DioExceptionType.connectionError:
        return "connection_error";
      default:
        return "unknown_error";
    }
    return error.toString().substring(0, min(60, error.toString().length));
  }
}
