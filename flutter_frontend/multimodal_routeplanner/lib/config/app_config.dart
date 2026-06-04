class AppConfig {
  static const String baseUrl = String.fromEnvironment('APP_BASE_URL');
  static const String backendPath = String.fromEnvironment('APP_BACKEND_PATH');

  static String get apiUrl => '$baseUrl/$backendPath';

  static void validate() {
    assert(baseUrl.isNotEmpty, 'APP_BASE_URL is not set — build with --dart-define=APP_BASE_URL=https://example.com');
    assert(backendPath.isNotEmpty, 'APP_BACKEND_PATH is not set — build with --dart-define=APP_BACKEND_PATH=api');
  }
}
