// chronic_disease_card.dart
// Responsible for: rendering the chronic disease summary card.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/domain/home_models.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/dashboard_card.dart';

class ChronicDiseaseCard extends StatelessWidget {
  /// The chronic disease details shown in the card.
  final ChronicDiseaseData disease;

  const ChronicDiseaseCard({
    super.key,
    required this.disease,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSizes.categoryChipSize,
            height: AppSizes.categoryChipSize,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.medication_liquid_rounded,
                color: AppColors.primary, size: AppSizes.iconLG),
          ),
          const SizedBox(width: AppSizes.spaceMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppStrings.homeHealthSummaryTitle,
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSizes.spaceXXS),
                Text(disease.diseaseName,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
                const SizedBox(height: AppSizes.spaceXS2),
                Text('${disease.medicineName}  •  ${disease.time}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: AppSizes.spaceSM),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.smallButtonPaddingHorizontal,
                          vertical: AppSizes.spaceXXS),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            disease.reminderEnabled
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                            size: AppSizes.iconSM,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSizes.spaceXXS),
                          const Text(AppStrings.homeReminderEnabled,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceSM),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSizes.smallButtonPaddingVertical),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.smallButtonRadius)),
                        ),
                        child: const Text(AppStrings.homeManageReminders,
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textPrimary)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
