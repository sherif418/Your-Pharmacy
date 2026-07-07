// app_notice.dart
// Simple notice widget for informational or warning messages.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class AppNotice extends StatelessWidget {
  final String text;
  final bool isWarning;

  const AppNotice({
    super.key,
    required this.text,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isWarning ? AppColors.warning : AppColors.info;
    final textColor = AppColors.textOnPrimary;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
