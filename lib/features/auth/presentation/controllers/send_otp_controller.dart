import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';
import 'package:inspirelymd_patient/core/common/usecase/get_countries_usecase.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/utils/app_utils.dart';
import 'package:inspirelymd_patient/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/verify_otp_controller.dart';

class SendOtpController extends GetxController {
  final GetCountriesUseCase _getCountriesUseCase;
  final SendOtpUseCase _sendOtpUseCase;

  SendOtpController(this._getCountriesUseCase, this._sendOtpUseCase);

  final phoneNumberController = TextEditingController();

  final selectedCountry = Rx<Country>(
    const Country(
      countryName: 'United States',
      countryCode: '+1',
      flag: '🇺🇸',
      isoCode: 'US',
      digitCount: 10,
      timezone: 'America/New_York',
    ),
  );
  final countries = <Country>[].obs;

  final isOtpLoading = false.obs;
  final isLoadingCountries = false.obs;
  final phoneError = RxnString();

  // Resend Timer properties
  final resendCount = 0.obs;
  final resendCountdown = 0.obs;
  Timer? _resendTimer;

  // Computed loading that includes AuthController's loading states so social login disables input as well
  final _isAuthLoading = false.obs;

  bool get isLoading => isOtpLoading.value || _isAuthLoading.value;

  @override
  void onInit() {
    super.onInit();
    _loadCountriesFromDb();

    // Bind to AuthController's loading to block clicks during social sign-in
    final authController = Get.find<AuthController>();
    _isAuthLoading.value = authController.isLoading.value;
    ever(authController.isLoading, (val) => _isAuthLoading.value = val);
  }

  Future<void> _loadCountriesFromDb() async {
    isLoadingCountries.value = true;
    final result = await _getCountriesUseCase(const GetCountriesParams());
    result.fold((failure) {}, (fetchedCountries) {
      if (fetchedCountries.isNotEmpty) {
        countries.assignAll(fetchedCountries);
        _autoSelectCountry();
      }
    });
    isLoadingCountries.value = false;
  }

  void _autoSelectCountry() {
    final locale = Get.deviceLocale;
    if (countries.isEmpty) return;

    Country? matchedCountry;

    final tzName = DateTime.now().timeZoneName.toUpperCase();
    final isoCodeMatch = AppUtils.getIsoCodeFromTimezone(tzName);

    if (isoCodeMatch != null) {
      for (final country in countries) {
        if (country.isoCode == isoCodeMatch) {
          matchedCountry = country;
          break;
        }
      }
    }

    if (matchedCountry == null &&
        locale != null &&
        locale.countryCode != null) {
      final countryCodeStr = locale.countryCode!.toUpperCase();
      for (final country in countries) {
        if (country.isoCode == countryCodeStr) {
          matchedCountry = country;
          break;
        }
      }
    }

    if (matchedCountry != null) {
      selectedCountry.value = matchedCountry;
    }
  }

  void onCountryChanged(Country country) {
    selectedCountry.value = country;
    phoneNumberController.clear();
    phoneError.value = null;
  }

  void navigateToVerifyOtp() => Get.toNamed(AppRoutes.verifyOtp);

  void startResendTimer() {
    if (resendCount.value >= 4) return;

    final seconds = (resendCount.value + 1) * 30;
    resendCountdown.value = seconds;
    resendCount.value++;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> sendOtp({bool isResend = false}) async {
    final phone = phoneNumberController.text.trim();
    final expectedLength = selectedCountry.value.digitCount;

    if (phone.isEmpty) {
      phoneError.value = 'Please enter a mobile number.';
      return;
    }

    if (phone.length != expectedLength) {
      phoneError.value =
          'Mobile number must be exactly $expectedLength digits.';
      return;
    }

    phoneError.value = null;
    isOtpLoading.value = true;

    final result = await _sendOtpUseCase(
      SendOtpParams(
        countryCode: selectedCountry.value.countryCode,
        phoneNumber: phone,
      ),
    );

    result.fold(
      (failure) {
        phoneError.value = failure.message;
        AppSnackbar.destructive(failure.message);
      },
      (mockOtp) {
        AppSnackbar.success('OTP sent successfully!');

        // Find VerifyOtpController and sync the phone number to it
        if (Get.isRegistered<VerifyOtpController>()) {
          Get.find<VerifyOtpController>().setPhoneNumber(phone);
        }

        if (!isResend) {
          resendCount.value = 0;
        }
        startResendTimer();

        if (!isResend) {
          navigateToVerifyOtp();
        }
      },
    );
    isOtpLoading.value = false;
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    phoneNumberController.dispose();
    super.onClose();
  }
}
