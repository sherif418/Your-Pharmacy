// percent_ring_card.dart
// Responsible for: rendering a compact percentage ring card used on the dashboard.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/dashboard_card.dart';

class PercentRingCard extends StatelessWidget {
  /// The title displayed for the metric.
  final String title;

  /// The progress value between 0 and 1.
  final double percent;

  /// The short caption beneath the percentage.
  final String caption;

  /// The footer text shown at the bottom.
  final String footer;

  const PercentRingCard({
    super.key,
    required this.title,
    required this.percent,
    required this.caption,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.shield_moon_rounded,
                  color: AppColors.primary, size: AppSizes.iconSM),
              const SizedBox(width: AppSizes.spaceXXS),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceSM),
          SizedBox(
            width: AppSizes.progressCircleSize,
            height: AppSizes.progressCircleSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: percent,
                  strokeWidth: 6,
                  backgroundColor: AppColors.border,
                  valueColor:
                      const AlwaysStoppedAnimation(AppColors.primary),
                ),
                Text('${(percent * 100).round()}%',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceSM),
          Text(caption,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
          const SizedBox(height: AppSizes.spaceXXS),
          Text(footer,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 10, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
