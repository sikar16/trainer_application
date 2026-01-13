import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get baseUrl => _get('BASE_URL');
  static String get curriculumBaseUrl => _get('CURRICULUM_BASE_URL');
  static String get apiKey => _get('API_KEY');
  static String get appVersion => _get('APP_VERSION', fallback: '1.0.0');
  static String get buildNumber => _get('BUILD_NUMBER', fallback: '1');

  static int get connectTimeout =>
      int.tryParse(_get('CONNECT_TIMEOUT', fallback: '100000')) ?? 100000;

  static int get receiveTimeout =>
      int.tryParse(_get('RECEIVE_TIMEOUT', fallback: '100000')) ?? 100000;

  static bool get logRequests =>
      _get('LOG_REQUESTS', fallback: 'false').toLowerCase() == 'true';

  static bool get isProduction =>
      _get('ENVIRONMENT', fallback: 'development').toLowerCase() ==
      'production';

  // Helper method to safely get environment variables
  static String _get(String key, {String fallback = ''}) {
    try {
      return dotenv.get(key, fallback: fallback);
    } catch (e) {
      if (kDebugMode) {
        print(
          'Warning: Environment variable $key not found, using fallback: $fallback',
        );
      }
      return fallback;
    }
  }
}
