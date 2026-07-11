// today_schedule_card.dart
// Responsible for: rendering the day's schedule card with status indicators.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/domain/home_models.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/dashboard_card.dart';

class TodayScheduleCard extends StatelessWidget {
  /// The schedule items shown in the card.
  final List<ScheduleItem> items;

  /// The title displayed at the top of the card.
  final String title;

  /// The icon displayed next to the title.
  final IconData icon;

  const TodayScheduleCard({
    super.key,
    required this.items,
    this.title = AppStrings.homeTodayScheduleTitle,
    this.icon = Icons.calendar_today_rounded,
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
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: AppSizes.spaceSM),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spaceSM),
                child: Row(
                  children: [
                    Icon(
                      item.done
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                      size: AppSizes.iconLG,
                      color: item.done ? AppColors.primary : AppColors.border,
                    ),
                    const SizedBox(width: AppSizes.spaceMD),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary)),
                          Text(item.subtitle,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    Text(item.time,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
