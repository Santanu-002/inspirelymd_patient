import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/usecase/get_countries_usecase.dart';
import 'package:inspirelymd_patient/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:inspirelymd_patient/features/auth/data/datasources/i_auth_remote_datasource.dart';
import 'package:inspirelymd_patient/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:inspirelymd_patient/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Data Sources
    Get.lazyPut<IAuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Get.find<Dio>()),
    );

    // Repositories
    Get.lazyPut<IAuthRepository>(
      () => AuthRepositoryImpl(Get.find<IAuthRemoteDataSource>()),
    );

    // UseCases
    Get.lazyPut<GetCountriesUseCase>(
      () => GetCountriesUseCase(Get.find<IAuthRepository>()),
    );
    Get.lazyPut<SendOtpUseCase>(
      () => SendOtpUseCase(Get.find<IAuthRepository>()),
    );
    Get.lazyPut<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(Get.find<IAuthRepository>()),
    );

    // Controllers
    Get.lazyPut<AuthController>(
      () => AuthController(
        Get.find<GetCountriesUseCase>(),
        Get.find<SendOtpUseCase>(),
        Get.find<VerifyOtpUseCase>(),
      ),
    );
  }
}
