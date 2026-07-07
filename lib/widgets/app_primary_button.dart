// app_primary_button.dart
// Wrapper for CustomButton to preserve original naming used in screens.

import 'package:flutter_application_1/core/widgets/custom_button.dart';

class AppPrimaryButton extends CustomButton {
  const AppPrimaryButton({
    super.key,
    required super.label,
    required super.onPressed,
    super.isLoading = false,
    super.width,
    super.icon,
  }) : super();
}
