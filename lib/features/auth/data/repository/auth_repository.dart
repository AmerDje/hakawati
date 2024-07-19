import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hakawati/core/error/failure.dart';
import 'package:hakawati/features/auth/data/models/user.dart';

abstract class AuthRepository {
  Either<Failure, UserModel> currentUser();
  Future<Either<Failure, UserModel>> login(String email, String password);
  Future<Either<Failure, UserModel>> fetchPersonalData(String? uid);
  Future<Either<Failure, User>> register(String email, String password, String locate);
  Future<Either<Failure, UserModel>> createUser(UserModel user);
  Future<Either<Failure, bool>> updateUser(String userId, Map<String, dynamic> updates);
  Future<Either<Failure, String>> uploadImage(File image);
  Future<Either<Failure, UserModel>> logout();
  Future<Either<Failure, UserModel>> passwordResetSubmit(String email);
  Future<Either<Failure, bool>> sendEmailVerification();
  Future<Either<Failure, UserModel>> signInWithGoogle();
  Future<Either<Failure, UserModel>> signInWithFacebook();
  Future<Either<Failure, bool>> reloadUserStatus();
  Future<Either<Failure, bool>> updatePersonalData(UserModel user);
  Future<Either<Failure, bool>> deleteUser();
  Future<Either<Failure, bool>> deletePersonalData(String? uid);
}
