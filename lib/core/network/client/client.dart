import 'package:dio/dio.dart';
import 'package:inspirelymd_patient/core/network/api/api_endpoints.dart';
import 'package:inspirelymd_patient/core/network/interceptors/auth_interceptor.dart';
import 'package:inspirelymd_patient/core/network/interceptors/logging_interceptor.dart';
import 'package:inspirelymd_patient/core/network/interceptors/network_error_interceptor.dart';
import 'package:inspirelymd_patient/core/network/interceptors/platform_info_interceptor.dart';
import 'package:inspirelymd_patient/core/services/device_header/platform_info_service.dart';
import 'package:inspirelymd_patient/core/services/token/token_service.dart';

class NetworkClient {
  late final Dio dio;

  NetworkClient({
    required TokenService tokenService,
    required PlatformInfoService platformInfoService,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            contentType: 'application/json',
          ),
        ) {
    dio.interceptors.add(AuthInterceptor(tokenService, platformInfoService));
    dio.interceptors.add(PlatformInfoInterceptor(platformInfoService));
    dio.interceptors.add(NetworkErrorInterceptor());
    dio.interceptors.add(LoggingInterceptor());
  }
}
