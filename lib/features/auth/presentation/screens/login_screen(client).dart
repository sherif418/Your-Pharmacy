// login_screen.dart
// Responsible for: rendering the login form and dispatching AuthLoginRequested to AuthBloc.
// All text comes from AppStrings, all sizes from AppSizes, all colors from AppColors.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/validators/app_validators.dart';
import 'package:flutter_application_1/core/widgets/app_logo.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/core/widgets/custom_text_field.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter_application_1/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Map phone number to a synthetic email address format for Firebase Auth
      final String phone = _phoneController.text.trim();
      final String email = '$phone@sidleitak.com';
      
      context.read<AuthBloc>().add(
            AuthLoginRequested(
              email: email,
              password: _passwordController.text,
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
            current is AuthAuthenticated || current is AuthError,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(user: state.user),
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
            current is AuthLoading || current is AuthAuthenticated || current is AuthError || current is AuthInitial,
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingHorizontal * 1.5,
                    vertical: AppSizes.paddingVertical,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSizes.spaceLG),

                        // ── Logo ────────────────────────────────────
                        const AppLogo(size: AppSizes.logoSizeMD),
                        const SizedBox(height: AppSizes.spaceXL),

                        // ── Phone Input ──────────────────────────────
                        CustomTextField(
                          hint: AppStrings.registerPhoneHint,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: AppValidators.validatePhone,
                          prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                        ),
                        const SizedBox(height: AppSizes.spaceMD),

                        // ── Password Input ───────────────────────────
                        CustomTextField(
                          hint: AppStrings.loginPasswordHint,
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
                        
                        // ── Forgot Password ──────────────────────────
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Optional Forgot Password Action
                            },
                            child: const Text(
                              AppStrings.loginForgotPassword,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceLG),

                        // ── Login Button ─────────────────────────────
                        CustomButton(
                          label: AppStrings.loginButton,
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () => _onLoginPressed(context),
                        ),
                        const SizedBox(height: AppSizes.spaceXL),

                        // ── Divider ──────────────────────────────────
                        Row(
                          children: const [
                            Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('أو', style: TextStyle(color: AppColors.textHint)),
                            ),
                            Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spaceXL),

                        // ── Register Link (Accent Theme) ─────────────
                        SizedBox(
                          width: double.infinity,
                          height: 56.0,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.secondary, width: 2.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: const Text(
                              AppStrings.registerTitle,
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceLG),
                      ],
                    ),
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
