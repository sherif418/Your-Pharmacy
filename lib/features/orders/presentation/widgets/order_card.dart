// order_card.dart
// Responsible for: rendering one order summary row inside the MyOrders list.
// Reused in both the customer's MyOrders screen and the pharmacist's order list.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/features/orders/data/order_model.dart';
import 'package:flutter_application_1/features/orders/presentation/widgets/status_badge.dart';

class OrderCard extends StatelessWidget {
  /// The order data to display.
  final OrderModel order;

  /// Callback when the card is tapped — navigates to order detail.
  final VoidCallback? onTap;

  const OrderCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.spaceSM),
        padding: const EdgeInsets.all(AppSizes.paddingCard),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Order icon ─────────────────────────────────
            const Icon(
              Icons.receipt_long_rounded,
              color: AppColors.primary,
              size: AppSizes.iconLG,
            ),
            const SizedBox(width: AppSizes.spaceMD),

            // ── Order info ─────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.medicineNames.isEmpty
                        ? 'روشتة طبية'
                        : order.medicineNames,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spaceXXS),
                  Text(
                    order.createdAt.toLocal().toString().substring(0, 10),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),

            // ── Status badge ───────────────────────────────
            StatusBadge(status: order.status),
          ],
        ),
      ),
    );
  }
}
