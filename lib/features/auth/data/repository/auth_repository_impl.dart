import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hakawati/core/errors/firebase_custom_exception.dart';
import 'package:hakawati/core/errors/failure.dart';
import 'package:hakawati/core/functions/logger.dart';
import 'package:hakawati/core/services/firebase_auth_service.dart';
import 'package:hakawati/core/services/firebase_firestore_service.dart';
import 'package:hakawati/core/services/firebase_storage_service.dart';
import 'package:hakawati/core/utils/endpoints.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthService firebaseAuthService;
  final FirebaseFireStoreService fireStoreService;
  final FirebaseStorageService firebaseStorageService;

  AuthRepositoryImpl({
    required this.fireStoreService,
    required this.firebaseAuthService,
    required this.firebaseStorageService,
  });

  @override
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
    String name,
    String email,
    String phoneNumber,
    String password,
    String locate,
    String photoUrl,
  ) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(email: email, password: password);
      var userEntity = UserModel(
        uid: user.uid,
        name: name,
        email: email,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
        emailVerified: user.emailVerified,
      );

      await addUserData(user: userEntity, endPoint: Endpoints.users);

      return right(userEntity);
    } on FirebaseCustomException catch (e) {
      await deleteNewUser(user);
      return left(FirebaseFailure(message: e.message));
    } catch (e) {
      await deleteNewUser(user);
      return left(FirebaseFailure(message: 'Failed to Signup, Please try again'));
    }
  }

  Future<void> deleteNewUser(User? user) async {
    if (user != null) {
      try {
        // this deletes the user and signs them out
        await user.delete();
        // await firebaseAuthService.signOut();
        // await firebaseAuthService.deleteUser();
      } catch (e) {
        avoidPrint("Exception in AuthRepoImpl.deleteUser: ${e.toString()}");
      }
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser() async {
    try {
      await firebaseAuthService.deleteCurrentUser();

      return right(true);
    } on FirebaseCustomException catch (e) {
      return left(FirebaseFailure(message: e.message));
    } catch (e) {
      return left(FirebaseFailure(message: 'Failed to Login, Please try again'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
      late UserModel userEntity;

      // Fetch user data

      userEntity = await getUserData(uid: user.uid, endPoint: Endpoints.users);

      // await saveUserData(user: userEntity);
      return right(userEntity);
    } on FirebaseCustomException catch (e) {
      return left(FirebaseFailure(message: e.message));
    } catch (e) {
      return left(FirebaseFailure(message: 'Failed to Login, Please try again'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signinWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      var userEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await fireStoreService.checkIfDataExists(path: Endpoints.users, documentId: user.uid);
      if (isUserExist) {
        await getUserData(uid: user.uid, endPoint: Endpoints.users);
      } else {
        await addUserData(user: userEntity, endPoint: Endpoints.users);
      }
      return right(userEntity);
    } catch (e) {
      await deleteNewUser(user);
      avoidPrint(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        FirebaseFailure(
          message: 'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> signinWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();
      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity, endPoint: Endpoints.users);
      return right(userEntity);
    } catch (e) {
      await deleteNewUser(user);
      avoidPrint(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        FirebaseFailure(
          message: 'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> signinWithApple() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithApple();

      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity, endPoint: Endpoints.users);
      return right(userEntity);
    } catch (e) {
      await deleteNewUser(user);
      avoidPrint(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        FirebaseFailure(
          message: 'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future<Either<FirebaseFailure, bool>> reloadUserStatus() async {
    try {
      final bool isUserVerified = await firebaseAuthService.reloadUser();
      return right(isUserVerified);
    } on FirebaseCustomException catch (e) {
      return left(FirebaseFailure(message: e.message));
    } catch (e) {
      return left(FirebaseFailure(message: 'Failed to Login, Please try again'));
    }
  }

  @override
  Future<Either<FirebaseFailure, bool>> sendEmailVerification() async {
    try {
      await firebaseAuthService.verifyEmail();
      return right(true);
    } on FirebaseCustomException catch (e) {
      return left(FirebaseFailure(message: e.message));
    } catch (e) {
      return left(FirebaseFailure(message: 'Failed to Login, Please try again'));
    }
  }

// logout
  @override
  Future<Either<FirebaseFailure, void>> logout() async {
    try {
      await firebaseAuthService.signOut();
      return right(null);
    } on FirebaseCustomException catch (e) {
      return left(FirebaseFailure(message: e.message));
    } catch (e) {
      return left(FirebaseFailure(message: 'Failed to Login, Please try again'));
    }
  }

  @override
  Future addUserData({required UserModel user, required String endPoint}) async {
    try {
      await fireStoreService.addData(
        path: endPoint,
        data: user.toJson(),
        documentId: user.uid,
      );
    } catch (e) {
      avoidPrint('Exception in AuthRepoImpl.addUserData: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> getUserData({required String uid, required String endPoint}) async {
    try {
      var userData = await fireStoreService.getData(
        path: endPoint,
        documentId: uid,
      );
      return UserModel.fromJson(userData);
    } catch (e) {
      avoidPrint('Exception in AuthRepoImpl.getUserData: ${e.toString()}');
      return const UserModel();
    }
  }

  @override
  Future updateUserData({required UserModel user, required String endPoint}) async {
    try {
      await fireStoreService.updateData(
        path: endPoint,
        data: user.toJson(),
        documentId: user.uid!,
      );
    } catch (e) {
      avoidPrint('Exception in AuthRepoImpl.updateUserData: ${e.toString()}');
    }
  }

  Future<Either<Failure, String>> uploadImage(File image) async {
    try {
      String downloadUrl = await firebaseStorageService.uploadFile(
        image,
      );
      return right(downloadUrl);
    } on FirebaseCustomException catch (e) {
      return left(FirebaseFailure(message: e.message));
    } catch (e) {
      return left(FirebaseFailure(message: 'Failed to Upload, Please try again'));
    }
  }

  // @override
  // Future saveUserData({required UserModel user}) async {
  //   try {
  //     var jsonData = jsonEncode(user.toJson());
  //     await Prefs.setString(Constants.kUserKey, jsonData);
  //   } catch (e) {
  //     avoidPrint('Exception in AuthRepoImpl.saveUserData: ${e.toString()}');
  //   }
  // }
}
