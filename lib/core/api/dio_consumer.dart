import 'dart:convert' show jsonDecode;
import 'dart:ffi' show Void;
import 'dart:math' show min;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hakawati/core/network/connectivity_checker.dart';
import 'package:hakawati/core/api/status_code.dart';
import 'package:hakawati/core/error/failure.dart';
import 'package:hakawati/core/utils/constants.dart';
import 'package:hakawati/core/utils/strings.dart';

abstract class ApiConsumer {
  Future<Either<Failure, T?>> makeRequest<T>(
    String endPoint, {
    String method = 'GET',
    bool formDataIsEnabled = false,
    dynamic data,
    T Function(dynamic json)? fromJson,
    Map<String, dynamic>? queryParams,
  });
}

class DioConsumer implements ApiConsumer {
  final Dio _client;
  final ConnectivityChecker _connectivityChecker;

  // Constructor
  DioConsumer(this._client, this._connectivityChecker) {
    _client.options = clientOptions;
    if (kDebugMode) {
      _client.interceptors.add(LogInterceptor(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
      ));
    }
  }

  final Map<String, Object> headers = {
    'accept': 'application/json',
    'content-type': 'application/json',
  };
  late var clientOptions = BaseOptions(
    baseUrl: kBaseUrl,
    headers: headers,
    responseType: ResponseType.plain,
    followRedirects: false,
    validateStatus: (status) {
      return status! < StatusCode.internalServerError;
    },
  );

  // Method to make network requests
  @override
  Future<Either<Failure, T?>> makeRequest<T>(
    String endPoint, {
    String method = Strings.get,
    bool formDataIsEnabled = false,
    dynamic data,
    T Function(dynamic json)? fromJson,
    Map<String, dynamic>? queryParams,
  }) async {
    // Check for internet connection
    bool isConnected = (await _connectivityChecker.isConnected);
    if (isConnected == false) {
      final errorModel = Failure(message: "check_internet_connection");
      return Left(errorModel);
    }

    try {
      // Make the request
      final response = await _client.request(
        endPoint,
        queryParameters: queryParams,
        options: Options(method: method),
        data: formDataIsEnabled ? FormData.fromMap(data!) : data,
      );

      // Handle successful response if needed
      if (T is! Void && fromJson != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final dataJson = _handleResponseAsJson(response);
          final data = fromJson(dataJson);
          return Right(data);
        } else {
          // Handle error response
          final errorModel = Failure(
            statusCode: response.statusCode,
            message: response.statusMessage ?? "something_wrong",
          );
          return Left(errorModel);
        }
      } else {
        return const Right(null);
      }
    } on DioException catch (e) {
      // Handle DioException
      final errorMsg = Failure.fromDioError(e);
      final errorModel = Failure(
        statusCode: e.response?.statusCode,
        message: errorMsg,
      );
      return Left(errorModel);
    } catch (e) {
      // Handle other exceptions
      final errorModel = Failure(message: e.toString().substring(0, min(60, e.toString().length)));
      return Left(errorModel);
    }
  }

  // Helper method to decode response body as JSON
  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data);
    return responseJson;
  }

  // Method to update headers
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    _client.options.headers = header;

    return header;
  }
}
