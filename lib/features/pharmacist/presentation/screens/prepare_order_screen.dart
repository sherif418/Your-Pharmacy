// prepare_order_screen.dart
// Responsible for: displaying a single order's details so the pharmacist can pack and ship it.
// Provides buttons to progress order status from Preparing to Ready or Delivered.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';

class PrepareOrderScreen extends StatelessWidget {
  final String orderId;

  const PrepareOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // TODO: Wire up BlocBuilder and trigger update status event on status changes.
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.pharmacistPrepareOrder)),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingHorizontal),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceLG),
            // Mock detail info
            Text(
              '${AppStrings.orderDetailTitle} #$orderId',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // Button to prepare order
            CustomButton(
              label: AppStrings.pharmacistPrepareOrder,
              onPressed: () {
                // TODO: Dispatch update status to 'preparing'
              },
            ),
            const SizedBox(height: AppSizes.spaceMD),
          ],
        ),
      ),
    );
  }
}
