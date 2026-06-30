import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('\n🚀 [REQUEST] ${options.method.toUpperCase()} | ${options.uri}');
    if (options.headers.isNotEmpty) debugPrint('Headers: ${options.headers}');
    if (options.queryParameters.isNotEmpty) debugPrint('Query: ${options.queryParameters}');
    if (options.data != null) debugPrint('Body: ${options.data}');
    debugPrint('\n');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('\n✅ [RESPONSE] ${response.statusCode} | ${response.requestOptions.uri}');
    if (response.data != null) debugPrint('Data: ${response.data}');
    debugPrint('\n');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('\n⚠ [ERROR] ${err.response?.statusCode} | ${err.requestOptions.uri}');
    debugPrint('Message: ${err.message}');
    debugPrint('\n');
    super.onError(err, handler);
  }
}
