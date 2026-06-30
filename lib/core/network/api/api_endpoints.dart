class ApiEndpoints {
  static const String baseUrl = 'http://localhost:8000/api/v1';

  static const auth = _AuthEndpoints();
}

class _AuthEndpoints {
  const _AuthEndpoints();
  
  String get login => '/auth/login';
  String get register => '/auth/register';
  String get refresh => '/auth/refresh';
  String get logout => '/auth/logout';
}
