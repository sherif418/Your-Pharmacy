// app_snackbar.dart
// Responsible for: centralizing snack bar presentation and styling across the app.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class AppSnackbar {
  static void showError(BuildContext context, String message) {
    _showSnackbar(context, message, backgroundColor: AppColors.error);
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(context, message, backgroundColor: AppColors.success);
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackbar(context, message, backgroundColor: AppColors.info);
  }

  static void _showSnackbar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
