// app_colors.dart
// Responsible for: holding ALL colors used across the app.
// Rule: Never write a Color value directly in a screen or widget — always use this file.

import 'package:flutter/material.dart';

class AppColors {
  // ── Primary Palette ───────────────────────────────────────
  /// Main brand color — deep teal green, used for buttons, headers, and accents.
  static const Color primary = Color(0xFF004643);

  /// Slightly lighter shade of primary, used for hover/pressed states.
  static const Color primaryLight = Color(0xFF006B65);

  /// Used for secondary accents (e.g., badge highlights).
  static const Color secondary = Color(0xFFABD1C6);

  // ── Background & Surface ──────────────────────────────────
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // ── Text ─────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF004643);
  static const Color textHint = Color(0xFFC4C4C4);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ── Status Colors ─────────────────────────────────────────
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFB71C1C);
  static const Color info = Color(0xFF01579B);

  // ── Order Status Badge Colors ─────────────────────────────
  static const Color statusPending = Color(0xFFF9A825);
  static const Color statusPreparing = Color(0xFF01579B);
  static const Color statusReady = Color(0xFF2E7D32);
  static const Color statusDelivered = Color(0xFF004643);
  static const Color statusCancelled = Color(0xFFB71C1C);

  // ── Border & Divider ─────────────────────────────────────
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // ── Overlay & Shadow ──────────────────────────────────────
  static const Color shadow = Color(0x1A000000);
}
