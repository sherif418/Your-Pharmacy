// app_sizes.dart
// Responsible for: holding ALL fixed spacing and size values used across the app.
// Rule: Never hardcode a number like SizedBox(height: 16) or padding: 12 in a screen —
//       always reference a constant from this file instead.

class AppSizes {
  // ── Spacing ───────────────────────────────────────────────
  static const double spaceXXS = 4.0;
  static const double spaceXS = 8.0;
  static const double spaceSM = 12.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;
  static const double spaceHuge = 64.0;

  // ── Padding ───────────────────────────────────────────────
  /// Standard horizontal screen padding.
  static const double paddingHorizontal = 20.0;

  /// Standard vertical screen padding.
  static const double paddingVertical = 16.0;

  /// Padding inside cards.
  static const double paddingCard = 16.0;

  // ── Border Radius ─────────────────────────────────────────
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircle = 100.0;

  // ── Icon Sizes ────────────────────────────────────────────
  static const double iconSM = 18.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;

  // ── Button ────────────────────────────────────────────────
  static const double buttonHeight = 52.0;
  static const double buttonRadius = 12.0;

  // ── Text Field ────────────────────────────────────────────
  static const double textFieldHeight = 56.0;
  static const double textFieldRadius = 12.0;

  // ── App Bar ───────────────────────────────────────────────
  static const double appBarHeight = 60.0;

  // ── Logo ──────────────────────────────────────────────────
  static const double logoSizeSM = 60.0;
  static const double logoSizeMD = 100.0;
  static const double logoSizeLG = 140.0;

  // ── Card ──────────────────────────────────────────────────
  static const double cardElevation = 2.0;
  static const double cardRadius = 16.0;

  // ── Avatar ────────────────────────────────────────────────
  static const double avatarSM = 36.0;
  static const double avatarMD = 52.0;
  static const double avatarLG = 80.0;
}
