// home_models.dart
// Responsible for: defining lightweight home screen data models used by the client dashboard.
// These models are used by widget constructors and mock data until a real backend is connected.

import 'package:flutter/material.dart';

class NextCardData {
  final String title;
  final String time;
  final String subtitle;
  final double progress;
  final IconData icon;

  const NextCardData({
    required this.title,
    required this.time,
    required this.subtitle,
    required this.progress,
    required this.icon,
  });
}

class HealthMetric {
  final String label;
  final String value;
  final bool isHealthy;

  const HealthMetric({
    required this.label,
    required this.value,
    required this.isHealthy,
  });
}

class ScheduleItem {
  final String time;
  final String title;
  final String subtitle;
  final bool done;

  const ScheduleItem({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.done,
  });
}

class CategoryChipData {
  final IconData icon;
  final String label;

  const CategoryChipData({
    required this.icon,
    required this.label,
  });
}

class ProductSummary {
  final String name;
  final String price;
  final double rating;

  const ProductSummary({
    required this.name,
    required this.price,
    required this.rating,
  });
}

class QuickServiceData {
  final IconData icon;
  final String label;

  const QuickServiceData({
    required this.icon,
    required this.label,
  });
}

class ChronicDiseaseData {
  final String diseaseName;
  final String medicineName;
  final String time;
  final bool reminderEnabled;

  const ChronicDiseaseData({
    required this.diseaseName,
    required this.medicineName,
    required this.time,
    required this.reminderEnabled,
  });
}
