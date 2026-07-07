// app_colors.dart
// Responsible for: holding ALL colors used across the app.
// Rule: Never write a Color value directly in a screen or widget — always use this file.

import 'package:flutter/material.dart';

class AppColors {
  // ── Primary Palette ───────────────────────────────────────
  /// Main brand color — Sea Green, used for buttons, headers, and accents.
  static const Color primary = Color(0xFF2E8B57);

  /// Slightly lighter shade of primary, used for hover/pressed states.
  static const Color primaryLight = Color(0xFF3CB371);

  /// Used for secondary accents (e.g., badge highlights).
  static const Color secondary = Color(0xFFF59E0B);

  // ── Background & Surface ──────────────────────────────────
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFF1F5F9);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // ── Text ─────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF2E8B57);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  // Added muted text color for subtle hints
  static const Color textMuted = Color(0xFF6B7280);
  // Alias accent to secondary for backward compatibility
  static const Color accent = secondary;

  // ── Status Colors ─────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF97316);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ── Order Status Badge Colors ─────────────────────────────
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusPreparing = Color(0xFF3B82F6);
  static const Color statusReady = Color(0xFF22C55E);
  static const Color statusDelivered = Color(0xFF2E8B57);
  static const Color statusCancelled = Color(0xFFEF4444);

  // ── Border & Divider ─────────────────────────────────────
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFE2E8F0);

  // ── Overlay & Shadow ──────────────────────────────────────
  static const Color shadow = Color(0x0F000000);
}
