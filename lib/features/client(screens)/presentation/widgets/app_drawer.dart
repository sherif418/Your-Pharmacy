// app_drawer.dart
// Responsible for: rendering the home screen drawer UI.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';

class AppDrawer extends StatelessWidget {
  /// The current authenticated user shown inside the drawer.
  final AppUser user;

  /// Logout callback triggered by the logout list tile.
  final VoidCallback onLogout;

  const AppDrawer({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.paddingCard),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: AppSizes.avatarMD / 2,
                    backgroundColor: AppColors.secondary,
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name,
                            style: const TextStyle(
                              color: AppColors.textOnPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        Text(
                          user.role == 'pharmacist'
                              ? AppStrings.homeRolePharmacist
                              : AppStrings.homeRoleCustomer,
                          style: const TextStyle(
                              color: AppColors.secondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),
            ListTile(
              leading: const Icon(Icons.person_outline, color: AppColors.primary),
              title: const Text(AppStrings.profile),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: AppColors.primary),
              title: const Text(AppStrings.settings),
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: AppColors.error),
              title: const Text(AppStrings.logout,
                  style: TextStyle(color: AppColors.error)),
              onTap: onLogout,
            ),
            const SizedBox(height: AppSizes.spaceMD),
          ],
        ),
      ),
    );
  }
}
