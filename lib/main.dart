// lib/main.dart

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_application_1/core/theme/app_theme.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/service_locator.dart';
import 'package:flutter_application_1/features/client(screens)/presentation/screens/notifications_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureDependencies();

  // ── Device Preview ──────────────────────────────────────────────
  // بيلف التطبيق كله ويعرضه جوه فريم موبايل. شغال بس في وضع الديفلوبمنت
  // (kReleaseMode == false)، وبيتقفل تلقائيًا لو عملت build ريليز.
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const SaydaliatekApp(),
    ),
  );
}

class SaydaliatekApp extends StatelessWidget {
  const SaydaliatekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'صيدليتك',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: DevicePreview.locale(context), // مطلوب لـ Device Preview
          builder: DevicePreview.appBuilder,      // مطلوب لـ Device Preview
          useInheritedMediaQuery: true,           // مطلوب لـ Device Preview
          // Start with splash screen; it will navigate based on auth state
          home: const SplashScreen(),
          routes: {
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.register: (context) => const RegisterScreen(),
              AppRoutes.notifications: (context) => const NotificationsScreen(),
          },
        );
      },
    );
  }
}