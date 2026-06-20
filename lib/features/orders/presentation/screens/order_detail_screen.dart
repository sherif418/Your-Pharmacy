// order_detail_screen.dart
// Responsible for: showing the full details of a single order.
// Dispatches OrderDetailLoadRequested on init and displays all order fields.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/loading_indicator.dart';

class OrderDetailScreen extends StatelessWidget {
  /// The Firestore document ID of the order to display.
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // TODO: Dispatch OrderDetailLoadRequested(orderId: orderId) on screen open.
    // TODO: Wrap body with BlocBuilder<OrdersBloc, OrdersState>:
    //   OrdersLoading      → LoadingIndicator()
    //   OrderDetailLoaded  → show order fields + StatusBadge
    //   OrdersError        → show error message
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.orderDetailTitle)),
      body: const Padding(
        padding: EdgeInsets.all(AppSizes.paddingHorizontal),
        child: LoadingIndicator(),
      ),
    );
  }
}
