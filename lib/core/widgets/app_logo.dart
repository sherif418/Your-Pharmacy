// app_logo.dart
// Responsible for: displaying the Sidleitak app logo consistently across screens
// (splash, login, register). Size is controlled via AppSizes — never hardcoded.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';

class AppLogo extends StatelessWidget {
  /// Controls how large the logo icon appears.
  final double size;

  /// When true, also shows the app name text below the icon.
  final bool showName;

  const AppLogo({
    super.key,
    this.size = AppSizes.logoSizeMD,
    this.showName = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Logo Icon ──────────────────────────────────────
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(size * 0.25),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.local_pharmacy_rounded,
            color: AppColors.textOnPrimary,
            size: size * 0.55,
          ),
        ),

        // ── App Name ───────────────────────────────────────
        if (showName) ...[
          const SizedBox(height: AppSizes.spaceSM),
          Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: size * 0.22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            AppStrings.appTagline,
            style: TextStyle(
              fontSize: size * 0.12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
