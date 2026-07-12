// auth_bloc.dart
// Responsible for: managing all authentication logic for the app.
// Handles login, registration, logout, email verification, and session checks.
// Uses AuthRepository to talk to Firebase — the BLoC itself has NO Firebase imports.

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/errors/app_exceptions.dart';
import 'package:flutter_application_1/features/auth/data/auth_repository.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthEmailVerificationCheck>(_onEmailVerificationCheck);
    on<AuthResendVerificationEmail>(_onResendVerificationEmail);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
  }

  // ── Login ────────────────────────────────────────────────
  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final AppUser user = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user: user));
    } on EmailNotVerifiedException {
      // signIn() already called signOut() before throwing
      emit(AuthLoginEmailNotVerified(
        email: event.email,
        password: event.password,
      ));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // ── Register ─────────────────────────────────────────────
  /// Creates account + sends verification email. Does NOT write to Firestore.
  Future<void> _onRegisterRequested(
      AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final AppUser pendingUser = await _authRepository.register(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
        role: event.role,
        village: event.village,
      );
      // Signal UI to navigate to EmailVerificationScreen
      emit(AuthEmailVerificationSent(pendingUser: pendingUser));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // ── Email Verification Check ──────────────────────────────
  /// User pressed "تحققت": reload → check → save to Firestore if verified.
  Future<void> _onEmailVerificationCheck(
      AuthEmailVerificationCheck event, Emitter<AuthState> emit) async {
    debugPrint("[AuthBloc][VerificationCheck] Started for: ${event.pendingUser.email}");
    emit(AuthLoading());
    try {
      final bool verified = await _authRepository.reloadAndCheckVerified();
      if (verified) {
        debugPrint("[AuthBloc][VerificationCheck] Email is verified! Saving to Firestore...");
        try {
          await _authRepository.saveUserToFirestore(event.pendingUser);
          debugPrint("[AuthBloc][VerificationCheck] Firestore creation/check success ✓");
        } catch (dbError) {
          debugPrint("[AuthBloc][VerificationCheck] Firestore failed, but email is verified. Error: $dbError");
          // ★ Do not propagate AuthError after successful verification.
        }
        emit(AuthAuthenticated(user: event.pendingUser));
      } else {
        debugPrint("[AuthBloc][VerificationCheck] Email NOT verified yet.");
        emit(AuthEmailNotVerified());
      }
    } catch (e) {
      debugPrint("[AuthBloc][VerificationCheck] Error: $e");
      emit(AuthError(message: e.toString()));
    }
  }

  // ── Resend Verification Email ─────────────────────────────
  Future<void> _onResendVerificationEmail(
      AuthResendVerificationEmail event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.resendVerificationEmail();
      emit(AuthResendVerificationSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // ── Logout ───────────────────────────────────────────────
  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(AuthUnauthenticated());
  }

  // ── Check Status ─────────────────────────────────────────
  Future<void> _onCheckStatus(
      AuthCheckStatus event, Emitter<AuthState> emit) async {
    final authStatus = await _authRepository.checkCurrentAuthStatus();
    switch (authStatus.type) {
      case AuthCheckResultType.verified:
        emit(AuthAuthenticated(user: authStatus.user!));
        break;
      case AuthCheckResultType.pendingVerification:
        emit(AuthPendingEmailVerification(pendingUser: authStatus.user!));
        break;
      case AuthCheckResultType.unauthenticated:
        emit(AuthUnauthenticated());
        break;
    }
  }
}
