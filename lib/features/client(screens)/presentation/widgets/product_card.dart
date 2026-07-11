// product_card.dart
// Responsible for: rendering a product card used in the best sellers list.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/features/client(screens)/domain/home_models.dart';

class ProductCard extends StatelessWidget {
  /// Product summary data shown in the card.
  final ProductSummary product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.productCardWidth,
      margin: const EdgeInsets.only(left: AppSizes.spaceMD),
      padding: const EdgeInsets.all(AppSizes.productCardPadding),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(color: AppColors.shadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppSizes.productImageHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.medication_rounded,
                color: AppColors.primary, size: AppSizes.iconXL),
          ),
          const SizedBox(height: AppSizes.spaceSM),
          Text(product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          const SizedBox(height: AppSizes.spaceXXS),
          Row(
            children: [
              const Icon(Icons.star_rounded, size: 13, color: Colors.amber),
              const SizedBox(width: AppSizes.spaceXXS),
              Text('${product.rating}',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: AppSizes.spaceXS2),
          Row(
            children: [
              Expanded(
                child: Text('${product.price} EGP',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary)),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.spaceXXS),
                  decoration: const BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.add_shopping_cart_rounded,
                      size: 13, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
