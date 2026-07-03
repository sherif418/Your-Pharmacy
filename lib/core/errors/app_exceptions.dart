import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';

abstract class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

class AuthException extends AppException {
  AuthException(super.message);
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class DatabaseException extends AppException {
  DatabaseException(super.message);
}

class ValidationException extends AppException {
  ValidationException(super.message);
}

class AppErrorHandler {
  static AppException parse(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return AuthException(AppStrings.errorUserNotFound);
        case 'wrong-password':
          return AuthException(AppStrings.errorWrongPassword);
        case 'invalid-credential':
          return AuthException(AppStrings.errorUserNotFound);
        case 'email-already-in-use':
          return AuthException(AppStrings.errorEmailAlreadyInUse);
        case 'weak-password':
          return AuthException(AppStrings.errorWeakPassword);
        case 'network-request-failed':
          return NetworkException(AppStrings.errorNetworkRequestFailed);
        case 'too-many-requests':
          return AuthException(AppStrings.errorTooManyRequests);
        case 'user-disabled':
          return AuthException(AppStrings.errorUserNotFound);
        default:
          return AuthException(error.message ?? AppStrings.errorGeneral);
      }
    }

    if (error is FirebaseException) {
      if (error.code == 'permission-denied') {
        return DatabaseException(AppStrings.errorGeneral);
      }
      return DatabaseException(error.message ?? AppStrings.errorGeneral);
    }

    if (error is AppException) {
      return error;
    }

    return AuthException(error.toString());
  }
}
