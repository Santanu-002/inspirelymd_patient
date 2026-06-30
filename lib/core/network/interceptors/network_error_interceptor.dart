import 'package:dio/dio.dart';
import 'package:inspirelymd_patient/core/exception/api_exception.dart';

class NetworkErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = 'Something went wrong';
    dynamic errorData;

    if (err.response?.data != null && err.response?.data is Map) {
      final data = err.response?.data as Map<String, dynamic>;
      if (data.containsKey('success') && data.containsKey('message')) {
        message = data['message'];
        errorData = data['data'];
      } else {
        message = data['message'] ?? message;
      }
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      message = 'Connection timed out. Please check your internet connection.';
    } else if (err.type == DioExceptionType.connectionError) {
      message = 'No internet connection.';
    }

    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: ApiException(
          message: message,
          statusCode: err.response?.statusCode,
          data: errorData,
        ),
      ),
    );
  }
}
