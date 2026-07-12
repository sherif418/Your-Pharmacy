// email_verification_screen.dart
// Responsible for: showing the email verification screen after registration.
// The user opens their email, clicks the verification link, then returns here
// and presses "تحققت". The BLoC calls reload() and checks emailVerified.
//
// Flow:
//   "تحققت" pressed → AuthEmailVerificationCheck
//     → AuthAuthenticated  → HomeScreen ✅
//     → AuthEmailNotVerified → SnackBar ❌
//   "إعادة إرسال" pressed → AuthResendVerificationEmail
//     → AuthResendVerificationSuccess → SnackBar ✅

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/screens/home_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final AppUser pendingUser;

  const EmailVerificationScreen({super.key, required this.pendingUser});
  static const String id = 'email-verification-screen';

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  Timer? _resendCooldownTimer;
  int _resendCooldown = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _resendCooldownTimer?.cancel();
    super.dispose();
  }

  void _onVerifiedPressed() {
    context.read<AuthBloc>().add(
          AuthEmailVerificationCheck(pendingUser: widget.pendingUser),
        );
  }

  void _onResendPressed() {
    if (_resendCooldown > 0) return;
    context.read<AuthBloc>().add(const AuthResendVerificationEmail());
    // Start 60-second cooldown
    setState(() => _resendCooldown = 60);
    _resendCooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _resendCooldown--);
      if (_resendCooldown <= 0) timer.cancel();
    });
  }

  Future<void> _openEmailApp() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: widget.pendingUser.email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر فتح تطبيق البريد الإلكتروني. حاول لاحقاً.'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => HomeScreen(user: state.user)),
            (_) => false,
          );
        } else if (state is AuthEmailNotVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(AppStrings.emailVerificationNotVerified),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          );
        } else if (state is AuthResendVerificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(AppStrings.emailVerificationResendSuccess),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

                // ── Animated Email Icon ───────────────────────
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (_, child) => Transform.scale(
                    scale: _pulseAnimation.value,
                    child: child,
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_rounded,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 36),

                // ── Title ─────────────────────────────────────
                const Text(
                  AppStrings.emailVerificationTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),

                // ── Email badge ───────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.email_outlined,
                          color: AppColors.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        widget.pendingUser.email,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Body text ─────────────────────────────────
                Text(
                  AppStrings.emailVerificationBody,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: LinearProgressIndicator(
                    value: 0.7,
                    minHeight: 6,
                    color: AppColors.primary,
                    backgroundColor: AppColors.primary.withOpacity(0.18),
                  ),
                ),
                const SizedBox(height: 24),

                // ── "تحققت" Button ────────────────────────────
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : _onVerifiedPressed,
                        icon: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : const Icon(Icons.verified_rounded,
                                color: Colors.white),
                        label: Text(
                          isLoading ? 'جاري التحقق...' : AppStrings.emailVerificationButton,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 6,
                          shadowColor: AppColors.primary.withOpacity(0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // ── Resend Button ─────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: OutlinedButton.icon(
                    onPressed: _resendCooldown > 0 ? null : _onResendPressed,
                    icon: Icon(
                      Icons.refresh_rounded,
                      color: _resendCooldown > 0
                          ? AppColors.textSecondary
                          : AppColors.primary,
                    ),
                    label: Text(
                      _resendCooldown > 0
                          ? '${AppStrings.emailVerificationResend} (${_resendCooldown}s)'
                          : AppStrings.emailVerificationResend,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _resendCooldown > 0
                            ? AppColors.textSecondary
                            : AppColors.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _resendCooldown > 0
                            ? AppColors.border
                            : AppColors.primary,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: FilledButton.icon(
                    onPressed: _openEmailApp,
                    icon: const Icon(Icons.open_in_new_rounded, color: Colors.white),
                    label: const Text(
                      AppStrings.emailVerificationOpenApp,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // ── Steps hint ────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _StepRow(
                          number: '١',
                          text: 'افتح تطبيق البريد الإلكتروني'),
                      SizedBox(height: 10),
                      _StepRow(
                          number: '٢',
                          text: 'ابحث عن بريد من "صيدليتك"'),
                      SizedBox(height: 10),
                      _StepRow(
                          number: '٣',
                          text: 'اضغط على رابط التحقق في البريد'),
                      SizedBox(height: 10),
                      _StepRow(
                          number: '٤',
                          text: 'عد هنا واضغط "تحققت ✓"'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String number;
  final String text;

  const _StepRow({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.12),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
