import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';

/// Renders the three-dot loader, status message, and bottom icons for the SplashScreen.
class SplashDotsLoader extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> dotScale1;
  final Animation<double> dotScale2;
  final Animation<double> dotScale3;
  final String statusMessage;

  const SplashDotsLoader({
    super.key,
    required this.animationController,
    required this.dotScale1,
    required this.dotScale2,
    required this.dotScale3,
    required this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Custom three-dot loader
            AnimatedBuilder(
              animation: animationController,
              builder: (context, _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ScaleTransition(
                      scale: dotScale1,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ScaleTransition(
                      scale: dotScale2,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ScaleTransition(
                      scale: dotScale3,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSizes.spaceLG),
            // changing status text
            Text(
              statusMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: AppSizes.spaceLG),
            // Village landscape styled icon row
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_work_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.directions_bike_rounded,
                  color: AppColors.secondary,
                  size: 24,
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.local_hospital_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
