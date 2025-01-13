import 'package:firebase_auth/firebase_auth.dart';

class CustomException implements Exception {
  final String message;

  CustomException({required this.message});

  // Handles Firebase Auth exceptions
  factory CustomException.handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return CustomException(message: 'No user found for that badge number.');
      case 'wrong-password':
        return CustomException(message: 'Wrong password provided for that user.');
      case 'email-already-in-use':
        return CustomException(message: 'The badge number is already in use.');
      case 'invalid-email':
        return CustomException(message: 'The badge number is invalid.');
      default:
        return CustomException(message: 'Authentication error: ${e.message}');
    }
  }

  // Handles Firebase Storage exceptions
  factory CustomException.handleStorageError(FirebaseException e) {
    switch (e.code) {
      case 'object-not-found':
        return CustomException(message: 'File does not exist.');
      case 'unauthorized':
        return CustomException(message: 'User does not have permission to access the object.');
      case 'cancelled':
        return CustomException(message: 'Upload was cancelled.');
      case 'unknown':
        return CustomException(message: 'Unknown error occurred.');
      default:
        return CustomException(message: 'Storage error: ${e.message}');
    }
  }

  // Handles Firestore exceptions
  factory CustomException.handleFirestoreError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return CustomException(message: 'You do not have permission to perform this action.');
      case 'not-found':
        return CustomException(message: 'Document not found.');
      case 'already-exists':
        return CustomException(message: 'Document already exists.');
      case 'cancelled':
        return CustomException(message: 'Operation was cancelled.');
      case 'data-loss':
        return CustomException(message: 'Data loss occurred.');
      case 'resource-exhausted':
        return CustomException(message: 'Resource quota exhausted.');
      default:
        return CustomException(message: 'Firestore error: ${e.message}');
    }
  }

  @override
  String toString() {
    return message;
  }
}
