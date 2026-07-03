// auth_event.dart
// Responsible for: defining all possible events (user actions) that the AuthBloc can receive.
// Each event represents one thing the user or app can trigger related to authentication.

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// ── Login ─────────────────────────────────────────────────
/// Fired when the user submits the login form.
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// ── Register ──────────────────────────────────────────────
/// Fired when the user submits the registration form.
class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  /// 'customer' or 'pharmacist'
  final String role;
  final String village;

  const AuthRegisterRequested({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.village,
  });

  @override
  List<Object?> get props => [name, email, phone, password, role, village];
}

// ── Logout ────────────────────────────────────────────────
/// Fired when the user taps the logout button.
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

// ── Check Status ──────────────────────────────────────────
/// Fired on app start to check if a user session already exists.
class AuthCheckStatus extends AuthEvent {
  const AuthCheckStatus();
}
