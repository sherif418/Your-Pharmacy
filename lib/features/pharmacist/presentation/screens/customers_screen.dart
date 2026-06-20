// customers_screen.dart
// Responsible for: displaying a list of all village customers registered in the system.
// Enables the pharmacist to view specific user profiles or order histories.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/loading_indicator.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Wire up with Bloc to load all registered customer users.
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.pharmacistCustomers)),
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
