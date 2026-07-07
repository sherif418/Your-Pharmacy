import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// شعار التطبيق + العنوان الفرعي
class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.eco_rounded, color: AppColors.secondary, size: size),
            Positioned(
              bottom: 0,
              child: Icon(Icons.local_pharmacy_rounded,
                  color: AppColors.primary, size: size * 0.55),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'صيدليتك',
          style: TextStyle(
            fontSize: size * 0.5,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'خدمات دوائية موثوقة لأهالي قرية بساط',
          style: TextStyle(fontSize: 13, color: AppColors.textMuted),
        ),
      ],
    );
  }
}
