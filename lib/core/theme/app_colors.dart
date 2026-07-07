// lib/core/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Primary brand color
  static const Color primary = Color(0xFF4A90E2);
  // Secondary brand color (added)
  static const Color secondary = Color(0xFF62B4F9);
  // Text color on primary background
  static const Color textOnPrimary = Colors.white;
  // Accent color for highlights, links, etc.
  static const Color accent = Color(0xFF62B4F9);
  // General text color
  static const Color text = Color(0xFF212121);
  // Muted text color
  static const Color textMuted = Color(0xFF757575);
  // Hint text color for inputs
  static const Color textHint = Color(0xFF9E9E9E);
  // Background surface color
  static const Color background = Color(0xFFF5F5F5);
  // Card background color
  static const Color cardBackground = Colors.white;
  // Alias for card background (added for compatibility)
  static const Color cards = cardBackground;
  // Divider color
  static const Color divider = Color(0xFFBDBDBD);
  // Border color for inputs and cards
  static const Color border = Color(0xFFE0E0E0);
  // Surface color used in input fields
  static const Color surface = Colors.white;
  // Error color
  static const Color error = Colors.redAccent;
}
