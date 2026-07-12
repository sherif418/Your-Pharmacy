// bottom_nav_bar.dart
// Responsible for: rendering the dynamic bottom navigation bar.
// The items shown depend on the user's [role] ('customer' or 'pharmacist').
// No offers/discounts tab — removed per design decision.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';

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

  static const Duration _animationDuration = Duration(milliseconds: 180);
  static const double _selectedScale = 1.16;
  static const double _itemBorderRadius = 18.0;

  List<_BottomNavItemData> _buildItems() {
    if (role == 'pharmacist') {
      return const [
        _BottomNavItemData(icon: Icons.dashboard_rounded, label: 'الرئيسية'),
        _BottomNavItemData(icon: Icons.receipt_long_rounded, label: 'الطلبات'),
        _BottomNavItemData(icon: Icons.people_rounded, label: 'العملاء'),
        _BottomNavItemData(icon: Icons.person_rounded, label: 'حسابي'),
      ];
    }

    return const [
      _BottomNavItemData(icon: Icons.home_rounded, label: 'الرئيسية'),
      _BottomNavItemData(icon: Icons.receipt_long_rounded, label: 'طلباتي'),
      _BottomNavItemData(icon: Icons.favorite_rounded, label: 'أدويتي'),
      _BottomNavItemData(icon: Icons.person_rounded, label: 'حسابي'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildItems();
    final safeIndex = currentIndex.clamp(0, items.length - 1);

    return Container(
      color: AppColors.background,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: AppSizes.spaceXS),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 14,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceSM,
              vertical: AppSizes.spaceXS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                items.length,
                (index) {
                  final item = items[index];
                  final selected = index == safeIndex;
                  return Expanded(
                    child: _NavBarTab(
                      item: item,
                      selected: selected,
                      onTap: () {
                        if (!selected) {
                          onTap(index);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarTab extends StatelessWidget {
  final _BottomNavItemData item;
  final bool selected;
  final VoidCallback onTap;

  const _NavBarTab({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  static const Duration _animationDuration = AppBottomNavBar._animationDuration;
  static const double _selectedScale = AppBottomNavBar._selectedScale;

  @override
  Widget build(BuildContext context) {
    final selectedColor = AppColors.primary;
    final unselectedColor = AppColors.textMuted;

    return AnimatedContainer(
      duration: _animationDuration,
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: selected ? AppColors.primarySoft : Colors.transparent,
        borderRadius: BorderRadius.circular(AppBottomNavBar._itemBorderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppBottomNavBar._itemBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.spaceXS,
              horizontal: AppSizes.spaceSM,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: selected ? _selectedScale : 1.0,
                  duration: _animationDuration,
                  curve: Curves.easeOutCubic,
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: unselectedColor,
                      end: selected ? selectedColor : unselectedColor,
                    ),
                    duration: _animationDuration,
                    curve: Curves.easeOutCubic,
                    builder: (context, color, child) {
                      return Icon(item.icon, color: color, size: AppSizes.iconMD);
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.spaceXXS),
                AnimatedDefaultTextStyle(
                  duration: _animationDuration,
                  curve: Curves.easeOutCubic,
                  style: TextStyle(
                    color: selected ? selectedColor : unselectedColor,
                    fontSize: selected ? 12.0 : 11.0,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  child: Text(item.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItemData {
  final IconData icon;
  final String label;
  const _BottomNavItemData({required this.icon, required this.label});
}
