// auth_repository.dart
// ─────────────────────────────────────────────────────────────────────────────
// Handles ALL Firebase Auth + Firestore operations.
// BLoC rule: no Firebase types leave this class — only AppUser (domain model).
//
// Email Verification Workflow:
//   1. register()              → createUserWithEmailAndPassword + sendEmailVerification
//                                 ★ NO Firestore write yet
//   2. reloadAndCheckVerified() → reload() + getIdToken(true) + check emailVerified
//   3. saveUserToFirestore()    → check if doc exists → create ONLY if not
//   4. signIn()                 → reload() → check emailVerified → fetch Firestore doc
// ─────────────────────────────────────────────────────────────────────────────

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/core/errors/app_exceptions.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';

enum AuthCheckResultType { unauthenticated, pendingVerification, verified }

class AuthCheckResult {
  final AuthCheckResultType type;
  final AppUser? user;

  AuthCheckResult({required this.type, this.user});
}

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ══════════════════════════════════════════════════════════════
  // REGISTER — Step 1
  // Creates the Firebase Auth account and sends a verification email.
  // ★ Does NOT write to Firestore. Returns pendingUser to the BLoC.
  // ══════════════════════════════════════════════════════════════
  Future<AppUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    String role = 'customer',
    required String village,
  }) async {
    debugPrint('[Auth][Register] Starting registration for: $email');
    try {
      final UserCredential cred =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = cred.user;
      if (firebaseUser == null) {
        debugPrint('[Auth][Register] ERROR: firebaseUser is null after createUser');
        throw AuthException(AppStrings.errorGeneral);
      }

      debugPrint('[Auth][Register] Firebase user created. UID: ${firebaseUser.uid}');
      debugPrint('[Auth][Register] Sending verification email...');

      await firebaseUser.sendEmailVerification();
      debugPrint('[Auth][Register] Verification email sent ✓');

      // ★ Build pendingUser — NOT saved to Firestore yet
      final pendingUser = AppUser(
        uid: firebaseUser.uid,
        email: email,
        name: name,
        phone: phone,
        role: role.isNotEmpty ? role : 'customer',
        village: village,
      );

      debugPrint('[Auth][Register] pendingUser built. Waiting for email verification.');
      return pendingUser;
    } catch (e) {
      debugPrint('[Auth][Register] EXCEPTION: $e');
      throw AppErrorHandler.parse(e);
    }
  }

  // ══════════════════════════════════════════════════════════════
  // RELOAD & CHECK VERIFIED — Step 2
  //
  // ★ FIX 1: Do NOT silently catch exceptions. Propagate them.
  // ★ FIX 2: After reload(), call getIdToken(true) to force-refresh
  //   the ID token. Without this, Firestore still sees the stale token
  //   that has email_verified=false, causing permission-denied errors.
  // ══════════════════════════════════════════════════════════════
  Future<bool> reloadAndCheckVerified() async {
    debugPrint('[Auth][Reload] Starting reloadAndCheckVerified...');

    final User? user = _auth.currentUser;
    if (user == null) {
      debugPrint('[Auth][Reload] ERROR: currentUser is NULL — not signed in!');
      return false;
    }

    // Step A: reload from Firebase servers (no silent catch!)
    await user.reload();

    // Step B: re-fetch — the old reference may be stale
    final User? refreshed = _auth.currentUser;
    final bool verified = refreshed?.emailVerified ?? false;

    if (refreshed != null) {
      debugPrint("UID = ${refreshed.uid}");
      debugPrint("Email = ${refreshed.email}");
      debugPrint("Verified = $verified");
    }

    if (verified) {
      // ★ FIX 2: Force token refresh so Firestore rules see
      //   email_verified = true in the new JWT claim.
      debugPrint('[Auth][Reload] Forcing ID-token refresh (getIdToken true)...');
      await refreshed!.getIdToken(true);
      debugPrint('[Auth][Reload] Token refreshed ✓');
    }

    return verified;
  }

  // ══════════════════════════════════════════════════════════════
  // SAVE USER TO FIRESTORE — Step 3
  //
  // Called ONLY after reloadAndCheckVerified() returns true.
  // ★ Checks if document already exists before writing (idempotent).
  // ══════════════════════════════════════════════════════════════
  Future<void> saveUserToFirestore(AppUser user) async {
    debugPrint('[Firestore][Save] Checking existence for UID: ${user.uid}');

    final docRef = _firestore.collection('users').doc(user.uid);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      debugPrint('[Firestore][Save] Document already exists — skipping write.');
      return;
    }

    debugPrint('[Firestore][Save] Document not found. Creating now...');
    debugPrint('[Firestore][Save] Payload: ${user.toMap()}');

    try {
      await docRef.set(user.toMap());
      debugPrint('[Firestore][Save] Document created successfully ✓');
    } catch (e) {
      debugPrint('[Firestore][Save] WRITE FAILED: $e');
      // Re-throw so BLoC can decide what to do
      throw AppErrorHandler.parse(e);
    }
  }

  // ══════════════════════════════════════════════════════════════
  // RESEND VERIFICATION EMAIL
  // ══════════════════════════════════════════════════════════════
  Future<void> resendVerificationEmail() async {
    debugPrint('[Auth][Resend] Resending verification email...');
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        debugPrint('[Auth][Resend] ERROR: currentUser is null');
        throw AuthException(AppStrings.errorGeneral);
      }
      await user.sendEmailVerification();
      debugPrint('[Auth][Resend] Verification email resent ✓');
    } catch (e) {
      debugPrint('[Auth][Resend] EXCEPTION: $e');
      throw AppErrorHandler.parse(e);
    }
  }

  // ══════════════════════════════════════════════════════════════
  // SIGN IN
  //
  // ★ After signIn, calls reload() to get fresh emailVerified status.
  // ★ If not verified: signOut() + throw EmailNotVerifiedException.
  // ★ If verified: fetch Firestore document.
  // ══════════════════════════════════════════════════════════════
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    debugPrint('[Auth][Login] Signing in: $email');
    try {
      final UserCredential cred =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = cred.user;
      if (firebaseUser == null) {
        debugPrint('[Auth][Login] ERROR: firebaseUser is null after signIn');
        throw AuthException(AppStrings.errorLoginFailed);
      }

      debugPrint('[Auth][Login] Firebase signIn success. UID: ${firebaseUser.uid}');

      // Reload to get fresh emailVerified from server
      await firebaseUser.reload();
      final User? refreshed = _auth.currentUser;
      final bool verified = refreshed?.emailVerified ?? false;

      debugPrint('[Auth][Login] emailVerified (after reload) = $verified');

      if (!verified) {
        debugPrint('[Auth][Login] Email NOT verified → signing out + throwing EmailNotVerifiedException');
        await _auth.signOut();
        throw EmailNotVerifiedException(AppStrings.errorEmailNotVerified);
      }

      // Force token refresh before reading Firestore
      await refreshed!.getIdToken(true);
      debugPrint('[Auth][Login] Token refreshed ✓');

      // Ensure Firestore document exists and return a loaded AppUser.
      final appUser = await _ensureUserDocument(refreshed);
      debugPrint('[Auth][Login] User loaded: ${appUser.name} (${appUser.role}) ✓');
      return appUser;
    } catch (e) {
      debugPrint('[Auth][Login] EXCEPTION: $e');
      throw AppErrorHandler.parse(e);
    }
  }

  Future<AppUser> _ensureUserDocument(User firebaseUser) async {
    debugPrint('[Firestore][Ensure] Checking Firestore document for UID: ${firebaseUser.uid}');
    final docRef = _firestore.collection('users').doc(firebaseUser.uid);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      debugPrint('[Firestore][Ensure] Document exists. Loading AppUser.');
      final data = docSnap.data() as Map<String, dynamic>;
      return AppUser.fromMap(data, firebaseUser.uid);
    }

    debugPrint('[Firestore][Ensure] Document missing. Creating from Firebase user.');
    final newUser = AppUser.fromFirebaseUser(firebaseUser);
    await docRef.set(newUser.toMap());
    debugPrint('[Firestore][Ensure] Document created successfully ✓');
    return newUser;
  }

  // ══════════════════════════════════════════════════════════════
  // CHECK CURRENT AUTH STATUS FOR SPLASH
  // ══════════════════════════════════════════════════════════════
  Future<AuthCheckResult> checkCurrentAuthStatus() async {
    debugPrint('[Auth][Splash] Checking current user...');
    final User? firebaseUser = _auth.currentUser;

    if (firebaseUser == null) {
      debugPrint('[Auth][Splash] No signed-in user → LoginScreen');
      return AuthCheckResult(type: AuthCheckResultType.unauthenticated);
    }

    debugPrint('[Auth][Splash] Found signed-in user: ${firebaseUser.email}');
    debugPrint('[Auth][Splash] emailVerified (cached) = ${firebaseUser.emailVerified}');

    await firebaseUser.reload();
    final User? refreshed = _auth.currentUser;
    final bool verified = refreshed?.emailVerified ?? false;
    debugPrint('[Auth][Splash] emailVerified (after reload) = $verified');

    if (!verified) {
      debugPrint('[Auth][Splash] Email NOT verified → pending email verification');
      return AuthCheckResult(
        type: AuthCheckResultType.pendingVerification,
        user: AppUser.fromFirebaseUser(firebaseUser),
      );
    }

    debugPrint('[Auth][Splash] Verified user. Refreshing token and checking Firestore.');

    await refreshed!.getIdToken(true);
    debugPrint('[Auth][Splash] Token refreshed ✓');

    final appUser = await _ensureUserDocument(refreshed);
    return AuthCheckResult(type: AuthCheckResultType.verified, user: appUser);
  }

  // ══════════════════════════════════════════════════════════════
  // SIGN OUT
  // ══════════════════════════════════════════════════════════════
  Future<void> signOut() async {
    debugPrint('[Auth][Logout] Signing out...');
    try {
      await _auth.signOut();
      debugPrint('[Auth][Logout] Signed out ✓');
    } catch (e) {
      debugPrint('[Auth][Logout] EXCEPTION: $e');
      throw AppErrorHandler.parse(e);
    }
  }

  // ══════════════════════════════════════════════════════════════
  // GET CURRENT USER (Splash screen check)
  //
  // Returns AppUser if: signed in + email verified + Firestore doc exists.
  // Returns null otherwise (→ LoginScreen).
  //
  // ★ If signed in but NOT verified: signs out and returns null.
  //   (User must log in again; LoginScreen will show the resend option.)
  // ══════════════════════════════════════════════════════════════
  Future<AppUser?> getCurrentUser() async {
    debugPrint('[Auth][Splash] Checking current user...');
    final User? firebaseUser = _auth.currentUser;

    if (firebaseUser == null) {
      debugPrint('[Auth][Splash] No signed-in user → LoginScreen');
      return null;
    }

    debugPrint('[Auth][Splash] Found signed-in user: ${firebaseUser.email}');
    debugPrint('[Auth][Splash] emailVerified (cached) = ${firebaseUser.emailVerified}');

    // Reload to get the freshest emailVerified value
    try {
      await firebaseUser.reload();
    } catch (e) {
      debugPrint('[Auth][Splash] reload() failed: $e');
    }

    final User? refreshed = _auth.currentUser;
    final bool verified = refreshed?.emailVerified ?? false;
    debugPrint('[Auth][Splash] emailVerified (after reload) = $verified');

    if (!verified) {
      // User is signed in but email not yet verified.
      // Sign them out so they go through LoginScreen normally.
      debugPrint('[Auth][Splash] Email NOT verified → signing out → LoginScreen');
      await _auth.signOut();
      return null;
    }

    // Force token refresh before reading Firestore
    try {
      await refreshed!.getIdToken(true);
      debugPrint('[Auth][Splash] Token refreshed ✓');
    } catch (e) {
      debugPrint('[Auth][Splash] Token refresh failed: $e');
    }

    try {
      final docSnap =
          await _firestore.collection('users').doc(refreshed!.uid).get();
      if (!docSnap.exists) {
        debugPrint('[Auth][Splash] Firestore doc missing → LoginScreen');
        return null;
      }
      final data = docSnap.data() as Map<String, dynamic>;
      final appUser = AppUser.fromMap(data, refreshed.uid);
      debugPrint('[Auth][Splash] User loaded: ${appUser.name} → HomeScreen ✓');
      return appUser;
    } catch (e) {
      debugPrint('[Auth][Splash] Firestore fetch EXCEPTION: $e');
      return null;
    }
  }
}
