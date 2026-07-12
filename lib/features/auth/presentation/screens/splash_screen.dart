// splash_screen.dart
// Responsible for: showing the app logo while checking if a user is already logged in.
// Dispatches AuthCheckStatus to the AuthBloc and then navigates based on the result.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/splash_background_decoration.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/splash_logo_glow.dart';
import 'package:flutter_application_1/features/auth/presentation/widgets/splash_dots_loader.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AuthBloc _authBloc;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _translateAnimation;
  late final Animation<double> _glowAnimation;
  late final Animation<double> _dotScale1;
  late final Animation<double> _dotScale2;
  late final Animation<double> _dotScale3;
  Timer? _statusTimer;
  final List<String> _statusMessages = [
    AppStrings.splashVerifying,
    AppStrings.splashLoadingData,
    AppStrings.splashWelcome,
  ];
  int _statusIndex = 0;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>();

    // Initializing animations for a premium visual effect
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _translateAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.15, end: 0.28).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // three-dot loader scales (staggered via intervals)
    _dotScale1 = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeInOut)),
    );
    _dotScale2 = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.2, 0.8, curve: Curves.easeInOut)),
    );
    _dotScale3 = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.4, 1.0, curve: Curves.easeInOut)),
    );

    // repeat animations to create continuous subtle motion
    _animationController.repeat(reverse: true);

    // status message rotator
    _statusTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _statusIndex = (_statusIndex + 1) % _statusMessages.length);
    });

    // Verify session status after splash animations
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        _authBloc.add(const AuthCheckStatus());
      }
    });
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => _authBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen(user: state.user)),
            );
          } else if (state is AuthPendingEmailVerification) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => EmailVerificationScreen(
                  pendingUser: state.pendingUser,
                ),
              ),
            );
          } else if (state is AuthUnauthenticated || state is AuthError) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, AppColors.primary.withValues(alpha: 0.08)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                SplashBackgroundDecoration(
                  animationController: _animationController,
                ),
                SplashLogoGlow(
                  fadeAnimation: _fadeAnimation,
                  translateAnimation: _translateAnimation,
                  scaleAnimation: _scaleAnimation,
                  glowAnimation: _glowAnimation,
                ),
                SplashDotsLoader(
                  animationController: _animationController,
                  dotScale1: _dotScale1,
                  dotScale2: _dotScale2,
                  dotScale3: _dotScale3,
                  statusMessage: _statusMessages[_statusIndex],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
