// lib/core/network/api_client.dart

import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/constants.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {'Content-Type': 'application/json'},
    ),
  );
}
