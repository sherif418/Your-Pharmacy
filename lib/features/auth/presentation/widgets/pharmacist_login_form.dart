import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/widgets/app_text_field.dart';
import 'package:flutter_application_1/widgets/app_primary_button.dart';
import 'package:flutter_application_1/widgets/app_notice.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/login_section_title.dart';

/// Form widget handling the input fields and login logic for pharmacists.
class PharmacistLoginForm extends StatefulWidget {
  const PharmacistLoginForm({super.key});

  @override
  State<PharmacistLoginForm> createState() => _PharmacistLoginFormState();
}

class _PharmacistLoginFormState extends State<PharmacistLoginForm> {
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
          title: AppStrings.loginPharmacistTitle,
          icon: Icons.medical_services_outlined,
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
        SizedBox(height: 16.h),
        const AppNotice(
          text: AppStrings.pharmacistLoginNotice,
        ),
        SizedBox(height: 16.h),
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
      ],
    );
  }
}
