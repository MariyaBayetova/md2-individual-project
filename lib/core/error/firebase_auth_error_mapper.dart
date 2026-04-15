import 'package:firebase_auth/firebase_auth.dart';

String mapFirebaseAuthError(Object error) {
  if (error is FirebaseAuthException) {
    return switch (error.code) {
      'email-already-in-use' =>
        'This email is already registered. Log in or recover your password.',
      'invalid-email' => 'Invalid email format. Please check and try again.',
      'operation-not-allowed' => 'Login with email/password is disabled.',
      'weak-password' => 'The password is too weak. Minimum 6 characters.',
      'user-disabled' =>
        'Your account has been blocked. Please contact support.',
      'user-not-found' => 'User with this email not found.',
      'wrong-password' => 'Incorrect password. Try again.',
      'invalid-credential' => 'Invalid credentials. Check email and password.',
      'too-many-requests' => 'Too many attempts. Try again later.',
      'network-request-failed' => 'No internet connection.',
      'requires-recent-login' =>
        'You need to log in again to perform this action.',
      _ => error.message ?? 'Authentication error.',
    };
  }
  return error.toString();
}