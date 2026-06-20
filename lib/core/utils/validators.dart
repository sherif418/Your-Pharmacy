// validators.dart
// Responsible for: providing all form validation functions used across auth and order forms.
// Each function returns null when the value is valid, or a string error message when invalid.
// All error strings come from AppStrings — no hardcoded text here.

import 'package:flutter_application_1/core/constants/app_strings.dart';

class Validators {
  // ── Email ─────────────────────────────────────────────────
  /// Returns an error string if the email is empty or not a valid email format.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorEmptyField;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.errorInvalidEmail;
    }
    return null;
  }

  // ── Password ──────────────────────────────────────────────
  /// Returns an error string if the password is fewer than 6 characters.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorEmptyField;
    }
    if (value.length < 6) {
      return AppStrings.errorWeakPassword;
    }
    return null;
  }

  // ── Confirm Password ──────────────────────────────────────
  /// Returns an error string if confirmPassword does not match password.
  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return AppStrings.errorEmptyField;
      }
      if (value != password) {
        return AppStrings.errorPasswordMismatch;
      }
      return null;
    };
  }

  // ── Required Field ────────────────────────────────────────
  /// Generic non-empty validator for any required text field.
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorEmptyField;
    }
    return null;
  }
}
