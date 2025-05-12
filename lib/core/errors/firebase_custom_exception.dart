import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCustomException implements Exception {
  final String message;

  FirebaseCustomException({required this.message});

  // Handles Firebase Auth exceptions
  factory FirebaseCustomException.handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return FirebaseCustomException(message: 'No user found for that email.');
      case 'wrong-password':
        return FirebaseCustomException(message: 'Wrong password provided for that user.');
      case 'email-already-in-use':
        return FirebaseCustomException(message: 'The email is already in use.');
      case 'invalid-email':
        return FirebaseCustomException(message: 'The email is invalid.');
      default:
        return FirebaseCustomException(message: 'Authentication error: ${e.message}');
    }
  }

  // Handles Firebase Storage exceptions
  factory FirebaseCustomException.handleStorageError(FirebaseException e) {
    switch (e.code) {
      case 'object-not-found':
        return FirebaseCustomException(message: 'File does not exist.');
      case 'unauthorized':
        return FirebaseCustomException(message: 'User does not have permission to access the object.');
      case 'cancelled':
        return FirebaseCustomException(message: 'Upload was cancelled.');
      case 'unknown':
        return FirebaseCustomException(message: 'Unknown error occurred.');
      default:
        return FirebaseCustomException(message: 'Storage error: ${e.message}');
    }
  }

  // Handles Firestore exceptions
  factory FirebaseCustomException.handleFirestoreError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return FirebaseCustomException(message: 'You do not have permission to perform this action.');
      case 'not-found':
        return FirebaseCustomException(message: 'Document not found.');
      case 'already-exists':
        return FirebaseCustomException(message: 'Document already exists.');
      case 'cancelled':
        return FirebaseCustomException(message: 'Operation was cancelled.');
      case 'data-loss':
        return FirebaseCustomException(message: 'Data loss occurred.');
      case 'resource-exhausted':
        return FirebaseCustomException(message: 'Resource quota exhausted.');
      default:
        return FirebaseCustomException(message: 'Firestore error: ${e.message}');
    }
  }

  @override
  String toString() {
    return message;
  }
}
