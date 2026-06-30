import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/country_code_selector.dart';

class AuthController extends GetxController {
  final phoneNumberController = TextEditingController();
  final selectedCountry = defaultCountries[0].obs; // Default to US (+1)
  final isLoading = false.obs;

  void onCountryChanged(CountryCode country) {
    selectedCountry.value = country;
  }

  void sendOtp() {
    final phone = phoneNumberController.text.trim();
    if (phone.isEmpty || phone.length < 7) {
      AppSnackbar.destructive('Please enter a valid mobile number.');
      return;
    }

    isLoading.value = true;
    // Simulate network delay for OTP request
    Future.delayed(const Duration(milliseconds: 1500), () {
      isLoading.value = false;
      AppSnackbar.success('OTP sent successfully to ${selectedCountry.value.code} $phone');
    });
  }

  void loginWithGoogle() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 1500), () {
      isLoading.value = false;
      AppSnackbar.success('Successfully authenticated with Google.');
    });
  }

  void loginWithApple() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 1500), () {
      isLoading.value = false;
      AppSnackbar.success('Successfully authenticated with Apple.');
    });
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    super.onClose();
  }
}
