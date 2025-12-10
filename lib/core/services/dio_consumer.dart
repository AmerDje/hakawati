import 'package:dio/dio.dart';
import 'package:hakawati/core/errors/dio_errors_handler.dart';
import 'package:hakawati/core/functions/logger.dart';
import 'package:hakawati/core/services/base_consumer.dart';

/// Handles HTTP requests using the Dio package.
/// Implements the [BaseConsumer] interface for GET, POST, PUT, and DELETE requests.
class DioConsumer implements BaseConsumer {
  const DioConsumer(this.dio);

  final Dio dio;

  @override
  Future<CustomResponse<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    return _errorHandlerTryCatch(() async {
      final response = await dio.delete<T>(
        path,
        queryParameters: queryParameters,
        data: data,
      );

      return CustomResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    });
  }

  @override
  Future<CustomResponse<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _errorHandlerTryCatch(() async {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
      );

      return CustomResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    });
  }

  @override
  Future<CustomResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _errorHandlerTryCatch(() async {
      final response = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return CustomResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    });
  }

  @override
  Future<CustomResponse<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _errorHandlerTryCatch(() async {
      final response = await dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return CustomResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    });
  }

  /// Utility function to handle errors in asynchronous operations.
  Future<T> _errorHandlerTryCatch<T>(Future<T> Function() function) async {
    try {
      return await function();
    } catch (e) {
      avoidLog('Error occurred: $e');
      throw DioErrorHandler.handle(e);
    }
  }
}


/*
// Cubit for managing the request
class RequestCubit extends Cubit<RequestState> {
  final DioConsumer dioConsumer;

  RequestCubit(this.dioConsumer) : super(RequestInitial());

  Future<void> fetchData() async {
    emit(RequestLoading());

    try {
      final response = await dioConsumer.get<Map<String, dynamic>>(
        '/api/data', // Example API endpoint
        queryParameters: {'param': 'value'}, // Example query parameters
      );

      // Emit success state with data
      emit(RequestSuccess(response.data));
    } catch (e) {
      if (e is NetworkException) {
        if (e.type != NetworkExceptionType.connectionTimeout &&
            e.type != NetworkExceptionType.success &&
            e.type != NetworkExceptionType.timeOut &&
            e.type != NetworkExceptionType.receiveTimeout &&
            e.type != NetworkExceptionType.sendTimeout) {
          emit(ErrorState(e.errorMessage));
        }
      } else {
        emit(ErrorState(e.errorMessage));
      }
    }
  }
}
*/