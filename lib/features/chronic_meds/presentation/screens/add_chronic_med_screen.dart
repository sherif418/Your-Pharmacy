// add_chronic_med_screen.dart
// Responsible for: letting the customer add a new chronic medication to their list.
// Dispatches ChronicMedAddRequested to ChronicMedsBloc on form submission.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';

class AddChronicMedScreen extends StatelessWidget {
  const AddChronicMedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Add TextEditingControllers for name and dose.
    // TODO: Wrap with BlocListener<ChronicMedsBloc, ChronicMedsState> to pop on success.
    // TODO: Dispatch ChronicMedAddRequested on button tap.
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.addChronicMedTitle)),
      body: const Padding(
        padding: EdgeInsets.all(AppSizes.paddingHorizontal),
        child: Column(
          children: [
            SizedBox(height: AppSizes.spaceLG),
            // Medicine name
            CustomTextField(hint: AppStrings.chronicMedNameHint),
            SizedBox(height: AppSizes.spaceMD),
            // Dose
            CustomTextField(hint: AppStrings.chronicMedDoseHint),
            SizedBox(height: AppSizes.spaceLG),
            // Submit button — onPressed wired to BLoC later
            CustomButton(label: AppStrings.addMedButton, onPressed: null),
          ],
        ),
      ),
    );
  }
}
