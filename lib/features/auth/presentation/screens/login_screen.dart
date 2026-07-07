// lib/features/auth/presentation/screens/login_screen.dart

import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
import '/widgets/app_card.dart';
import '/widgets/app_text_field.dart';
import '/widgets/app_primary_button.dart';
import '/widgets/app_notice.dart';
import '/features/auth/presentation/widgets/app_logo.dart';
import '/core/routes/app_routes.dart';

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
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: AppCard(
              child: Column(
                children: [
                  const AppLogo(),
                  const SizedBox(height: 24),
                  const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _RoleToggle(
                    isClient: _isClient,
                    onChanged: (v) => setState(() => _isClient = v),
                  ),
                  const SizedBox(height: 22),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _isClient
                        ? const _ClientLoginForm(key: ValueKey('client'))
                        : const _PharmacistLoginForm(
                            key: ValueKey('pharmacist'),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// مبدل عميل / صيدلي
class _RoleToggle extends StatelessWidget {
  final bool isClient;
  final ValueChanged<bool> onChanged;
  const _RoleToggle({required this.isClient, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _RoleButton(
              label: 'عميل',
              icon: Icons.person_rounded,
              selected: isClient,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _RoleButton(
              label: 'صيدلي',
              icon: Icons.medical_services_outlined,
              selected: !isClient,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _RoleButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : AppColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              size: 18,
              color: selected ? Colors.white : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

/// نموذج دخول العميل
class _ClientLoginForm extends StatelessWidget {
  const _ClientLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionTitle(
          title: 'تسجيل دخول العميل',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 14),
        const AppTextField(
          hint: 'البريد الإلكتروني',
          icon: Icons.mail_outline_rounded,
        ),
        const SizedBox(height: 12),
        const AppTextField(
          hint: 'كلمة المرور',
          icon: Icons.lock_outline_rounded,
          isPassword: true,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'نسيت كلمة المرور؟',
              style: TextStyle(color: AppColors.accent, fontSize: 12.5),
            ),
          ),
        ),
        const SizedBox(height: 6),
        AppPrimaryButton(
          label: 'تسجيل الدخول',
          icon: Icons.login_rounded,
          onPressed: () {},
        ),
        const SizedBox(height: 14),
        Row(
          children: const [
            Expanded(child: Divider(color: AppColors.border)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'أو',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ),
            Expanded(child: Divider(color: AppColors.border)),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              'ليس لديك حساب؟ ',
              style: TextStyle(fontSize: 12.5, color: AppColors.text),
            ),
            GestureDetector(
              // inside onTap for create account
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.register),
              child: const Text(
                'إنشاء حساب جديد',
                style: TextStyle(
                  fontSize: 12.5,
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// نموذج دخول الصيدلي
class _PharmacistLoginForm extends StatelessWidget {
  const _PharmacistLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionTitle(
          title: 'تسجيل دخول الصيدلي',
          icon: Icons.medical_services_outlined,
        ),
        const SizedBox(height: 14),
        const AppTextField(
          hint: 'البريد الإلكتروني',
          icon: Icons.mail_outline_rounded,
        ),
        const SizedBox(height: 12),
        const AppTextField(
          hint: 'كلمة المرور',
          icon: Icons.lock_outline_rounded,
          isPassword: true,
        ),
        const SizedBox(height: 14),
        const AppNotice(
          text:
              'لا يوجد تسجيل حساب جديد للصيدلي، يتم إنشاء البريد الإلكتروني بواسطة مدير النظام.',
        ),
        const SizedBox(height: 14),
        AppPrimaryButton(
          label: 'تسجيل الدخول',
          icon: Icons.login_rounded,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(width: 6),
        Icon(icon, size: 16, color: AppColors.primary),
      ],
    );
  }
}
