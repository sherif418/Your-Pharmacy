// custom_text_field.dart
// Responsible for: providing a reusable, styled text input field used across all screens.
// Centralises border, hint, and validation display so every form field looks the same.

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  /// The hint text shown inside the field when empty.
  final String hint;

  /// Controller to read/write the field value from outside.
  final TextEditingController? controller;

  /// When true, the field hides its text (for passwords).
  final bool obscureText;

  /// Optional trailing icon widget (e.g. show/hide password eye).
  final Widget? suffixIcon;

  /// Optional leading icon inside the field.
  final Widget? prefixIcon;

  /// Keyboard type (email, number, phone, etc.).
  final TextInputType keyboardType;

  /// Validation function — return an error string or null.
  final String? Function(String?)? validator;

  /// Called on every character change.
  final void Function(String)? onChanged;

  /// Makes the field read-only when true.
  final bool readOnly;

  /// Allows multiline input (e.g. order notes).
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
