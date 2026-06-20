// auth_state.dart
// Responsible for: defining all possible states that the AuthBloc can emit.
// The UI listens to these states to decide what to show (loading, error, logged in, etc.).

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
/// Emitted when the user is successfully signed in.
/// Carries the signed-in [user] so the UI can read name, role, etc.
class AuthAuthenticated extends AuthState {
  final AppUser user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

// ── Register Success ──────────────────────────────────────
/// Emitted when registration succeeds (before auto-login redirect).
class AuthRegisterSuccess extends AuthState {
  final AppUser user;
  const AuthRegisterSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

// ── Unauthenticated ───────────────────────────────────────
/// Emitted when the user is not signed in (or after logout).
class AuthUnauthenticated extends AuthState {}

// ── Error ─────────────────────────────────────────────────
/// Emitted when an auth operation fails.
/// The [message] contains a human-readable error description.
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
