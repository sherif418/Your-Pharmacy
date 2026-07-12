// lib/features/auth/presentation/screens/login_screen.dart
//
// UI مُحسّن ليطابق ستايل شاشة التسجيل (ظلال + تدرج + كروت)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/widgets/app_logo.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/role_toggle.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/client_login_form.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/pharmacist_login_form.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isClient = true; // عميل = true / صيدلي = false

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.withValues(alpha: 0.08),
                AppColors.surface.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.4],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600 ? 0 : 20,
                    vertical: 24,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 460),
                      child: BlocProvider(
                        create: (_) => getIt<AuthBloc>(),
                        child: BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthAuthenticated) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      HomeScreen(user: state.user),
                                ),
                              );
                            } else if (state is AuthLoginEmailNotVerified) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    AppStrings.errorEmailNotVerified,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.orange.shade700,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                  duration: const Duration(seconds: 6),
                                  action: SnackBarAction(
                                    label: AppStrings.loginResendVerification,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                            const AuthResendVerificationEmail(),
                                          );
                                    },
                                  ),
                                ),
                              );
                            } else if (state is AuthResendVerificationSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Row(
                                    children: [
                                      Icon(Icons.check_circle_outline,
                                          color: Colors.white, size: 20),
                                      SizedBox(width: 10),
                                      Text(AppStrings.loginResendSuccess),
                                    ],
                                  ),
                                  backgroundColor: AppColors.primary,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                ),
                              );
                            } else if (state is AuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.error_outline,
                                          color: Colors.white, size: 20),
                                      const SizedBox(width: 10),
                                      Expanded(child: Text(state.message)),
                                    ],
                                  ),
                                  backgroundColor: AppColors.error,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                ),
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColors.primary.withValues(alpha: 0.22),
                                      blurRadius: 26,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: const AppLogo(),
                              ),
                              SizedBox(height: 18.h),
                              const Text(
                                AppStrings.loginWelcomeBack,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              const Text(
                                AppStrings.loginSubtitle,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: AppColors.textMuted,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 26.h),

                              RoleToggle(
                                isClient: _isClient,
                                onChanged: (v) =>
                                    setState(() => _isClient = v),
                              ),
                              SizedBox(height: 22.h),

                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: AppColors.border.withValues(alpha: 0.6),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColors.primary.withValues(alpha: 0.10),
                                      blurRadius: 22,
                                      offset: const Offset(0, 8),
                                    ),
                                    const BoxShadow(
                                      color: AppColors.shadow,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (child, anim) =>
                                      FadeTransition(
                                    opacity: anim,
                                    child: SizeTransition(
                                      sizeFactor: anim,
                                      axisAlignment: -1,
                                      child: child,
                                    ),
                                  ),
                                  child: _isClient
                                      ? const ClientLoginForm(
                                          key: ValueKey('client'))
                                      : const PharmacistLoginForm(
                                          key: ValueKey('pharmacist'),
                                        ),
                                ),
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}