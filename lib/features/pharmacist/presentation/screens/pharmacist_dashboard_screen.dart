// pharmacist_dashboard_screen.dart
// Responsible for: displaying high-level stats and entry points for the pharmacist.
// Includes metrics for total orders and pending items.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/loading_indicator.dart';
import 'package:flutter_application_1/features/pharmacist/presentation/widgets/stat_card.dart';

class PharmacistDashboardScreen extends StatelessWidget {
  const PharmacistDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Connect BlocBuilder<PharmacistOrdersBloc, PharmacistOrdersState>
    // TODO: Dispatch PharmacistDashboardLoadRequested on initState
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.pharmacistDashboardTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingHorizontal),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceMD),
            // Metrics grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: AppSizes.spaceMD,
              mainAxisSpacing: AppSizes.spaceMD,
              children: const [
                StatCard(
                  title: AppStrings.pharmacistTotalOrders,
                  value: '0',
                  icon: Icons.assignment_rounded,
                ),
                StatCard(
                  title: AppStrings.pharmacistPendingOrders,
                  value: '0',
                  icon: Icons.pending_actions_rounded,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceLG),
            const Expanded(
              child: Center(
                child: LoadingIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
