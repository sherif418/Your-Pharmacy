// loading_indicator.dart
// Responsible for: showing a centered circular loading spinner used across all screens
// whenever an async operation is in progress (e.g., fetching orders, signing in).

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  /// Optional color override — defaults to the primary brand color.
  final Color color;

  /// Optional size override for the spinner stroke width.
  final double strokeWidth;

  const LoadingIndicator({
    super.key,
    this.color = AppColors.primary,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
