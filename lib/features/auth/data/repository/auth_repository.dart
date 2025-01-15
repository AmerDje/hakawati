import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hakawati/core/errors/failure.dart';
import 'package:hakawati/features/auth/data/models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
    String name,
    String email,
    String phoneNumber,
    String password,
    String locate,
    String photoUrl,
  );
  Future<Either<Failure, UserModel>> loginWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, void>> temporaryLogin(
    String email,
    String password,
  );
  Future<Either<Failure, UserModel>> signinWithGoogle();
  Future<Either<Failure, UserModel>> signinWithFacebook();
  Future<Either<Failure, bool>> deleteUser();
  Future<Either<Failure, bool>> updateUserData({
    required UserModel user,
    required String endPoint,
  });

  Future<void> deleteUserData({required String uid, required String endPoint});
  Future<void> addUserData({
    required UserModel user,
    required String endPoint,
  });
  //Future saveUserData({required UserModel user});
  Future<UserModel> getUserData({
    required String uid,
    required String endPoint,
  });
  Future<Either<Failure, UserModel>> signinWithApple();
  Future<Either<Failure, bool>> sendEmailVerification();
  Future<Either<Failure, bool>> reloadUserStatus();
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, String>> uploadImage(File image);
}
