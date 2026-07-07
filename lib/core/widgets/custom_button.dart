// custom_button.dart
// Responsible for: providing a reusable, styled primary button used across all screens.
// Use this instead of ElevatedButton directly so the look stays consistent app-wide.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  /// The text displayed on the button.
  final String label;

  /// Callback executed when the button is pressed.
  final VoidCallback? onPressed;

  /// When true, shows a loading spinner and disables the button.
  final bool isLoading;

  /// Optional: override the button width (defaults to full width).
  final double? width;

  /// Optional icon to display alongside the label.
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: AppSizes.iconMD,
                height: AppSizes.iconMD,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : (icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: AppSizes.iconMD, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(label),
                    ],
                  )
                : Text(label)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
