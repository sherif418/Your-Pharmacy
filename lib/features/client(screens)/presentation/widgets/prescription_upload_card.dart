// prescription_upload_card.dart
// Responsible for: rendering the prescription upload action card.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/dashboard_card.dart';

class PrescriptionUploadCard extends StatelessWidget {
  const PrescriptionUploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.receipt_long_rounded,
              color: AppColors.primary, size: 22),
          const SizedBox(height: AppSizes.spaceSM),
          const Text(AppStrings.homePrescriptionPrompt,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: AppSizes.spaceXXS),
          const Text(AppStrings.homePrescriptionDescription,
              style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.smallButtonPaddingVertical),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.smallButtonRadius)),
              ),
              icon: const Icon(Icons.camera_alt_rounded,
                  size: 14, color: Colors.white),
              label: const Text(AppStrings.homeUploadNow,
                  style: TextStyle(fontSize: 11, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
