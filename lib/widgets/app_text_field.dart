// app_text_field.dart
// Wrapper for CustomTextField to preserve original naming used in screens.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.icon,
    this.isPassword = false,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
  });

  final String hint;
  final TextEditingController? controller;
  final IconData? icon;
  final bool isPassword;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hint: hint,
      controller: controller,
      obscureText: isPassword,
      suffixIcon: icon != null ? Icon(icon, color: AppColors.primary) : null,
      prefixIcon: prefixIcon,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      maxLines: maxLines,
    );
  }
}
