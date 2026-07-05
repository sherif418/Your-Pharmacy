// bottom_nav_bar.dart
// Responsible for: rendering the dynamic bottom navigation bar.
// The items shown depend on the user's [role] ('customer' or 'pharmacist').
// No offers/discounts tab — removed per design decision.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  /// Current selected index.
  final int currentIndex;

  /// Callback when a tab is tapped.
  final ValueChanged<int> onTap;

  /// 'customer' or 'pharmacist'
  final String role;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  });

  List<BottomNavigationBarItem> _buildItems() {
    if (role == 'pharmacist') {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_rounded),
          label: 'الطلبات',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_rounded),
          label: 'العملاء',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'حسابي',
        ),
      ];
    }

    // ── Customer tabs ──────────────────────────────────────
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        label: 'الرئيسية',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long_rounded),
        label: 'طلباتي',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_rounded),
        label: 'أدويتي',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        label: 'حسابي',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildItems();
    return BottomNavigationBar(
      currentIndex: currentIndex.clamp(0, items.length - 1),
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textHint,
      backgroundColor: AppColors.background,
      elevation: 12,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      items: items,
    );
  }
}
