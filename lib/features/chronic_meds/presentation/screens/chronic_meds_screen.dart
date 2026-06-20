// chronic_meds_screen.dart
// Responsible for: showing the list of the customer's chronic medications.
// Dispatches ChronicMedsLoadRequested on init and renders a ChronicMedCard per item.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/loading_indicator.dart';

class ChronicMedsScreen extends StatelessWidget {
  const ChronicMedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Dispatch ChronicMedsLoadRequested(customerId: ...) on screen open.
    // TODO: Wrap body with BlocBuilder<ChronicMedsBloc, ChronicMedsState>:
    //   ChronicMedsLoading → LoadingIndicator()
    //   ChronicMedsLoaded  → ListView of ChronicMedCard widgets
    //   ChronicMedsError   → error Text
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.chronicMedsTitle)),
      body: const Padding(
        padding: EdgeInsets.all(AppSizes.paddingHorizontal),
        child: LoadingIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        // TODO: Navigate to AddChronicMedScreen on tap.
        onPressed: null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
