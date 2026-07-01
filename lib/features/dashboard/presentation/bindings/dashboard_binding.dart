import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/services/database/database_service.dart';
import 'package:inspirelymd_patient/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/get_appointments_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/get_prescriptions_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/get_vitals_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/save_appointment_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/save_vitals_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:inspirelymd_patient/features/messages/presentation/controllers/messages_controller.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/controllers/pharmacy_controller.dart';
import 'package:inspirelymd_patient/features/account/presentation/controllers/account_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Repository
    Get.lazyPut<IDashboardRepository>(
      () => DashboardRepositoryImpl(Get.find<DatabaseService>()),
    );

    // UseCases
    Get.lazyPut<GetAppointmentsUseCase>(
      () => GetAppointmentsUseCase(Get.find<IDashboardRepository>()),
    );
    Get.lazyPut<GetPrescriptionsUseCase>(
      () => GetPrescriptionsUseCase(Get.find<IDashboardRepository>()),
    );
    Get.lazyPut<GetVitalsUseCase>(
      () => GetVitalsUseCase(Get.find<IDashboardRepository>()),
    );
    Get.lazyPut<SaveAppointmentUseCase>(
      () => SaveAppointmentUseCase(Get.find<IDashboardRepository>()),
    );
    Get.lazyPut<SaveVitalsUseCase>(
      () => SaveVitalsUseCase(Get.find<IDashboardRepository>()),
    );

    // Controllers
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        Get.find<GetAppointmentsUseCase>(),
        Get.find<GetPrescriptionsUseCase>(),
        Get.find<GetVitalsUseCase>(),
        Get.find<SaveAppointmentUseCase>(),
        Get.find<SaveVitalsUseCase>(),
      ),
    );
    Get.lazyPut<MessagesController>(() => MessagesController());
    Get.lazyPut<PharmacyController>(() => PharmacyController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
