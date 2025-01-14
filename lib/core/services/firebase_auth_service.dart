import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:hakawati/core/errors/firebase_custom_exception.dart';
import 'package:hakawati/core/functions/logger.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthService({
    required this.firebaseAuth,
  });

  Future<User> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<User> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final user = (await firebaseAuth.signInWithCredential(credential)).user;
      return user!;
    } catch (e) {
      avoidLog('An error occurred while signing in with Google: $e');
    }
    return null;
  }

  Future<User?> signInWithFacebook() async {
    try {
      // Generate nonce and hash it for added security
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Log in with Facebook
      final LoginResult loginResult = await FacebookAuth.instance.login(
        nonce: nonce,
      );

      // Check the login status
      if (loginResult.status == LoginStatus.success) {
        OAuthCredential facebookAuthCredential;

        if (Platform.isIOS) {
          switch (loginResult.accessToken!.type) {
            case AccessTokenType.classic:
              final token = loginResult.accessToken as ClassicToken;
              facebookAuthCredential = FacebookAuthProvider.credential(
                token.authenticationToken!,
              );
              break;
            case AccessTokenType.limited:
              final token = loginResult.accessToken as LimitedToken;
              facebookAuthCredential = OAuthCredential(
                providerId: 'facebook.com',
                signInMethod: 'oauth',
                idToken: token.tokenString,
                rawNonce: rawNonce,
              );
              break;
          }
        } else {
          facebookAuthCredential = FacebookAuthProvider.credential(
            loginResult.accessToken!.tokenString,
          );
        }

        // Sign in to Firebase with the credential
        UserCredential userCredential = await firebaseAuth.signInWithCredential(facebookAuthCredential);

        return userCredential.user;
      } else if (loginResult.status == LoginStatus.cancelled) {
        avoidLog('Facebook login was cancelled by the user.');
      } else if (loginResult.status == LoginStatus.failed) {
        avoidLog('Facebook login failed: ${loginResult.message}');
      }
    } catch (e) {
      avoidLog('An error occurred while signing in with Facebook: $e');
    }
    return null;
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    final user = (await firebaseAuth.signInWithCredential(oauthCredential)).user!;
    return user;
  }

  bool isLoggedIn() {
    return firebaseAuth.currentUser != null;
  }

  Future<User> signInAnonymously() async {
    try {
      final credential = await firebaseAuth.signInAnonymously();
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<void> deleteCurrentUser() async {
    try {
      await firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<bool> reloadUser() async {
    try {
      final user = firebaseAuth.currentUser;
      await user?.reload();

      if (user?.emailVerified ?? false) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<void> verifyEmail() async {
    try {
      final user = firebaseAuth.currentUser!;
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleAuthError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: "unknown-error");
    }
  }
}
