import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hakawati/core/error/failure.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  AuthRepositoryImpl(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firebaseFirestore,
      required GoogleSignIn googleSignIn,
      required FacebookAuth facebookAuth})
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth;
  @override
  Either<Failure, UserModel> currentUser() {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        // Name, email address, and profile photo URL
        final name = user.displayName;
        final email = user.email;
        final photoUrl = user.photoURL;
        final phoneNumber = user.phoneNumber;

        // Check if user's email is verified
        final emailVerified = user.emailVerified;

        // The user's ID, unique to the Firebase project. Do NOT use this value to
        // authenticate with your backend server, if you have one. Use
        // User.getIdToken() instead.
        final uid = user.uid;
        return Right(UserModel(
          uid: uid,
          name: name,
          email: email,
          photoUrl: photoUrl,
          phoneNumber: phoneNumber,
          emailVerified: emailVerified,
        ));
      }
      // Return an empty User object if no user is signed in
      return const Right(UserModel());
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      // Handle other exceptions
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      return Right(
        UserModel(
          uid: user!.uid,
          email: user.email,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> fetchPersonalData(String? uid) async {
    try {
      final snapShot = await _firebaseFirestore.collection('users').doc(uid).get();
      final user = UserModel.fromJson(snapShot.data()!);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password, String locate) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      await _firebaseAuth.setLanguageCode(locate);
      return Right(user!);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }
// Existing code...

  @override
  Future<Either<Failure, UserModel>> createUser(UserModel user) async {
    try {
      await _firebaseFirestore.collection('users').doc(user.uid).set(user.toJson());
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, bool>> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, bool>> reloadUserStatus() async {
    try {
      final user = _firebaseAuth.currentUser;
      await user?.reload();

      if (user?.emailVerified ?? false) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      // Obtain a Google Access Token
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Use the credentials to sign in to Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      return Right(UserModel(
        uid: user!.uid,
        email: user.email,
        name: user.displayName, // Use display name from Google account
        photoUrl: user.photoURL,
        emailVerified: user.emailVerified,
      ));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithFacebook() async {
    try {
      final result = await _facebookAuth.login();
      // Obtain a Facebook Access Token (requires Facebook Login SDK)
      final LoginResult loginResult = result;
      if (loginResult.status == LoginStatus.success) {
        final accessToken = loginResult.accessToken;

        // Use the credentials to sign in to Firebase
        final credential = FacebookAuthProvider.credential(accessToken?.token ?? "");
        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        final user = userCredential.user;

        return Right(UserModel(
          uid: user!.uid,
          email: user.email,
          name: user.displayName, // Use display name from Facebook account
          phoneNumber: user.phoneNumber,
          photoUrl: user.photoURL,
          emailVerified: user.emailVerified,
        ));
      } else {
        return Left(Failure(message: "Login cancelled by user"));
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(UserModel()); // Indicate successful logout without user object
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> passwordResetSubmit(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(UserModel()); // Indicate successful password reset without user object
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePersonalData(UserModel user) async {
    try {
      await _firebaseFirestore.collection('users').doc(user.uid).update(user.toJson());
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser() async {
    final user = _firebaseAuth.currentUser;
    try {
      if (user != null) {
        await deletePersonalData(user.uid);
        await user.delete();
        return const Right(true);
      } else {
        return const Right(true);
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePersonalData(String? uid) async {
    try {
      await _firebaseFirestore.collection('users').doc(uid).delete();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(Failure(message: "An error occurred"));
    }
  }
}
