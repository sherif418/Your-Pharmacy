import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';

/// Renders the animated logo with a pulsing glow behind it on the SplashScreen.
class SplashLogoGlow extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<double> translateAnimation;
  final Animation<double> scaleAnimation;
  final Animation<double> glowAnimation;

  const SplashLogoGlow({
    super.key,
    required this.fadeAnimation,
    required this.translateAnimation,
    required this.scaleAnimation,
    required this.glowAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fadeAnimation,
        child: AnimatedBuilder(
          animation: translateAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, translateAnimation.value),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // pulsing glow behind logo
                    Container(
                      width: AppSizes.logoSizeLG * 1.6,
                      height: AppSizes.logoSizeLG * 1.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: glowAnimation.value),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: glowAnimation.value),
                            blurRadius: 36,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    child!,
                  ],
                ),
              ),
            );
          },
          child: Image.asset(
            'assets/images/splash_image.png',
            width: AppSizes.logoSizeLG,
            height: AppSizes.logoSizeLG,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
