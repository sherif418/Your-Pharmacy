// register_screen.dart
// Responsible for: rendering the registration form and dispatching AuthRegisterRequested.
// All text comes from AppStrings, all sizes from AppSizes, all colors from AppColors.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/validators/app_validators.dart';
import 'package:flutter_application_1/core/widgets/app_logo.dart';
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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  String? _selectedRole = 'customer'; // Default role is customer
  String? _selectedVillage;

  final List<String> _villages = const [
    'قرية السلام',
    'قرية الأمل',
    'قرية النور',
    'قرية الروضة',
    'قرية السعادة',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
    if (_selectedVillage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك اختر قريتك'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      final String phone = _phoneController.text.trim();
      final String email = '$phone@sidleitak.com'; // Auto synthetic email

      context.read<AuthBloc>().add(
            AuthRegisterRequested(
              name: _nameController.text.trim(),
              email: email,
              phone: phone,
              password: _passwordController.text,
              role: _selectedRole!,
              village: _selectedVillage!,
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
                  borderRadius: BorderRadius.circular(16.0),
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
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: const Text(
                AppStrings.registerTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: AppColors.primary,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingHorizontal * 1.5,
                  vertical: AppSizes.paddingVertical,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSizes.spaceXS),

                      // ── Logo (small) ─────────────────────────────
                      const AppLogo(size: AppSizes.logoSizeSM, showName: false),
                      const SizedBox(height: AppSizes.spaceLG),

                      // ── Full Name ────────────────────────────────
                      CustomTextField(
                        hint: AppStrings.registerNameHint,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        validator: AppValidators.validateName,
                        prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.primary),
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Phone ────────────────────────────────────
                      CustomTextField(
                        hint: AppStrings.registerPhoneHint,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: AppValidators.validatePhone,
                        prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Village Selector ──────────────────────────
                      DropdownButtonFormField<String>(
                        initialValue: _selectedVillage,
                        decoration: InputDecoration(
                          hintText: 'اختر قريتك',
                          prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.primary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
                          ),
                        ),
                        items: _villages.map((village) {
                          return DropdownMenuItem(
                            value: village,
                            child: Text(village),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedVillage = value);
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceMD),

                      // ── Account Type Dropdown ────────────────────
                      DropdownButtonFormField<String>(
                        initialValue: _selectedRole,
                        decoration: InputDecoration(
                          hintText: AppStrings.registerAccountTypeHint,
                          prefixIcon: const Icon(Icons.badge_outlined, color: AppColors.primary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
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
                        validator: AppValidators.validatePassword,
                        prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.primary,
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
                        validator: (value) => AppValidators.validateConfirmPassword(
                          value,
                          _passwordController.text,
                        ),
                        prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            setState(() => _obscureConfirm = !_obscureConfirm);
                          },
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceLG),

                      // ── Register Button (Secondary Amber Theme) ──
                      SizedBox(
                        width: double.infinity,
                        height: 56.0,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () => _onRegisterPressed(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            foregroundColor: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  AppStrings.registerButton,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceLG),

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
                      const SizedBox(height: AppSizes.spaceLG),
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
