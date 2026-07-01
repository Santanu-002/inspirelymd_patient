import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/otp_input/app_otp_input.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/auth_layout.dart';

class VerifyOtpScreen extends GetView<AuthController> {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Obx(() => AuthLayout(
          title: 'Verify Mobile',
          subtitle: 'Enter the 6-digit code sent to ${controller.selectedCountry.value.countryCode} ${controller.phoneNumberController.text}',
          showBackButton: true,
          onBackPressed: Get.back,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── OTP Input ──────────────────────────────────────────────────
              Center(
                child: AppOtpInput(
                  controller: controller.otpController,
                  errorText: controller.otpError.value,
                  onChanged: (_) => controller.otpError.value = null,
                  onCompleted: (_) => controller.verifyOtp(),
                ),
              ),
              AppUIConstants.widgets.verticalBox$24,

              // ── Verify & Proceed Button ────────────────────────────────────
              AppButton.filled(
                text: 'Verify & Proceed',
                onPressed: controller.isLoading.value ? null : controller.verifyOtp,
                isLoading: controller.isLoading.value,
              ),
              AppUIConstants.widgets.verticalBox$24,

              // ── Resend Row ─────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.textMuted,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.isLoading.value ? null : () => controller.sendOtp(),
                    child: const Text('Resend'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
