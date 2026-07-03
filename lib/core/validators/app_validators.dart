import 'package:flutter_application_1/core/constants/app_strings.dart';

class AppValidators {
  // ── Name Validator ─────────────────────────────────────────
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorEmptyField;
    }
    if (value.trim().length < 3) {
      return AppStrings.errorShortName;
    }
    return null;
  }

  // ── Email Validator ────────────────────────────────────────
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorEmptyField;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppStrings.errorInvalidEmail;
    }
    return null;
  }

  // ── Phone Validator ────────────────────────────────────────
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorEmptyField;
    }
    final phoneRegex = RegExp(r'^01[0-9]{9}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return AppStrings.errorInvalidPhone;
    }
    return null;
  }

  // ── Password Validator ─────────────────────────────────────
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorEmptyField;
    }
    if (value.length < 6) {
      return AppStrings.errorWeakPassword;
    }
    return null;
  }

  // ── Confirm Password Validator ─────────────────────────────
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.errorEmptyField;
    }
    if (value != password) {
      return AppStrings.errorPasswordMismatch;
    }
    return null;
  }

  // ── Required Field Validator ───────────────────────────────
  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorEmptyField;
    }
    return null;
  }
}
