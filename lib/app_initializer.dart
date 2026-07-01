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
import 'package:inspirelymd_patient/features/event_bus/data/services/i_event_bus_service.dart';
import 'package:inspirelymd_patient/features/event_bus/data/services/event_bus_service_impl.dart';
import 'package:inspirelymd_patient/features/event_bus/domain/repositories/i_event_bus_repository.dart';
import 'package:inspirelymd_patient/features/event_bus/data/repositories/event_bus_repository_impl.dart';
import 'package:inspirelymd_patient/features/event_bus/domain/usecases/fire_event_usecase.dart';
import 'package:inspirelymd_patient/features/event_bus/domain/usecases/on_event_usecase.dart';
import 'package:inspirelymd_patient/core/services/token/token_service.dart';
import 'package:inspirelymd_patient/core/services/token/token_service_impl.dart';
import 'package:inspirelymd_patient/core/services/database/database_service.dart';

class AppInitializer {
  const AppInitializer._();

  static Future<void> initialize() async {
    debugPrint('INIT: Starting AppInitializer.initialize()');
    
    // Database
    final dbService = DatabaseService();
    await dbService.database; // Trigger onCreate and seeding
    Get.put<DatabaseService>(dbService, permanent: true);

    // Storage
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs, permanent: true);
    Get.put<FlutterSecureStorage>(const FlutterSecureStorage(), permanent: true);
    
    // Event Bus Layer (Service -> Repo -> UseCases)
    final eventBusService = EventBusServiceImpl();
    Get.put<IEventBusService>(eventBusService, permanent: true);

    final eventBusRepository = EventBusRepositoryImpl(eventBusService);
    Get.put<IEventBusRepository>(eventBusRepository, permanent: true);

    Get.put<FireEventUseCase>(FireEventUseCase(eventBusRepository), permanent: true);
    Get.put<OnEventUseCase>(OnEventUseCase(eventBusRepository), permanent: true);

    // Token Service
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

    // HTTP Client
    final networkClient = NetworkClient(
      tokenService: Get.find(),
      platformInfoService: Get.find(),
    );
    Get.put<Dio>(networkClient.dio, permanent: true);
    
    debugPrint('INIT: Completed AppInitializer.initialize()');
  }
}
