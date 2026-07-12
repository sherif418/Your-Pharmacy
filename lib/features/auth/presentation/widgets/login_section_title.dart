import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

/// Title banner with matching icon and horizontal divider for forms on the LoginScreen.
class LoginSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const LoginSectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 16),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.border.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
