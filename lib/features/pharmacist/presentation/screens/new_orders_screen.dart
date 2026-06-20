// new_orders_screen.dart
// Responsible for: displaying a list of unhandled/incoming prescription or medicine orders.
// Allows the pharmacist to view details and accept them.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/loading_indicator.dart';

class NewOrdersScreen extends StatelessWidget {
  const NewOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Wire up with PharmacistOrdersBloc state to filter 'pending' orders.
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.pharmacistNewOrders)),
      body: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
