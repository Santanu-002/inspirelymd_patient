import 'package:get/get.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}
