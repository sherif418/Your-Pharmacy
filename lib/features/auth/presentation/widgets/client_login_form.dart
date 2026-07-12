import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/widgets/app_text_field.dart';
import 'package:flutter_application_1/widgets/app_primary_button.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/login_section_title.dart';

/// Form widget handling the input fields and logic for customer login.
class ClientLoginForm extends StatefulWidget {
  const ClientLoginForm({super.key});

  @override
  State<ClientLoginForm> createState() => _ClientLoginFormState();
}

class _ClientLoginFormState extends State<ClientLoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const LoginSectionTitle(
          title: AppStrings.loginClientTitle,
          icon: Icons.person_outline,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          hint: AppStrings.loginEmailHint,
          icon: Icons.mail_outline_rounded,
          controller: _emailController,
        ),
        SizedBox(height: 12.h),
        AppTextField(
          hint: AppStrings.loginPasswordHint,
          icon: Icons.lock_outline_rounded,
          isPassword: true,
          controller: _passwordController,
        ),
        SizedBox(height: 6.h),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              AppStrings.loginForgotPassword,
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        AppPrimaryButton(
          label: AppStrings.loginButton,
          icon: Icons.login_rounded,
          onPressed: () {
            final email = _emailController.text.trim();
            final password = _passwordController.text;
            if (email.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.loginEnterCredentials)),
              );
              return;
            }
            context
                .read<AuthBloc>()
                .add(AuthLoginRequested(email: email, password: password));
          },
        ),
        SizedBox(height: 18.h),
        Row(
          children: [
            Expanded(
                child: Divider(color: AppColors.border.withValues(alpha: 0.6))),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppStrings.loginOr,
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ),
            Expanded(
                child: Divider(color: AppColors.border.withValues(alpha: 0.6))),
          ],
        ),
        SizedBox(height: 14.h),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              AppStrings.loginNoAccount,
              style: TextStyle(fontSize: 12.5, color: AppColors.textPrimary),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.register),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: const Text(
                  AppStrings.loginCreateAccount,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
