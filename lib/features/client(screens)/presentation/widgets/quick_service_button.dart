// quick_service_button.dart
// Responsible for: rendering a small circular quick action button.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';

class QuickServiceButton extends StatelessWidget {
  /// Icon displayed inside the button.
  final IconData icon;

  /// The text label shown below the icon.
  final String label;

  /// Callback when the button is tapped.
  final VoidCallback? onTap;

  const QuickServiceButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.spaceMD),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          width: AppSizes.quickServiceButtonWidth,
          child: Column(
            children: [
              Container(
                width: AppSizes.quickServiceIconSize,
                height: AppSizes.quickServiceIconSize,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 6,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Icon(icon, color: AppColors.primary, size: AppSizes.iconLG),
              ),
              const SizedBox(height: AppSizes.spaceXS),
              Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10.5, color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}
