import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/usecase/get_countries_usecase.dart';
import 'package:inspirelymd_patient/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/send_otp_controller.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/verify_otp_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
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
    Get.lazyPut<SendOtpController>(
      () => SendOtpController(
        Get.find<GetCountriesUseCase>(),
        Get.find<SendOtpUseCase>(),
      ),
    );
    Get.lazyPut<VerifyOtpController>(
      () => VerifyOtpController(
        Get.find<VerifyOtpUseCase>(),
      ),
    );
  }
}
