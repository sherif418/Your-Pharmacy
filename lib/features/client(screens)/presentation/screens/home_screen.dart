// home_screen.dart
// Responsible for: showing the main home screen after login.
// Displays a greeting with user info and a dynamic bottom nav bar based on user role.
// No account-switch widget at the top. No offers/discounts.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/feature_card.dart';
import 'package:flutter_application_1/service_locator.dart';

class HomeScreen extends StatefulWidget {
  final AppUser user;

  const HomeScreen({super.key, required this.user});
  static const String id = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onNavTapped(int index) {
    setState(() => _currentIndex = index);
  }

  void _onLogout(BuildContext context) {
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  // ── Messages section ───────────────────────────────────────
  Widget _buildMessagesSection(List<String> messages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.homeMessagesTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.spaceMD),
        ...messages.map((message) => Container(
              margin: const EdgeInsets.only(bottom: AppSizes.spaceSM),
              padding: const EdgeInsets.all(AppSizes.paddingCard),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                border: Border.all(color: AppColors.border, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_active_outlined,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSizes.spaceMD),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  // ── Customer body widgets ──────────────────────────────────
  Widget _buildCustomerHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Greeting card ──────────────────────────────────
          _GreetingCard(user: widget.user),
          const SizedBox(height: AppSizes.spaceLG),

          // ── Messages section ───────────────────────────────
          _buildMessagesSection([
            AppStrings.clientMessage1,
            AppStrings.clientMessage2,
          ]),
          const SizedBox(height: AppSizes.spaceLG),

          // ── Feature cards grid ─────────────────────────────
          Text(
            'الخدمات',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSizes.spaceMD,
            mainAxisSpacing: AppSizes.spaceMD,
            children: const [
              FeatureCard(
                title: AppStrings.homeOrderMedicine,
                icon: Icons.medication_rounded,
              ),
              FeatureCard(
                title: AppStrings.homeUploadPrescription,
                icon: Icons.upload_file_rounded,
              ),
              FeatureCard(
                title: AppStrings.homeMyOrders,
                icon: Icons.receipt_long_rounded,
              ),
              FeatureCard(
                title: AppStrings.homeChronicMeds,
                icon: Icons.favorite_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Pharmacist body widgets ────────────────────────────────
  Widget _buildPharmacistHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GreetingCard(user: widget.user),
          const SizedBox(height: AppSizes.spaceLG),

          // ── Messages section ───────────────────────────────
          _buildMessagesSection([
            AppStrings.pharmacistMessage1,
            AppStrings.pharmacistMessage2,
          ]),
          const SizedBox(height: AppSizes.spaceLG),

          Text(
            'لوحة التحكم',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSizes.spaceMD,
            mainAxisSpacing: AppSizes.spaceMD,
            children: const [
              FeatureCard(
                title: AppStrings.pharmacistNewOrders,
                icon: Icons.inbox_rounded,
              ),
              FeatureCard(
                title: AppStrings.pharmacistPrepareOrder,
                icon: Icons.local_pharmacy_rounded,
              ),
              FeatureCard(
                title: AppStrings.pharmacistCustomers,
                icon: Icons.people_rounded,
              ),
              FeatureCard(
                title: AppStrings.pharmacistTotalOrders,
                icon: Icons.bar_chart_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final isPharmacist = widget.user.role == 'pharmacist';

    // Tab 0 → Home
    if (_currentIndex == 0) {
      return isPharmacist ? _buildPharmacistHome() : _buildCustomerHome();
    }

    // Remaining tabs – placeholder for now
    return Center(
      child: Text(
        'قريباً...',
        style: TextStyle(
          fontSize: 18,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (_, current) => current is AuthUnauthenticated,
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.appName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.background,
            elevation: 0,
            actions: [
              Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.logout_rounded, color: AppColors.primary),
                  tooltip: AppStrings.logout,
                  onPressed: () => _onLogout(ctx),
                ),
              ),
            ],
          ),
          body: _buildBody(),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onNavTapped,
            role: widget.user.role,
          ),
        ),
      ),
    );
  }
}

// ── Greeting Card ────────────────────────────────────────────────
class _GreetingCard extends StatelessWidget {
  final AppUser user;

  const _GreetingCard({required this.user});

  String get _roleLabel => user.role == 'pharmacist'
      ? AppStrings.homeRolePharmacist
      : AppStrings.homeRoleCustomer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingCard),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: AppSizes.avatarMD / 2,
            backgroundColor: AppColors.secondary,
            child: Text(
              user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spaceMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppStrings.homeGreeting} ${user.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textOnPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceXXS),
                Row(
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      size: AppSizes.iconSM,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: AppSizes.spaceXXS),
                    Text(
                      _roleLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceXXS),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: AppSizes.iconSM,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: AppSizes.spaceXXS),
                    Text(
                      user.phone,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
