import 'package:flutter/foundation.dart';

abstract final class AppConstants {
  static const String appName = 'AI Alarm English Pro';
  static const String _apiBaseUrlOverride = String.fromEnvironment('API_BASE_URL');

  static String get apiBaseUrl {
    final override = _apiBaseUrlOverride.trim();
    if (override.isNotEmpty) {
      return override;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'http://10.0.2.2:8000/api',
      _ => 'http://localhost:8000/api',
    };
  }
}
