import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:synchronized/synchronized.dart';
import 'package:inspirelymd_patient/core/common/events/auth_event.dart';
import 'package:inspirelymd_patient/core/common/models/auth_tokens/auth_tokens.dart';
import 'package:inspirelymd_patient/core/common/repositories/i_event_bus_repository.dart';
import 'package:inspirelymd_patient/core/network/api/api_endpoints.dart';
import 'package:inspirelymd_patient/core/network/api/request_extras.dart';
import 'package:inspirelymd_patient/core/network/interceptors/platform_info_interceptor.dart';
import 'package:inspirelymd_patient/core/services/device_header/platform_info_service.dart';
import 'package:inspirelymd_patient/core/services/token/token_service.dart';

class AuthInterceptor extends Interceptor {
  final TokenService tokenService;
  final PlatformInfoService platformInfoService;

  final Lock _refreshLock = Lock();
  Dio? _refreshDio;

  AuthInterceptor(this.tokenService, this.platformInfoService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isPublic = options.extra[RequestExtras.isPublic] ?? false;

    if (!isPublic) {
      try {
        await _refreshLock.synchronized(() async {
          final isExpired = await tokenService.isAccessTokenAboutToExpired();
          if (isExpired) await _refreshToken();
        });
      } on DioException catch (e) {
        if (e.response != null) return handler.resolve(e.response!);
        return handler.reject(e);
      } catch (e) {
        return handler.reject(DioException(requestOptions: options, error: e));
      }

      final accessToken = await tokenService.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    handler.next(options);
  }

  Future<void> _refreshToken() async {
    try {
      _refreshDio ??= Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          contentType: 'application/json',
        ),
      )..interceptors.add(PlatformInfoInterceptor(platformInfoService));

      final refreshToken = await tokenService.getRefreshToken();
      final accessToken = await tokenService.getAccessToken();

      if (refreshToken == null || refreshToken.isEmpty) return;

      final response = await _refreshDio!.post(
        ApiEndpoints.auth.refresh,
        data: null,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'x-refresh-token': refreshToken,
          },
          extra: {RequestExtras.isPublic: true},
        ),
      );

      final data = response.data?['data'];
      if (data != null) {
        await tokenService.saveTokens(
          AuthTokens(
            accessToken: data['accessToken'] ?? '',
            refreshToken: data['refreshToken'] ?? '',
            accessExpireAt: data['accessExpireAt'] ?? '',
            refreshExpireAt: data['refreshExpireAt'] ?? '',
            tokenIssuedAt: data['tokenIssuedAt'] ?? '',
          ),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await tokenService.clearTokens();
        if (Get.isRegistered<IEventBusRepository>()) {
          Get.find<IEventBusRepository>().fire(const SessionExpiredEvent());
        }
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await tokenService.clearTokens();
      if (Get.isRegistered<IEventBusRepository>()) {
        Get.find<IEventBusRepository>().fire(const SessionExpiredEvent());
      }
    }
    super.onError(err, handler);
  }
}
