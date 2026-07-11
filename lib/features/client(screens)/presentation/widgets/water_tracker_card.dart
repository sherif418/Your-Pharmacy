// water_tracker_card.dart
// Responsible for: rendering the water tracker card with an action button.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/dashboard_card.dart';

class WaterTrackerCard extends StatelessWidget {
  /// Number of cups consumed so far.
  final int cups;

  /// Daily goal number of cups.
  final int goal;

  /// Called when the user taps to log a new cup.
  final VoidCallback onAddCup;

  const WaterTrackerCard({
    super.key,
    required this.cups,
    required this.goal,
    required this.onAddCup,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.water_drop_rounded, color: AppColors.info, size: 22),
          const SizedBox(height: AppSizes.spaceSM),
          const Text(AppStrings.homeWaterTrackerTitle,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: AppSizes.spaceXXS),
          Text('$cups / $goal ${AppStrings.homeWaterCupCount}',
              style: const TextStyle(
                  fontSize: 10.5, color: AppColors.textSecondary)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAddCup,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.info,
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.smallButtonPaddingVertical),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSizes.smallButtonRadius)),
              ),
              child: const Text(AppStrings.homeLogWaterCup,
                  style: TextStyle(fontSize: 11, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
