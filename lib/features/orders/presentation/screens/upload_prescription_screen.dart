// upload_prescription_screen.dart
// Responsible for: letting the customer pick an image of their prescription and upload it.
// Dispatches OrderPrescriptionUploadRequested to OrdersBloc on submission.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';

class UploadPrescriptionScreen extends StatelessWidget {
  const UploadPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Use image_picker package to let user select a photo from gallery/camera.
    // TODO: Dispatch OrderPrescriptionUploadRequested on submit button tap.
    // TODO: Wrap with BlocListener to navigate on OrderPlacedSuccess.
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.uploadPrescriptionTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingHorizontal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Image picker placeholder ───────────────────
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                border: Border.all(
                  color: AppColors.border,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file_rounded,
                    size: AppSizes.iconXL,
                    color: AppColors.textHint,
                  ),
                  SizedBox(height: AppSizes.spaceXS),
                  Text(
                    'اضغط لاختيار صورة الروشتة',
                    style: TextStyle(color: AppColors.textHint),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceLG),
            // ── Submit button — onPressed wired to BLoC later
            const CustomButton(
              label: AppStrings.orderPlaceButton,
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
