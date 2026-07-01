import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';

class AccountController extends GetxController {
  final userName = 'Jordan Avery'.obs;
  final userEmail = 'jordan@email.com'.obs;

  Future<void> handleSignOut() async {
    AppSnackbar.success('Signed out successfully.');
    await Get.find<AuthController>().logout();
  }

  void openSettingsSection(String sectionTitle) {
    AppSnackbar.info('Opening $sectionTitle...');
  }
}
