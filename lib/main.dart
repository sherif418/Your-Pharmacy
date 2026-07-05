// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/state/medicine_cubit.dart';

void main() {
  runApp(const YourPharmacyApp());
}

class YourPharmacyApp extends StatelessWidget {
  const YourPharmacyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        // Add more routes here as needed
      ],
    );

    return BlocProvider(
      create: (_) => MedicineCubit()..loadMedicines(),
      child: MaterialApp.router(
        title: 'Your Pharmacy',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
