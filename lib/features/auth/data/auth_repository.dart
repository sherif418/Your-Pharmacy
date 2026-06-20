// auth_repository.dart
// Responsible for: all communication with Firebase Auth and Firestore for authentication.
// The BLoC calls this class. Uses AppUser (domain model) — never Firebase types.

import 'package:flutter_application_1/features/auth/domain/user.dart';

class AuthRepository {
  // ── Sign In ─────────────────────────────────────────────────
  /// Signs in with email and password. Returns the authenticated [AppUser].
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    // TODO: Replace with real Firebase Auth call + Firestore user fetch.
    return AppUser(
      uid: 'mock-uid-123',
      email: email,
      name: 'مستخدم تجريبي',
      phone: '01000000000',
      role: 'customer',
    );
  }

  // ── Register ────────────────────────────────────────────────
  /// Creates a new account and saves user data to Firestore.
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    // TODO: Replace with real Firebase Auth createUser + Firestore set.
    return AppUser(
      uid: 'mock-uid-456',
      email: email,
      name: name,
      phone: phone,
      role: role,
    );
  }

  // ── Sign Out ────────────────────────────────────────────────
  /// Signs out the current user.
  Future<void> signOut() async {
    // TODO: Replace with FirebaseAuth.instance.signOut()
  }

  // ── Get Current User ────────────────────────────────────────
  /// Returns the currently signed-in user, or null if not authenticated.
  Future<AppUser?> getCurrentUser() async {
    // TODO: Replace with FirebaseAuth.instance.currentUser + Firestore fetch.
    return null;
  }
}
