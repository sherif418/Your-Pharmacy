// chronic_med_card.dart
// Responsible for: displaying one chronic medication entry in a card row.
// Used in the ChronicMedsScreen list — never duplicated inline.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';

class ChronicMedCard extends StatelessWidget {
  /// The medicine name to display.
  final String medicineName;

  /// The dose string (e.g. "500mg twice daily").
  final String dose;

  /// Callback when the delete icon is tapped.
  final VoidCallback? onDelete;

  const ChronicMedCard({
    super.key,
    required this.medicineName,
    required this.dose,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spaceSM),
      padding: const EdgeInsets.all(AppSizes.paddingCard),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Icon ────────────────────────────────────────
          const Icon(
            Icons.favorite_rounded,
            color: AppColors.primary,
            size: AppSizes.iconLG,
          ),
          const SizedBox(width: AppSizes.spaceMD),

          // ── Med info ─────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicineName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceXXS),
                Text(
                  dose,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // ── Delete button ────────────────────────────────
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppColors.error,
              iconSize: AppSizes.iconMD,
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}
