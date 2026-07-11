// circle_icon_button.dart
// Responsible for: rendering a rounded icon button used in the dashboard header.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';

class CircleIconButton extends StatelessWidget {
  /// The icon shown inside the button.
  final IconData icon;

  /// Called when the button is tapped.
  final VoidCallback onTap;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.iconLG),
      child: Container(
        width: AppSizes.circleIconButtonSize,
        height: AppSizes.circleIconButtonSize,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadow, blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Icon(icon, color: AppColors.primary, size: AppSizes.iconMD),
      ),
    );
  }
}
