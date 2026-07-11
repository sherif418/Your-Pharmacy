// dashboard_header.dart
// Responsible for: rendering the top greeting header for the home dashboard.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/widgets/circle_icon_button.dart';

class DashboardHeader extends StatelessWidget {
  /// The authenticated user shown in the greeting.
  final AppUser user;

  /// The number of unread or new notifications.
  final int notifCount;

  const DashboardHeader({
    super.key,
    required this.user,
    this.notifCount = 0,
  });

  String get _greetingWord {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'صباح الخير';
    return 'مساء الخير';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) => CircleIconButton(
            icon: Icons.menu_rounded,
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        const SizedBox(width: AppSizes.spaceMD),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('👋 $_greetingWord',
                  style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: AppSizes.spaceXXXS),
              Text('${AppStrings.homeGreeting} ${user.name}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary)),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleIconButton(
              icon: Icons.notifications_none_rounded,
              onTap: () {},
            ),
            if (notifCount > 0)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.spaceXXS),
                  decoration: const BoxDecoration(
                      color: AppColors.error, shape: BoxShape.circle),
                  constraints: const BoxConstraints(
                      minWidth: AppSizes.badgeDiameter,
                      minHeight: AppSizes.badgeDiameter),
                  child: Text(
                    '$notifCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: AppSizes.spaceSM),
        CircleAvatar(
          radius: AppSizes.avatarMD / 2,
          backgroundColor: AppColors.secondary,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
