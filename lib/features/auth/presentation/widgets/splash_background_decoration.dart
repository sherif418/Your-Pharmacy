import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

/// Renders the animated decorative background blobs for the SplashScreen.
class SplashBackgroundDecoration extends StatelessWidget {
  final AnimationController animationController;

  const SplashBackgroundDecoration({
    super.key,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, _) {
                  return Opacity(
                    opacity: 0.08,
                    child: Container(
                      margin: const EdgeInsets.only(left: 40, top: 40),
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(140),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            blurRadius: 48,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, _) {
                  return Opacity(
                    opacity: 0.06,
                    child: Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 80),
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(180),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondary.withValues(alpha: 0.06),
                            blurRadius: 80,
                            spreadRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
