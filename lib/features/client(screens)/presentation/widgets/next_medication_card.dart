// next_medication_card.dart
// Responsible for: rendering the next medication or next order card on the home dashboard.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';

class NextMedicationCard extends StatelessWidget {
  /// The title shown for the next item.
  final String title;

  /// The scheduled time or order label.
  final String time;

  /// The subtitle shown under the title.
  final String subtitle;

  /// Progress value between 0 and 1.
  final double progress;

  /// Icon displayed inside the circular progress indicator.
  final IconData icon;

  const NextMedicationCard({
    super.key,
    required this.title,
    required this.time,
    required this.subtitle,
    required this.progress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingCard),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: const [
          BoxShadow(color: AppColors.shadow, blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSizes.spaceXS2),
                Text(time,
                    style: const TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: AppSizes.spaceXXS),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.secondary, fontSize: 12)),
                const SizedBox(height: AppSizes.spaceSM),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.whiteFaded,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.smallButtonPaddingHorizontal,
                        vertical: AppSizes.smallButtonPaddingVertical),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.smallButtonRadius)),
                  ),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 12, color: Colors.white),
                  label: const Text(AppStrings.homeViewAll,
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppSizes.progressCircleSize,
            height: AppSizes.progressCircleSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: Colors.white.withOpacity(0.25),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
                Icon(icon, color: Colors.white, size: AppSizes.iconXXL),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
