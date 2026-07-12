// home_mock_data.dart
// Responsible for: providing temporary home screen demo data until the real repository is wired.
// TODO: replace with real repository/API call when the client dashboard backend exists.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/domain/home_models.dart';

class HomeMockData {
  static const List<String> customerMessages = [
    AppStrings.clientMessage1,
    AppStrings.clientMessage2,
  ];

  static const List<String> pharmacistMessages = [
    AppStrings.pharmacistMessage1,
    AppStrings.pharmacistMessage2,
  ];

  static const NextCardData customerNextCard = NextCardData(
    title: 'الدواء القادم',
    time: '08:30 مساءً',
    subtitle: 'بعد 45 دقيقة',
    progress: 0.62,
    icon: Icons.medication_rounded,
  );

  static const NextCardData pharmacistNextCard = NextCardData(
    title: 'أقرب طلب',
    time: 'طلب #1042',
    subtitle: 'بانتظار التحضير',
    progress: 0.35,
    icon: Icons.inbox_rounded,
  );

  static const List<HealthMetric> customerHealthMetrics = [
    HealthMetric(label: 'ضغط الدم', value: 'طبيعي', isHealthy: true),
    HealthMetric(label: 'مستوى السكر', value: 'يحتاج متابعة', isHealthy: false),
  ];

  static const List<HealthMetric> pharmacistHealthMetrics = [
    HealthMetric(label: 'طلبات مكتملة', value: '18', isHealthy: true),
    HealthMetric(label: 'طلبات معلقة', value: '4', isHealthy: false),
  ];

  static const List<ScheduleItem> customerSchedule = [
    ScheduleItem(
      time: '08:00 AM',
      title: 'Vitamin D',
      subtitle: '1 حبة بعد الإفطار',
      done: true,
    ),
    ScheduleItem(
      time: '09:30 AM',
      title: 'Insulin',
      subtitle: 'حقنة قبل الإفطار',
      done: true,
    ),
    ScheduleItem(
      time: '12:00 PM',
      title: 'Panadol',
      subtitle: '1 حبة بعد الغداء',
      done: false,
    ),
    ScheduleItem(
      time: '06:00 PM',
      title: 'Pressure Medicine',
      subtitle: '1 حبة بعد العشاء',
      done: false,
    ),
  ];

  static const List<ScheduleItem> pharmacistSchedule = [
    ScheduleItem(
      time: '10:15 AM',
      title: 'طلب #1038',
      subtitle: 'أحمد محمد — 3 أصناف',
      done: true,
    ),
    ScheduleItem(
      time: '11:40 AM',
      title: 'طلب #1039',
      subtitle: 'سارة علي — روشتة مرفقة',
      done: true,
    ),
    ScheduleItem(
      time: '01:20 PM',
      title: 'طلب #1041',
      subtitle: 'محمود حسن — 1 صنف',
      done: false,
    ),
    ScheduleItem(
      time: '02:05 PM',
      title: 'طلب #1042',
      subtitle: 'منى إبراهيم — 5 أصناف',
      done: false,
    ),
  ];

  static const List<QuickServiceData> customerQuickServices = [
    QuickServiceData(icon: Icons.medication_rounded, label: 'اطلب دواء'),
    QuickServiceData(icon: Icons.upload_file_rounded, label: 'رفع روشتة'),
    QuickServiceData(icon: Icons.location_on_rounded, label: AppStrings.homePharmacyLocation),
    QuickServiceData(icon: Icons.medical_information_rounded, label: 'أدويتي'),
  ];

  static const List<QuickServiceData> pharmacistQuickServices = [
    QuickServiceData(icon: Icons.inbox_rounded, label: 'طلبات جديدة'),
    QuickServiceData(icon: Icons.local_pharmacy_rounded, label: 'تحضير طلب'),
    QuickServiceData(icon: Icons.people_rounded, label: 'العملاء'),
    QuickServiceData(icon: Icons.bar_chart_rounded, label: 'التقارير'),
  ];

  static const List<CategoryChipData> categories = [
    CategoryChipData(icon: Icons.medication_liquid, label: 'أدوية'),
    CategoryChipData(icon: Icons.spa_rounded, label: 'عناية شخصية'),
    CategoryChipData(icon: Icons.child_care_rounded, label: 'أطفال'),
    CategoryChipData(icon: Icons.favorite_rounded, label: 'قلب'),
    CategoryChipData(icon: Icons.water_drop_rounded, label: 'سكر'),
    CategoryChipData(icon: Icons.masks_rounded, label: 'برد وإنفلونزا'),
  ];

  static const List<ProductSummary> bestSellers = [
    ProductSummary(name: 'Panadol', price: '45', rating: 4.8),
    ProductSummary(name: 'Brufen', price: '35', rating: 4.6),
    ProductSummary(name: 'Augmentin', price: '65', rating: 4.7),
    ProductSummary(name: 'Vitamin D3', price: '55', rating: 4.9),
  ];

  static const ChronicDiseaseData customerChronicDisease = ChronicDiseaseData(
    diseaseName: 'مرض السكر',
    medicineName: 'Metformin 500mg',
    time: '08:30 PM',
    reminderEnabled: true,
  );

  static const String customerTipOfTheDay = 'تناول الدواء بعد الطعام للحصول على أفضل امتصاص.';
  static const String pharmacistTipOfTheDay = 'راجع الروشتات المرفقة جيداً قبل تأكيد صرف الطلب.';
}
