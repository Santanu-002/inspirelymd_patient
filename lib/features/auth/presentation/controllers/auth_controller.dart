import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';
import 'package:inspirelymd_patient/core/common/usecase/get_countries_usecase.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/country_code_selector.dart';

class AuthController extends GetxController {
  final GetCountriesUseCase _getCountriesUseCase;
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;

  AuthController(
    this._getCountriesUseCase,
    this._sendOtpUseCase,
    this._verifyOtpUseCase,
  );

  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController();

  final selectedCountry = defaultCountries[0].obs; // Default to US (+1)
  final countries = <Country>[].obs;

  final isLoading = false.obs;
  final isLoadingCountries = false.obs;
  final phoneError = RxnString();
  final otpError = RxnString();

  String get title => AppStrings.auth.welcomeTitle;
  String get subtitle => AppStrings.auth.welcomeSubtitle;

  @override
  void onInit() {
    super.onInit();
    countries.assignAll(defaultCountries);
    _autoSelectCountry();
    _loadRemoteCountries();
  }

  Future<void> _loadRemoteCountries() async {
    isLoadingCountries.value = true;
    final result = await _getCountriesUseCase(const GetCountriesParams());
    result.fold(
      (failure) {
        // Silent fallback to defaultCountries
      },
      (fetchedCountries) {
        if (fetchedCountries.isNotEmpty) {
          countries.assignAll(fetchedCountries);
          _autoSelectCountry(); // Re-select matching country from the remote list if possible
        }
      },
    );
    isLoadingCountries.value = false;
  }

  void _autoSelectCountry() {
    final locale = Get.deviceLocale;
    final listToUse = countries.isNotEmpty ? countries : defaultCountries;
    if (locale != null && locale.countryCode != null) {
      final countryCodeStr = locale.countryCode!.toUpperCase();
      for (final country in listToUse) {
        if (country.isoCode == countryCodeStr) {
          selectedCountry.value = country;
          break;
        }
      }
    }
  }

  void onCountryChanged(Country country) {
    selectedCountry.value = country;
    // Clear phone text & error if user changes country to avoid invalid length submissions
    phoneNumberController.clear();
    phoneError.value = null;
  }

  Future<void> sendOtp() async {
    final phone = phoneNumberController.text.trim();
    final expectedLength = selectedCountry.value.digitCount;

    if (phone.isEmpty) {
      phoneError.value = 'Please enter a mobile number.';
      return;
    }

    if (phone.length != expectedLength) {
      phoneError.value = 'Mobile number must be exactly $expectedLength digits.';
      return;
    }

    phoneError.value = null;
    isLoading.value = true;

    final result = await _sendOtpUseCase(
      SendOtpParams(
        countryCode: selectedCountry.value.countryCode,
        phoneNumber: phone,
      ),
    );

    result.fold(
      (failure) {
        phoneError.value = failure.message;
        AppSnackbar.destructive('Failed to send OTP: ${failure.message}');
      },
      (mockOtp) {
        AppSnackbar.success('OTP sent successfully! Mock Code: $mockOtp');
        otpController.clear();
        otpError.value = null;
        Get.toNamed(AppRoutes.verifyOtp);
      },
    );
    isLoading.value = false;
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.length < 6) {
      otpError.value = 'Please enter a valid 6-digit OTP.';
      return;
    }

    otpError.value = null;
    isLoading.value = true;

    final result = await _verifyOtpUseCase(
      VerifyOtpParams(
        countryCode: selectedCountry.value.countryCode,
        phoneNumber: phoneNumberController.text.trim(),
        otp: otp,
      ),
    );

    result.fold(
      (failure) {
        otpError.value = failure.message;
        AppSnackbar.destructive('Verification failed: ${failure.message}');
      },
      (data) {
        AppSnackbar.success('Authenticated successfully!');
        Get.offAllNamed(AppRoutes.dashboard);
      },
    );
    isLoading.value = false;
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
    otpController.dispose();
    super.onClose();
  }
}
