import 'package:dartz/dartz.dart';
import 'package:hakawati/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(String email, String password);
  Future<Either<Failure, bool>> register(String email, String password);
}
