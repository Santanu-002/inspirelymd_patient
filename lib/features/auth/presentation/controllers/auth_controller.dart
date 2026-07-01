import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/sign_out_usecase.dart';

class AuthController extends GetxController {
  final SignOutUseCase _signOutUseCase;

  AuthController(this._signOutUseCase);

  final isGoogleLoading = false.obs;
  final isAppleLoading = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Bind isLoading to update when any loader changes
    everAll([isGoogleLoading, isAppleLoading], (_) {
      isLoading.value = isGoogleLoading.value || isAppleLoading.value;
    });

    // Run the route gatekeeping logic on startup
    handleAuthGate();
  }

  Future<void> handleAuthGate() async {
    // Wait for splash transitions to render
    await Future.delayed(const Duration(milliseconds: 1500));

    final prefs = Get.find<SharedPreferences>();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.offAllNamed(AppRoutes.auth);
    }
  }

  void navigateToDashboard() => Get.offAllNamed(AppRoutes.dashboard);
  void navigateToAuth() => Get.offAllNamed(AppRoutes.auth);
  void navigateBack() => Get.back();

  void loginWithGoogle() {
    isGoogleLoading.value = true;
    Future.delayed(const Duration(milliseconds: 1500), () {
      isGoogleLoading.value = false;
      final prefs = Get.find<SharedPreferences>();
      prefs.setBool('isLoggedIn', true);
      AppSnackbar.success('Successfully authenticated with Google.');
      navigateToDashboard();
    });
  }

  void loginWithApple() {
    isAppleLoading.value = true;
    Future.delayed(const Duration(milliseconds: 1500), () {
      isAppleLoading.value = false;
      final prefs = Get.find<SharedPreferences>();
      prefs.setBool('isLoggedIn', true);
      AppSnackbar.success('Successfully authenticated with Apple.');
      navigateToDashboard();
    });
  }

  Future<void> logout() async {
    final result = await _signOutUseCase(NoParams());
    result.fold(
      (failure) => AppSnackbar.destructive('Sign out failed: ${failure.message}'),
      (_) {
        final prefs = Get.find<SharedPreferences>();
        prefs.setBool('isLoggedIn', false);
        AppSnackbar.info(AppStrings.dashboard.signOut);
        navigateToAuth();
      },
    );
  }
}
