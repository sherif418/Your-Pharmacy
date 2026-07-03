// auth_repository.dart
// Responsible for: all communication with Firebase Auth and Firestore for authentication.
// The BLoC calls this class. Uses AppUser (domain model) — never Firebase types.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/core/errors/app_exceptions.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ── Sign In ─────────────────────────────────────────────────
  /// Signs in with email and password. Returns the authenticated [AppUser].
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw AuthException(AppStrings.errorLoginFailed);
      }

      // Fetch user role and other data from Firestore
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (!userDoc.exists) {
        throw AuthException(AppStrings.errorAccountNotFound);
      }

      final data = userDoc.data() as Map<String, dynamic>;
      return AppUser.fromMap(data, firebaseUser.uid);
    } catch (e) {
      throw AppErrorHandler.parse(e);
    }
  }

  // ── Register ────────────────────────────────────────────────
  /// Creates a new account and saves user data to Firestore.
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
    required String village,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw AuthException(AppStrings.errorGeneral);
      }

      final AppUser newUser = AppUser(
        uid: firebaseUser.uid,
        email: email,
        name: name,
        phone: phone,
        role: role,
        village: village,
      );

      // Save to Firestore
      await _firestore.collection('users').doc(firebaseUser.uid).set(newUser.toMap());

      return newUser;
    } catch (e) {
      throw AppErrorHandler.parse(e);
    }
  }

  // ── Sign Out ────────────────────────────────────────────────
  /// Signs out the current user.
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AppErrorHandler.parse(e);
    }
  }

  // ── Get Current User ────────────────────────────────────────
  /// Returns the currently signed-in user, or null if not authenticated.
  Future<AppUser?> getCurrentUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    try {
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (!userDoc.exists) return null;

      final data = userDoc.data() as Map<String, dynamic>;
      return AppUser.fromMap(data, firebaseUser.uid);
    } catch (e) {
      return null;
    }
  }
}
