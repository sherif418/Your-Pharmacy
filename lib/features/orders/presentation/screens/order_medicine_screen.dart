// order_medicine_screen.dart
// Responsible for: letting the customer type medicine names and submit a new order.
// Dispatches OrderPlaceRequested to OrdersBloc on form submission.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';

class OrderMedicineScreen extends StatelessWidget {
  const OrderMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Add TextEditingControllers for medicine name and notes fields.
    // TODO: Wrap with BlocListener<OrdersBloc, OrdersState> to navigate on OrderPlacedSuccess.
    // TODO: Dispatch OrderPlaceRequested on button tap.
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.orderMedicineTitle)),
      body: const Padding(
        padding: EdgeInsets.all(AppSizes.paddingHorizontal),
        child: Column(
          children: [
            SizedBox(height: AppSizes.spaceLG),
            // Medicine name(s) field
            CustomTextField(
              hint: AppStrings.chronicMedNameHint,
              maxLines: 3,
            ),
            SizedBox(height: AppSizes.spaceMD),
            // Optional notes field
            CustomTextField(
              hint: 'ملاحظات إضافية (اختياري)',
              maxLines: 2,
            ),
            SizedBox(height: AppSizes.spaceLG),
            // Submit button — onPressed wired to BLoC later
            CustomButton(
              label: AppStrings.orderPlaceButton,
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
