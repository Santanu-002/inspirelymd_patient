import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/services/database/database_service.dart';
import 'package:inspirelymd_patient/core/services/token/token_service.dart';
import 'package:inspirelymd_patient/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:inspirelymd_patient/features/auth/data/datasources/i_auth_remote_datasource.dart';
import 'package:inspirelymd_patient/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:inspirelymd_patient/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Data Sources - registered permanently
    Get.put<IAuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(Get.find<DatabaseService>()),
      permanent: true,
    );

    // Repositories - registered permanently
    Get.put<IAuthRepository>(
      AuthRepositoryImpl(
        Get.find<IAuthRemoteDataSource>(),
        Get.find<TokenService>(),
      ),
      permanent: true,
    );

    // UseCases - registered permanently
    Get.put<SignOutUseCase>(
      SignOutUseCase(Get.find<IAuthRepository>()),
      permanent: true,
    );

    // Controllers - registered permanently
    Get.put<AuthController>(
      AuthController(Get.find<SignOutUseCase>()),
      permanent: true,
    );
  }
}
