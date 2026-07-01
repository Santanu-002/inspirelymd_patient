import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/send_otp_controller.dart';

class VerifyOtpController extends GetxController {
  final VerifyOtpUseCase _verifyOtpUseCase;

  VerifyOtpController(this._verifyOtpUseCase);

  final otpController = TextEditingController();
  final phoneNumber = ''.obs;

  final isVerifyLoading = false.obs;
  final otpError = RxnString();

  bool get isLoading => isVerifyLoading.value;

  void setPhoneNumber(String number) {
    phoneNumber.value = number;
  }

  void navigateBack() => Get.back();
  void navigateToDashboard() => Get.offAllNamed(AppRoutes.dashboard);

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.length < 6) {
      otpError.value = 'Please enter a valid 6-digit OTP.';
      return;
    }

    otpError.value = null;
    isVerifyLoading.value = true;

    // Find country code from SendOtpController if possible
    String countryCode = '+1';
    if (Get.isRegistered<SendOtpController>()) {
      countryCode = Get.find<SendOtpController>().selectedCountry.value.countryCode;
    }

    final result = await _verifyOtpUseCase(
      VerifyOtpParams(
        countryCode: countryCode,
        phoneNumber: phoneNumber.value,
        otp: otp,
      ),
    );

    result.fold(
      (failure) {
        otpError.value = failure.message;
        AppSnackbar.destructive(failure.message);
      },
      (data) {
        final prefs = Get.find<SharedPreferences>();
        prefs.setBool('isLoggedIn', true);
        AppSnackbar.success('Authenticated successfully!');
        navigateToDashboard();
      },
    );
    isVerifyLoading.value = false;
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
