import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inspirelymd_patient/core/network/client/client.dart';
import 'package:inspirelymd_patient/core/services/device_header/app_info_service.dart';
import 'package:inspirelymd_patient/core/services/device_header/device_id_service.dart';
import 'package:inspirelymd_patient/core/services/device_header/device_info_service.dart';
import 'package:inspirelymd_patient/core/services/device_header/platform_info_service.dart';
import 'package:inspirelymd_patient/core/common/repositories/i_event_bus_repository.dart';
import 'package:inspirelymd_patient/core/common/repositories/event_bus_repository_impl.dart';
import 'package:inspirelymd_patient/core/services/token/token_service.dart';
import 'package:inspirelymd_patient/core/services/token/token_service_impl.dart';

class AppInitializer {
  const AppInitializer._();

  static Future<void> initialize() async {
    debugPrint('INIT: Starting AppInitializer.initialize()');
    
    // Storage
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs, permanent: true);
    Get.put<FlutterSecureStorage>(const FlutterSecureStorage(), permanent: true);
    
    // Services
    Get.put<IEventBusRepository>(EventBusRepositoryImpl(), permanent: true);
    Get.put<TokenService>(TokenServiceImpl(Get.find()), permanent: true);

    // Device headers
    final deviceIdService = DeviceIdService(Get.find<FlutterSecureStorage>());
    Get.put<DeviceIdService>(deviceIdService, permanent: true);

    Get.put<DeviceInfoService>(
      DeviceInfoService(deviceIdService),
      permanent: true,
    );

    Get.put<AppInfoService>(AppInfoService(), permanent: true);

    Get.put<PlatformInfoService>(
      PlatformInfoService(
        deviceInfoService: Get.find(),
        appInfoService: Get.find(),
      ),
      permanent: true,
    );

    // Network
    final networkClient = NetworkClient(
      tokenService: Get.find(),
      platformInfoService: Get.find(),
    );
    Get.put<Dio>(networkClient.dio, permanent: true);
    
    debugPrint('INIT: AppInitializer complete.');
  }
}
