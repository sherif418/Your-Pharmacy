// home_screen.dart
// Responsible for: showing the main home screen after login.
// Redesigned as a richer dashboard (greeting header, medication reminder,
// health summary, schedule, quick services, categories, best sellers,
// assistant / water / tip cards) inspired by the provided mockup.
//
// IMPORTANT: All AuthBloc / navigation / logout logic is unchanged.
// Everything marked "// TODO: wire to backend" is placeholder/demo data
// because there's no model for health metrics, products, or an AI
// assistant in the current codebase — replace with real data sources
// when those features exist.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/constants/app_sizes.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/features/auth/domain/user.dart';
import 'package:flutter_application_1/features/auth/presentation/screens/login_screen.dart';
import '/features/client(screens)/presentation/widgets/bottom_nav_bar.dart';
import '/features/client(screens)/presentation/widgets/feature_card.dart';
import 'package:flutter_application_1/service_locator.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  final AppUser user;

  const HomeScreen({super.key, required this.user});
  static const String id = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // demo-only local state so the water tracker feels interactive
  int _waterCups = 6;
  static const int _waterGoal = 8;

  void _onNavTapped(int index) {
    setState(() => _currentIndex = index);
  }

  void _onLogout(BuildContext context) {
    Navigator.of(context).pop(); // close drawer if open
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  // ══════════════════════════════════════════════════════════════
  // Messages section (unchanged)
  // ══════════════════════════════════════════════════════════════
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

  // ══════════════════════════════════════════════════════════════
  // Customer dashboard
  // ══════════════════════════════════════════════════════════════
  Widget _buildCustomerHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _DashboardHeader(user: widget.user, notifCount: 3),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _NextMedicationCard(
              // TODO: wire to backend — next dose from reminders module
              medicineName: 'الدواء القادم',
              time: '08:30 مساءً',
              subtitle: 'بعد 45 دقيقة',
              progress: 0.62,
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _HealthSummaryCard(
                    // TODO: wire to backend — vitals module
                    rows: const [
                      _HealthRow(label: 'ضغط الدم', value: 'طبيعي', ok: true),
                      _HealthRow(
                          label: 'مستوى السكر', value: 'يحتاج متابعة', ok: false),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.spaceMD),
                Expanded(
                  flex: 2,
                  child: _PercentRingCard(
                    // TODO: wire to backend — health score calculation
                    title: 'الصحة العامة',
                    percent: 0.92,
                    caption: 'ممتاز',
                    footer: 'استمر على هذا النحو',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _ChronicDiseaseCard(
              // TODO: wire to backend — chronic conditions module
              diseaseName: 'مرض السكر',
              medicineName: 'Metformin 500mg',
              time: '08:30 PM',
              reminderEnabled: true,
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _TodayScheduleCard(
              // TODO: wire to backend — daily medication schedule
              items: const [
                _ScheduleItem(
                    time: '08:00 AM',
                    title: 'Vitamin D',
                    subtitle: '1 حبة بعد الإفطار',
                    done: true),
                _ScheduleItem(
                    time: '09:30 AM',
                    title: 'Insulin',
                    subtitle: 'حقنة قبل الإفطار',
                    done: true),
                _ScheduleItem(
                    time: '12:00 PM',
                    title: 'Panadol',
                    subtitle: '1 حبة بعد الغداء',
                    done: false),
                _ScheduleItem(
                    time: '06:00 PM',
                    title: 'Pressure Medicine',
                    subtitle: '1 حبة بعد العشاء',
                    done: false),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: Text(
              'خدمات سريعة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),
          SizedBox(
            height: 92,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingHorizontal),
              children: const [
                _QuickServiceButton(
                    icon: Icons.medication_rounded, label: 'اطلب دواء'),
                _QuickServiceButton(
                    icon: Icons.upload_file_rounded, label: 'رفع روشتة'),
                _QuickServiceButton(
                    icon: Icons.location_on_rounded, label: 'أقرب صيدلية'),
                _QuickServiceButton(
                    icon: Icons.medical_information_rounded, label: 'أدويتي'),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _buildMessagesSection(
              [AppStrings.clientMessage1, AppStrings.clientMessage2],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          // ── الخدمات الأساسية (نفس FeatureCard الأصلية بدون أي تعديل منطقي) ──
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: Text(
              'الخدمات',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: GridView.count(
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
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: Text(
              'تصنيفات المنتجات',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),
          SizedBox(
            height: 86,
            child: ListView(
              // TODO: wire to backend — product categories catalog
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingHorizontal),
              children: const [
                _CategoryChip(icon: Icons.medication_liquid, label: 'أدوية'),
                _CategoryChip(icon: Icons.spa_rounded, label: 'عناية شخصية'),
                _CategoryChip(icon: Icons.child_care_rounded, label: 'أطفال'),
                _CategoryChip(icon: Icons.favorite_rounded, label: 'قلب'),
                _CategoryChip(icon: Icons.water_drop_rounded, label: 'سكر'),
                _CategoryChip(icon: Icons.masks_rounded, label: 'برد وإنفلونزا'),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'الأكثر طلباً',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('عرض الكل',
                      style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 190,
            child: ListView(
              // TODO: wire to backend — products catalog / prices / ratings
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingHorizontal),
              children: const [
                _ProductCard(name: 'Panadol', price: '45', rating: 4.8),
                _ProductCard(name: 'Brufen', price: '35', rating: 4.6),
                _ProductCard(name: 'Augmentin', price: '65', rating: 4.7),
                _ProductCard(name: 'Vitamin D3', price: '55', rating: 4.9),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppSizes.spaceMD,
              mainAxisSpacing: AppSizes.spaceMD,
              childAspectRatio: 1.05,
              children: [
                const _PrescriptionUploadCard(),
                const _AssistantCard(),
                _WaterTrackerCard(
                  cups: _waterCups,
                  goal: _waterGoal,
                  onAddCup: () => setState(() {
                    if (_waterCups < _waterGoal) _waterCups++;
                  }),
                ),
                const _TipOfTheDayCard(
                  tip: 'تناول الدواء بعد الطعام للحصول على أفضل امتصاص.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // Pharmacist dashboard
  // ══════════════════════════════════════════════════════════════
  Widget _buildPharmacistHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _DashboardHeader(user: widget.user, notifCount: 5),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _NextMedicationCard(
              // TODO: wire to backend — next pending order in queue
              medicineName: 'أقرب طلب',
              time: 'طلب #1042',
              subtitle: 'بانتظار التحضير',
              progress: 0.35,
              icon: Icons.inbox_rounded,
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _HealthSummaryCard(
                    // TODO: wire to backend — pharmacy operations summary
                    title: 'ملخص اليوم',
                    icon: Icons.storefront_rounded,
                    rows: const [
                      _HealthRow(label: 'طلبات مكتملة', value: '18', ok: true),
                      _HealthRow(label: 'طلبات معلقة', value: '4', ok: false),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.spaceMD),
                Expanded(
                  flex: 2,
                  child: _PercentRingCard(
                    // TODO: wire to backend — performance metric
                    title: 'أداء اليوم',
                    percent: 0.85,
                    caption: 'جيد جداً',
                    footer: 'استمر بنفس الوتيرة',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _TodayScheduleCard(
              // TODO: wire to backend — pending orders queue
              title: 'طلبات اليوم',
              icon: Icons.receipt_long_rounded,
              items: const [
                _ScheduleItem(
                    time: '10:15 AM',
                    title: 'طلب #1038',
                    subtitle: 'أحمد محمد — 3 أصناف',
                    done: true),
                _ScheduleItem(
                    time: '11:40 AM',
                    title: 'طلب #1039',
                    subtitle: 'سارة علي — روشتة مرفقة',
                    done: true),
                _ScheduleItem(
                    time: '01:20 PM',
                    title: 'طلب #1041',
                    subtitle: 'محمود حسن — 1 صنف',
                    done: false),
                _ScheduleItem(
                    time: '02:05 PM',
                    title: 'طلب #1042',
                    subtitle: 'منى إبراهيم — 5 أصناف',
                    done: false),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: Text(
              'خدمات سريعة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),
          SizedBox(
            height: 92,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingHorizontal),
              children: const [
                _QuickServiceButton(
                    icon: Icons.inbox_rounded, label: 'طلبات جديدة'),
                _QuickServiceButton(
                    icon: Icons.local_pharmacy_rounded, label: 'تحضير طلب'),
                _QuickServiceButton(
                    icon: Icons.people_rounded, label: 'العملاء'),
                _QuickServiceButton(
                    icon: Icons.bar_chart_rounded, label: 'التقارير'),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: _buildMessagesSection(
              [AppStrings.pharmacistMessage1, AppStrings.pharmacistMessage2],
            ),
          ),
          const SizedBox(height: AppSizes.spaceLG),

          // ── لوحة التحكم (نفس FeatureCard الأصلية بدون أي تعديل منطقي) ──
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: Text(
              'لوحة التحكم',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceMD),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: GridView.count(
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
          ),
          const SizedBox(height: AppSizes.spaceMD),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingHorizontal),
            child: const _TipOfTheDayCard(
              tip: 'راجع الروشتات المرفقة جيداً قبل تأكيد صرف الطلب.',
            ),
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
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: AppColors.background,
            extendBodyBehindAppBar: false,
            drawer: _AppDrawer(
              user: widget.user,
              onLogout: () => _onLogout(context),
            ),
            body: SafeArea(child: _buildBody()),
            bottomNavigationBar: AppBottomNavBar(
              currentIndex: _currentIndex,
              onTap: _onNavTapped,
              role: widget.user.role,
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Drawer (holds logout — replaces the old AppBar logout button since
// the new header no longer uses a standard AppBar)
// ════════════════════════════════════════════════════════════════
class _AppDrawer extends StatelessWidget {
  final AppUser user;
  final VoidCallback onLogout;
  const _AppDrawer({required this.user, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.paddingCard),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: AppSizes.avatarMD / 2,
                    backgroundColor: AppColors.secondary,
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 20,
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
                        Text(user.name,
                            style: const TextStyle(
                              color: AppColors.textOnPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        Text(
                          user.role == 'pharmacist'
                              ? AppStrings.homeRolePharmacist
                              : AppStrings.homeRoleCustomer,
                          style: const TextStyle(
                              color: AppColors.secondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),
            ListTile(
              leading: const Icon(Icons.person_outline, color: AppColors.primary),
              title: const Text('الملف الشخصي'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: AppColors.primary),
              title: const Text('الإعدادات'),
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              title: const Text(AppStrings.logout,
                  style: TextStyle(color: Colors.redAccent)),
              onTap: onLogout,
            ),
            const SizedBox(height: AppSizes.spaceMD),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Header: menu + greeting + notifications + avatar
// ════════════════════════════════════════════════════════════════
class _DashboardHeader extends StatelessWidget {
  final AppUser user;
  final int notifCount;
  const _DashboardHeader({required this.user, this.notifCount = 0});

  String get _greetingWord {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'صباح الخير';
    if (hour < 18) return 'مساء الخير';
    return 'مساء الخير';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) => _CircleIconButton(
            icon: Icons.menu_rounded,
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        const SizedBox(width: AppSizes.spaceMD),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('👋 $_greetingWord',
                  style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text('${AppStrings.homeGreeting} ${user.name}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary)),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _CircleIconButton(
              icon: Icons.notifications_none_rounded,
              onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
            ),
            if (notifCount > 0)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      color: Colors.redAccent, shape: BoxShape.circle),
                  constraints:
                      const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '$notifCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: AppSizes.spaceSM),
        CircleAvatar(
          radius: AppSizes.avatarMD / 2,
          backgroundColor: AppColors.secondary,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadow, blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Next medication / next order — circular progress card
// ════════════════════════════════════════════════════════════════
class _NextMedicationCard extends StatelessWidget {
  final String medicineName;
  final String time;
  final String subtitle;
  final double progress; // 0..1
  final IconData icon;

  const _NextMedicationCard({
    required this.medicineName,
    required this.time,
    required this.subtitle,
    required this.progress,
    this.icon = Icons.medication_rounded,
  });

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
          BoxShadow(color: AppColors.shadow, blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medicineName,
                    style: const TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(time,
                    style: const TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.secondary, fontSize: 12)),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 12, color: Colors.white),
                  label: const Text('عرض الكل',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: Colors.white.withOpacity(0.25),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
                Icon(icon, color: Colors.white, size: 26),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Health summary card (rows of small stats)
// ════════════════════════════════════════════════════════════════
class _HealthRow {
  final String label;
  final String value;
  final bool ok;
  const _HealthRow({required this.label, required this.value, required this.ok});
}

class _HealthSummaryCard extends StatelessWidget {
  final List<_HealthRow> rows;
  final String title;
  final IconData icon;
  const _HealthSummaryCard({
    required this.rows,
    this.title = 'ملخص حالتك الصحية',
    this.icon = Icons.health_and_safety_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...rows.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      r.ok ? Icons.check_circle_rounded : Icons.error_rounded,
                      color: r.ok ? AppColors.primary : Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(r.value,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: r.ok ? AppColors.primary : Colors.orange)),
                    ),
                    Text(r.label,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Percentage ring card (general health / performance)
// ════════════════════════════════════════════════════════════════
class _PercentRingCard extends StatelessWidget {
  final String title;
  final double percent; // 0..1
  final String caption;
  final String footer;
  const _PercentRingCard({
    required this.title,
    required this.percent,
    required this.caption,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.shield_moon_rounded,
                  color: AppColors.primary, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 66,
            height: 66,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: percent,
                  strokeWidth: 6,
                  backgroundColor: AppColors.border,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
                Text('${(percent * 100).round()}%',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(caption,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
          const SizedBox(height: 2),
          Text(footer,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 10, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Chronic disease card
// ════════════════════════════════════════════════════════════════
class _ChronicDiseaseCard extends StatelessWidget {
  final String diseaseName;
  final String medicineName;
  final String time;
  final bool reminderEnabled;
  const _ChronicDiseaseCard({
    required this.diseaseName,
    required this.medicineName,
    required this.time,
    required this.reminderEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.medication_liquid_rounded,
                color: AppColors.primary, size: 26),
          ),
          const SizedBox(width: AppSizes.spaceMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('متابعة الأمراض المزمنة',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(diseaseName,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text('$medicineName  •  $time',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            reminderEnabled
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          const Text('تذكير مفعل',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.border),
                          padding:
                              const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('إدارة التذكيرات',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.textPrimary)),
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

// ════════════════════════════════════════════════════════════════
// Today schedule card
// ════════════════════════════════════════════════════════════════
class _ScheduleItem {
  final String time;
  final String title;
  final String subtitle;
  final bool done;
  const _ScheduleItem({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.done,
  });
}

class _TodayScheduleCard extends StatelessWidget {
  final List<_ScheduleItem> items;
  final String title;
  final IconData icon;
  const _TodayScheduleCard({
    required this.items,
    this.title = 'جدول أدوية اليوم',
    this.icon = Icons.calendar_today_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 16),
              const SizedBox(width: 6),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map((it) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      it.done
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                      size: 18,
                      color: it.done ? AppColors.primary : AppColors.border,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(it.title,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary)),
                          Text(it.subtitle,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    Text(it.time,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Quick service circular button
// ════════════════════════════════════════════════════════════════
class _QuickServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickServiceButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.spaceMD),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          width: 74,
          child: Column(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 6,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(height: 6),
              Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10.5, color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Category chip
// ════════════════════════════════════════════════════════════════
class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CategoryChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.spaceMD),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 10.5, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Product card (best sellers)
// ════════════════════════════════════════════════════════════════
class _ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  const _ProductCard({
    required this.name,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(left: AppSizes.spaceMD),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(color: AppColors.shadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.medication_rounded,
                color: AppColors.primary, size: 30),
          ),
          const SizedBox(height: 8),
          Text(name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.star_rounded, size: 13, color: Colors.amber),
              const SizedBox(width: 2),
              Text('$rating',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text('$price EGP',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary)),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.add_shopping_cart_rounded,
                      size: 13, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Small feature cards: prescription upload / assistant / water / tip
// ════════════════════════════════════════════════════════════════
class _PrescriptionUploadCard extends StatelessWidget {
  const _PrescriptionUploadCard();

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.receipt_long_rounded,
              color: AppColors.primary, size: 22),
          const SizedBox(height: 8),
          const Text('لديك روشتة؟',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          const Text('ارفع صورة الروشتة وسنقوم بتحضير طلبك',
              style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.camera_alt_rounded,
                  size: 14, color: Colors.white),
              label: const Text('رفع الآن',
                  style: TextStyle(fontSize: 11, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantCard extends StatelessWidget {
  const _AssistantCard();

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_rounded,
                color: AppColors.primary, size: 18),
          ),
          const SizedBox(height: 8),
          const Text('مساعدك الصحي',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          const Text('هل تناولت جرعة الصباح؟',
              style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('تحدث مع المساعد',
                  style: TextStyle(fontSize: 11, color: AppColors.primary)),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaterTrackerCard extends StatelessWidget {
  final int cups;
  final int goal;
  final VoidCallback onAddCup;
  const _WaterTrackerCard({
    required this.cups,
    required this.goal,
    required this.onAddCup,
  });

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.water_drop_rounded, color: Colors.blue, size: 22),
          const SizedBox(height: 8),
          const Text('شرب الماء',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text('$cups / $goal أكواب',
              style: const TextStyle(
                  fontSize: 10.5, color: AppColors.textSecondary)),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAddCup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('سجل كوب ماء',
                  style: TextStyle(fontSize: 11, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipOfTheDayCard extends StatelessWidget {
  final String tip;
  const _TipOfTheDayCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_rounded, color: Colors.amber, size: 22),
          const SizedBox(height: 8),
          const Text('نصيحة اليوم',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Expanded(
            child: Text(tip,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textSecondary)),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('عرض المزيد',
                style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Shared card container
// ════════════════════════════════════════════════════════════════
class _DashboardCard extends StatelessWidget {
  final Widget child;
  const _DashboardCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingCard),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: const [
          BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }
}