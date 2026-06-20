// register_screen.dart
// Responsible for: rendering the registration form and dispatching AuthRegisterRequested.
// All text comes from AppStrings, all sizes from AppSizes, all colors from AppColors.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/app_logo.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/service_locator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String id = 'register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  /// 'customer' or 'pharmacist'
  String? _selectedRole;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ── Validators ──────────────────────────────────────────────
  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.errorEmptyField;
    if (v.trim().length < 3) return AppStrings.errorShortName;
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.errorEmptyField;
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(v.trim())) return AppStrings.errorInvalidEmail;
    return null;
  }

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.errorEmptyField;
    final phoneRegex = RegExp(r'^01[0-9]{9}$');
    if (!phoneRegex.hasMatch(v.trim())) return AppStrings.errorInvalidPhone;
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return AppStrings.errorEmptyField;
    if (v.length < 6) return AppStrings.errorWeakPassword;
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return AppStrings.errorEmptyField;
    if (v != _passwordController.text) return AppStrings.errorPasswordMismatch;
    return null;
  }

  void _onRegisterPressed(BuildContext context) {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.errorSelectAccountType),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthRegisterRequested(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              phone: _phoneController.text.trim(),
              password: _passwordController.text,
              role: _selectedRole!,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (_, current) =>
            current is AuthRegisterSuccess || current is AuthError,
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            // Show success dialog then go back to login
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLG),
                ),
                title: Row(
                  children: const [
                    Icon(Icons.check_circle_rounded, color: AppColors.success),
                    SizedBox(width: AppSizes.spaceXS),
                    Text(AppStrings.registerSuccessTitle,
                        style: TextStyle(color: AppColors.success)),
                  ],
                ),
                content: const Text(AppStrings.registerSuccessBody),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // go back to login
                    },
                    child: const Text(AppStrings.registerLoginLink),
                  ),
                ],
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        buildWhen: (_, current) =>
            current is AuthLoading ||
            current is AuthRegisterSuccess ||
            current is AuthError ||
            current is AuthInitial,
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.registerTitle),
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: AppColors.primary,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingHorizontal,
                  vertical: AppSizes.paddingVertical,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Logo (small) ─────────────────────────────
                      const AppLogo(size: AppSizes.logoSizeSM, showName: false),
                      const SizedBox(height: AppSizes.spaceLG),

                      // ── Full Name ────────────────────────────────
                      CustomTextField(
                        hint: AppStrings.registerNameHint,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        validator: _validateName,
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Email ────────────────────────────────────
                      CustomTextField(
                        hint: AppStrings.registerEmailHint,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Phone ────────────────────────────────────
                      CustomTextField(
                        hint: AppStrings.registerPhoneHint,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                        prefixIcon: const Icon(Icons.phone_outlined),
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Account Type Dropdown ────────────────────
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(
                          hintText: AppStrings.registerAccountTypeHint,
                          prefixIcon: const Icon(Icons.badge_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'customer',
                            child: Text(AppStrings.registerAccountTypeCustomer),
                          ),
                          DropdownMenuItem(
                            value: 'pharmacist',
                            child: Text(AppStrings.registerAccountTypePharmacist),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedRole = value);
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Password ─────────────────────────────────
                      CustomTextField(
                        hint: AppStrings.registerPasswordHint,
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: _validatePassword,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Confirm Password ──────────────────────────
                      CustomTextField(
                        hint: AppStrings.registerConfirmPasswordHint,
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirm,
                        validator: _validateConfirm,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() => _obscureConfirm = !_obscureConfirm);
                          },
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceLG),

                      // ── Register Button ───────────────────────────
                      CustomButton(
                        label: AppStrings.registerButton,
                        isLoading: isLoading,
                        onPressed: isLoading
                            ? null
                            : () => _onRegisterPressed(context),
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Already have account link ─────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(AppStrings.registerHaveAccount),
                          const SizedBox(width: AppSizes.spaceXXS),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              AppStrings.registerLoginLink,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
