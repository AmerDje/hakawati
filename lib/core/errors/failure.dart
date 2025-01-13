import 'package:hakawati/core/enums/network_exceptions_enum.dart';
import 'package:hakawati/core/utils/constants.dart';

abstract class Failure {
  final String message;
  final int? code;

  Failure({required this.message, this.code});
}

class FirebaseFailure extends Failure {
  FirebaseFailure({required super.message});
}

class NetworkFailure extends Failure {
  final NetworkFailureType type;

  NetworkFailure({
    required this.type,
    super.message = Constants.kNetworkErrorMessage,
    super.code,
  });
}

/// Represents cache-related exceptions.
class CacheFailure extends Failure {
  CacheFailure({
    super.message = Constants.kCacheErrorMessage,
    super.code,
  });
}
