// custom_text_field.dart
// Responsible for: providing a reusable, styled text input field used across all screens.
// Centralises border, hint, and validation display so every form field looks the same.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _hasFocus = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        focusNode: _focusNode,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
        ),
      ),
    );
  }
}
