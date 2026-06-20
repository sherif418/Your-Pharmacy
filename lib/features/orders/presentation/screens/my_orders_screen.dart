// my_orders_screen.dart
// Responsible for: showing the logged-in customer's full order history.
// Dispatches OrdersLoadRequested on init and renders an OrderCard for each order.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/loading_indicator.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Wrap with BlocBuilder<OrdersBloc, OrdersState>.
    // TODO: Dispatch OrdersLoadRequested in initState using current user ID from AuthBloc.
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.ordersTitle)),
      body: const Center(
        // Replace with BlocBuilder content when wiring BLoC:
        //   OrdersLoading  → LoadingIndicator()
        //   OrdersLoaded   → ListView of OrderCard widgets
        //   OrdersError    → error message Text
        child: LoadingIndicator(),
      ),
    );
  }
}
