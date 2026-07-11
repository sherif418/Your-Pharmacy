// health_summary_card.dart
// Responsible for: rendering a health summary card with metric rows.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/domain/home_models.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/dashboard_card.dart';

class HealthSummaryCard extends StatelessWidget {
  /// The list of health metric rows shown in the card.
  final List<HealthMetric> metrics;

  /// The title displayed at the top of the card.
  final String title;

  /// The icon displayed next to the title.
  final IconData icon;

  const HealthSummaryCard({
    super.key,
    required this.metrics,
    this.title = AppStrings.homeHealthSummaryTitle,
    this.icon = Icons.health_and_safety_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: AppSizes.iconSM),
              const SizedBox(width: AppSizes.spaceXS2),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceSM),
          ...metrics.map((metric) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spaceXS),
                child: Row(
                  children: [
                    Icon(
                      metric.isHealthy
                          ? Icons.check_circle_rounded
                          : Icons.error_rounded,
                      color: metric.isHealthy ? AppColors.primary : AppColors.warning,
                      size: AppSizes.iconSM,
                    ),
                    const SizedBox(width: AppSizes.spaceXS2),
                    Expanded(
                      child: Text(metric.value,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: metric.isHealthy
                                  ? AppColors.primary
                                  : AppColors.warning)),
                    ),
                    Text(metric.label,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
