class ApiEndpoints {
  static const String baseUrl = 'https://inspirelymd-mock-api.fastapicloud.dev/api/v1';

  static const auth = _AuthEndpoints();
  static const common = _CommonEndpoints();
}

class _AuthEndpoints {
  const _AuthEndpoints();
  
  String get login => '/auth/login';
  String get register => '/auth/register';
  String get refresh => '/auth/refresh';
  String get logout => '/auth/logout';
  String get sendOtp => '/patient/auth/send-otp';
  String get verifyOtp => '/patient/auth/verify-otp';
}

class _CommonEndpoints {
  const _CommonEndpoints();
  
  String get countries => '/common/countries';
}
