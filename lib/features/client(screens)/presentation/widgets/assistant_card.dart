// assistant_card.dart
// Responsible for: rendering the health assistant card.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/dashboard_card.dart';

class AssistantCard extends StatelessWidget {
  const AssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSizes.iconXL,
            height: AppSizes.iconXL,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_rounded,
                color: AppColors.primary, size: 18),
          ),
          const SizedBox(height: AppSizes.spaceSM),
          const Text(AppStrings.homeHealthAssistantTitle,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: AppSizes.spaceXXS),
          const Text(AppStrings.homeHealthAssistantPrompt,
              style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                padding:
                    const EdgeInsets.symmetric(vertical: AppSizes.smallButtonPaddingVertical),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.smallButtonRadius)),
              ),
              child: const Text(AppStrings.homeTalkToAssistant,
                  style: TextStyle(fontSize: 11, color: AppColors.primary)),
            ),
          ),
        ],
      ),
    );
  }
}
