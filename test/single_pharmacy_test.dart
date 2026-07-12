import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/features/client(screens)/data/home_mock_data.dart';

void main() {
  test('home quick services use the single-pharmacy location label', () {
    final service = HomeMockData.customerQuickServices.firstWhere(
      (item) => item.label == AppStrings.homePharmacyLocation,
    );

    expect(service.label, AppStrings.homePharmacyLocation);
    expect(service.label, isNot('أقرب صيدلية'));
  });
}
