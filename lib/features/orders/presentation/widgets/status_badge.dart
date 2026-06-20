// status_badge.dart
// Responsible for: displaying a colored pill-shaped badge that shows an order's current status.
// Used inside OrderCard and OrderDetailScreen — never duplicated inline.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';

class StatusBadge extends StatelessWidget {
  /// The raw status string stored in Firestore:
  /// 'pending' | 'preparing' | 'ready' | 'delivered' | 'cancelled'
  final String status;

  const StatusBadge({super.key, required this.status});

  // ── Map status key → display label ────────────────────────
  String get _label {
    switch (status) {
      case 'pending':
        return AppStrings.orderStatusPending;
      case 'preparing':
        return AppStrings.orderStatusPreparing;
      case 'ready':
        return AppStrings.orderStatusReady;
      case 'delivered':
        return AppStrings.orderStatusDelivered;
      case 'cancelled':
        return AppStrings.orderStatusCancelled;
      default:
        return status;
    }
  }

  // ── Map status key → badge background color ───────────────
  Color get _color {
    switch (status) {
      case 'pending':
        return AppColors.statusPending;
      case 'preparing':
        return AppColors.statusPreparing;
      case 'ready':
        return AppColors.statusReady;
      case 'delivered':
        return AppColors.statusDelivered;
      case 'cancelled':
        return AppColors.statusCancelled;
      default:
        return AppColors.textHint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spaceSM,
        vertical: AppSizes.spaceXXS,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusCircle),
        border: Border.all(color: _color, width: 1),
      ),
      child: Text(
        _label,
        style: TextStyle(
          color: _color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
