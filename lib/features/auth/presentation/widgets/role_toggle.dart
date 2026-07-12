import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/role_button.dart';

/// Segmented control toggle switch for role selection (Customer vs. Pharmacist) on LoginScreen.
class RoleToggle extends StatelessWidget {
  final bool isClient;
  final ValueChanged<bool> onChanged;

  const RoleToggle({
    super.key,
    required this.isClient,
    required this.onChanged,
  });

  static const double _padding = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double slotWidth = constraints.maxWidth / 2;
          final double pillHeight = constraints.maxHeight;

          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                // RTL: Customer (isClient=true) is on the right side of the stack.
                right: isClient ? 0 : slotWidth,
                top: 0,
                width: slotWidth,
                height: pillHeight,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withValues(alpha: 0.82),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RoleButton(
                      label: AppStrings.registerAccountTypeCustomer,
                      icon: Icons.person_rounded,
                      selected: isClient,
                      onTap: () => onChanged(true),
                    ),
                  ),
                  Expanded(
                    child: RoleButton(
                      label: AppStrings.registerAccountTypePharmacist,
                      icon: Icons.medical_services_outlined,
                      selected: !isClient,
                      onTap: () => onChanged(false),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
