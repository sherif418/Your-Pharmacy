// tip_of_the_day_card.dart
// Responsible for: rendering the tip of the day card.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/dashboard_card.dart';

class TipOfTheDayCard extends StatelessWidget {
  /// The tip text to display.
  final String tip;

  const TipOfTheDayCard({
    super.key,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_rounded, color: AppColors.warning, size: 22),
          const SizedBox(height: AppSizes.spaceSM),
          const Text(AppStrings.homeTipOfTheDayTitle,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: AppSizes.spaceXXS),
          Expanded(
            child: Text(tip,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textSecondary)),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.homeShowMore,
                style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
