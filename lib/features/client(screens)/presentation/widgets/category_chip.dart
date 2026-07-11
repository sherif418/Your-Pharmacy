// category_chip.dart
// Responsible for: rendering a horizontal category chip used in the home dashboard.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';

class CategoryChip extends StatelessWidget {
  /// The icon displayed in the chip.
  final IconData icon;

  /// The label text displayed below the icon.
  final String label;

  const CategoryChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.spaceMD),
      child: Column(
        children: [
          Container(
            width: AppSizes.categoryChipSize,
            height: AppSizes.categoryChipSize,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: AppSizes.iconLG),
          ),
          const SizedBox(height: AppSizes.spaceSM),
          Text(label,
              style: const TextStyle(
                  fontSize: 10.5, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
