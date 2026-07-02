import 'package:get/get.dart';
import 'package:inspirelymd_patient/features/pharmacy/data/datasources/i_pharmacy_datasource.dart';
import 'package:inspirelymd_patient/features/pharmacy/data/datasources/pharmacy_datasource.dart';
import 'package:inspirelymd_patient/features/pharmacy/data/repositories/pharmacy_repository_impl.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/repositories/i_pharmacy_repository.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/usecases/request_refill_usecase.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/controllers/request_refill_controller.dart';

class RequestRefillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPharmacyDataSource>(() => PharmacyDataSource());
    Get.lazyPut<IPharmacyRepository>(
      () => PharmacyRepositoryImpl(Get.find<IPharmacyDataSource>()),
    );
    Get.lazyPut<RequestRefillUseCase>(
      () => RequestRefillUseCase(Get.find<IPharmacyRepository>()),
    );
    Get.lazyPut<RequestRefillController>(
      () => RequestRefillController(Get.find<RequestRefillUseCase>()),
    );
  }
}
