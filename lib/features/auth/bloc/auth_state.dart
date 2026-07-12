// auth_state.dart
// Responsible for: defining all possible states that the AuthBloc can emit.

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// ── Initial ───────────────────────────────────────────────
/// Default state before any auth check has been performed.
class AuthInitial extends AuthState {}

// ── Loading ───────────────────────────────────────────────
/// Emitted while a login, register, or logout operation is in progress.
class AuthLoading extends AuthState {}

// ── Authenticated ─────────────────────────────────────────
/// Emitted when the user is successfully signed in AND email is verified.
class AuthAuthenticated extends AuthState {
  final AppUser user;
  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

// ── Email Verification Sent ───────────────────────────────
/// Emitted after registration: account created, verification email sent.
/// Carries [pendingUser] (not yet in Firestore) so the screen can pass it
/// to the EmailVerificationScreen.
class AuthEmailVerificationSent extends AuthState {
  final AppUser pendingUser;
  const AuthEmailVerificationSent({required this.pendingUser});

  @override
  List<Object?> get props => [pendingUser];
}

/// Emitted when the app launches and the user is signed in but email is
/// still awaiting verification.
class AuthPendingEmailVerification extends AuthState {
  final AppUser pendingUser;
  const AuthPendingEmailVerification({required this.pendingUser});

  @override
  List<Object?> get props => [pendingUser];
}



// ── Email Not Verified ────────────────────────────────────
/// Emitted when the user pressed "تحققت" but email is still not verified.
class AuthEmailNotVerified extends AuthState {}

// ── Email Not Verified (Login) ────────────────────────────
/// Emitted during login when the user's email is not yet verified.
/// The UI should show a SnackBar with a "resend" action.
class AuthLoginEmailNotVerified extends AuthState {
  final String email;
  final String password;
  const AuthLoginEmailNotVerified({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// ── Resend Success ────────────────────────────────────────
/// Emitted when a verification email was successfully resent.
class AuthResendVerificationSuccess extends AuthState {}

// ── Unauthenticated ───────────────────────────────────────
/// Emitted when the user is not signed in (or after logout).
class AuthUnauthenticated extends AuthState {}

// ── Error ─────────────────────────────────────────────────
/// Emitted when an auth operation fails.
class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
