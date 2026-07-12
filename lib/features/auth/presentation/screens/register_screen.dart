// register_screen.dart — Enhanced UI
// Medical Green + White Theme
// Full details, shadows, gradient, cards

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/core/validators/app_validators.dart';
import 'package:flutter_application_1/core/widgets/app_logo.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:flutter_application_1/service_locator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String id = 'register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController     = TextEditingController();
  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _phoneController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm  = true;
  String? _selectedDeliveryArea;

  final List<String> _deliveryAreas = const [
    'قرية السلام',
    'قرية الأمل',
    'قرية النور',
    'قرية الروضة',
    'قرية السعادة',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed(BuildContext context) {
    if (_selectedDeliveryArea == null) {
      _showSnack(context, AppStrings.registerSelectVillage, isError: true);
      return;
    }
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthRegisterRequested(
          name:     _nameController.text.trim(),
          email:    _emailController.text.trim(),
          phone:    _phoneController.text.trim(),
          password: _passwordController.text,
          role:     'customer',
          village:  _selectedDeliveryArea!,
        ),
      );
    }
  }

  void _showSnack(BuildContext context, String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(msg,
              style: const TextStyle(fontWeight: FontWeight.w500))),
        ]),
        backgroundColor: isError ? AppColors.error : AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
        elevation: 6,
      ),
    );
  }

  // ── Field Label ─────────────────────────────────────────────────
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6, right: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        shadows: [Shadow(color: AppColors.primary.withValues(alpha: 0.18), blurRadius: 4,
            offset: const Offset(0, 1))],
      ),
    ),
  );

  // ── Styled Input Decoration ─────────────────────────────────────
  InputDecoration _inputDeco({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
        prefixIcon: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      );

  // ── Card Wrapper with Shadow ────────────────────────────────────
  Widget _card(Widget child) => Container(
    decoration: BoxDecoration(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: Offset(0, 4)),
        BoxShadow(color: AppColors.shadow, blurRadius: 4, offset: Offset(0, 1)),
      ],
    ),
    child: child,
  );

  // ── Section Title ───────────────────────────────────────────────
  Widget _sectionTitle(String text, IconData icon) => Row(
    children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 16),
      ),
      const SizedBox(width: 8),
      Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
          letterSpacing: 0.3,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(child: Container(height: 1,
          color: AppColors.border.withOpacity(0.6))),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (_, current) =>
            current is AuthEmailVerificationSent || current is AuthError,
        listener: (context, state) {
          if (state is AuthEmailVerificationSent) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => getIt<AuthBloc>(),
                  child: EmailVerificationScreen(
                      pendingUser: state.pendingUser),
                ),
              ),
            );
          } else if (state is AuthError) {
            _showSnack(context, state.message, isError: true);
          }
        },
        buildWhen: (_, current) =>
            current is AuthLoading ||
            current is AuthEmailVerificationSent ||
            current is AuthError ||
            current is AuthInitial,
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            // ── Gradient Background ───────────────────────────────
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primarySoft, AppColors.cardBackground],
                  stops: [0.0, 0.35],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [

                    // ── Custom AppBar ───────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          // Back Button
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [BoxShadow(
                                  color: AppColors.shadow, blurRadius: 8,
                                  offset: Offset(0, 2))],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.primary, size: 18),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            AppStrings.registerTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                              shadows: [Shadow(
                                  color: AppColors.primary.withOpacity(0.13),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2))],
                            ),
                          ),
                          const Spacer(),
                          // Balance spacer
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),

                    // ── Scrollable Body ─────────────────────────────
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // ── Logo + Welcome ──────────────────────
                              Center(
                                child: Column(
                                  children: [
                                    // Logo with green glow
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: AppColors.cardBackground,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary.withOpacity(0.2),
                                            blurRadius: 24,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const AppLogo(
                                          size: AppSizes.logoSizeSM,
                                          showName: false),
                                    ),
                                    const SizedBox(height: 14),
                                    const Text(
                                      AppStrings.registerTitle,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primary,
                                        shadows: [Shadow(
                                            color: AppColors.primary,
                                            blurRadius: 8,
                                            offset: Offset(0, 2))],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      AppStrings.registerWelcome,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textHint,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 28),

                              // ══ CARD 1: Personal Info ═══════════════
                              _sectionTitle(AppStrings.registerPersonalInfoTitle,
                                  Icons.person_outline_rounded),
                              const SizedBox(height: 12),

                              _card(
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [

                                      // Name
                                      _label(AppStrings.registerNameLabel),
                                      TextFormField(
                                        controller: _nameController,
                                        keyboardType: TextInputType.name,
                                        validator: AppValidators.validateName,
                                        decoration: _inputDeco(
                                          hint: AppStrings.registerNameHint,
                                          icon: Icons.badge_outlined,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Phone
                                      _label(AppStrings.registerPhoneLabel),
                                      TextFormField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        validator: AppValidators.validatePhone,
                                        decoration: _inputDeco(
                                          hint: AppStrings.registerPhoneHint,
                                          icon: Icons.phone_outlined,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Delivery area for the single pharmacy's delivery coverage
                                      _label(AppStrings.registerVillageLabel),
                                 DropdownButtonFormField<String>(
  value: _selectedDeliveryArea,
  decoration: _inputDeco(
    hint: AppStrings.registerVillageHint,
    icon: Icons.location_on_outlined,
  ),
  dropdownColor: AppColors.cardBackground,
  borderRadius: BorderRadius.circular(16),
  icon: const Icon(
    Icons.keyboard_arrow_down_rounded,
    color: AppColors.primary,
  ),
  items: _deliveryAreas.map((v) => DropdownMenuItem(
    value: v,
    child: Text(
      v,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
    ),
  )).toList(),
  onChanged: (val) => setState(() => _selectedDeliveryArea = val),


                                      ),
                                    ],
                                  ),
                                ),
                              ),
                               SizedBox(height: 20),

                              // ══ CARD 2: Account Info ═════════════════
                              _sectionTitle(AppStrings.registerAccountInfoTitle,
                                  Icons.lock_outline_rounded),
                              const SizedBox(height: 12),

                              _card(
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [

                                      // Email
                                      _label(AppStrings.registerEmailLabel),
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator:
                                            AppValidators.validateEmail,
                                        decoration: _inputDeco(
                                          hint: AppStrings.registerEmailHint,
                                          icon: Icons.email_outlined,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Password
                                      _label(AppStrings.registerPasswordLabel),
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscurePassword,
                                        validator:
                                            AppValidators.validatePassword,
                                        decoration: _inputDeco(
                                          hint: AppStrings.registerPasswordHint,
                                          icon: Icons.lock_outline_rounded,
                                          suffix: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: AppColors.primary, size: 20,
                                            ),
                                            onPressed: () => setState(() =>
                                                _obscurePassword =
                                                    !_obscurePassword),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Password strength hint
                                      Row(children: [
                                        const Icon(Icons.info_outline,
                                            size: 12, color: AppColors.textHint),
                                        const SizedBox(width: 4),
                                        const Text(
                                          AppStrings.registerPasswordHint8Chars,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.textHint),
                                        ),
                                      ]),
                                      const SizedBox(height: 16),

                                      // Confirm Password
                                      _label(AppStrings.registerConfirmPasswordLabel),
                                      TextFormField(
                                        controller:
                                            _confirmPasswordController,
                                        obscureText: _obscureConfirm,
                                        validator: (v) =>
                                            AppValidators
                                                .validateConfirmPassword(
                                                    v, _passwordController.text),
                                        decoration: _inputDeco(
                                          hint: AppStrings
                                              .registerConfirmPasswordHint,
                                          icon: Icons.lock_outline_rounded,
                                          suffix: IconButton(
                                            icon: Icon(
                                              _obscureConfirm
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: AppColors.primary, size: 20,
                                            ),
                                            onPressed: () => setState(() =>
                                                _obscureConfirm =
                                                    !_obscureConfirm),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),

                              // ── Register Button ─────────────────────
                              Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: const LinearGradient(
                                    colors: [AppColors.primary, AppColors.primaryLight],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.26),
                                      blurRadius: 20,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => _onRegisterPressed(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 24, height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ))
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              AppStrings.registerButton,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(Icons.arrow_forward_ios_rounded,
                                                color: Colors.white, size: 16),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // ── Divider ─────────────────────────────
                              Row(children: [
                                Expanded(child: Container(
                                    height: 1,
                                    color: AppColors.border.withOpacity(0.5))),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text('أو',
                                      style: TextStyle(
                                          color: AppColors.textHint, fontSize: 13)),
                                ),
                                Expanded(child: Container(
                                    height: 1,
                                    color: AppColors.border.withOpacity(0.5))),
                              ]),
                              const SizedBox(height: 16),

                              // ── Login Link ──────────────────────────
                              Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      AppStrings.registerHaveAccount,
                                      style: TextStyle(
                                          color: AppColors.textHint, fontSize: 14),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.primarySoft,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.border, width: 1),
                                        ),
                                        child: const Text(
                                          AppStrings.registerLoginLink,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} // End Class