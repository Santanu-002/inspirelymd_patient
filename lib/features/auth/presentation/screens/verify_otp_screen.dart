import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/otp_input/app_otp_input.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/send_otp_controller.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/verify_otp_controller.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/auth_layout.dart';

class VerifyOtpScreen extends GetView<VerifyOtpController> {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Obx(() {
      final sendOtpController = Get.find<SendOtpController>();
      final countdown = sendOtpController.resendCountdown.value;
      final count = sendOtpController.resendCount.value;
      final countryCode = sendOtpController.selectedCountry.value.countryCode;

      final isLimitReached = count >= 4 && countdown == 0;
      final isTimerActive = countdown > 0;

      return AuthLayout(
        title: AppStrings.auth.verifyMobileTitle,
        subtitle: AppStrings.auth.verifyMobileSubtitle('$countryCode ${controller.phoneNumber.value}'),
        showBackButton: true,
        onBackPressed: controller.navigateBack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── OTP Input ──────────────────────────────────────────────────
            Center(
              child: AppOtpInput(
                controller: controller.otpController,
                autofocus: true,
                errorText: controller.otpError.value,
                onChanged: (_) => controller.otpError.value = null,
                onCompleted: (_) => controller.verifyOtp(),
              ),
            ),
            AppUIConstants.widgets.verticalBox$24,

            // ── Verify & Proceed Button ────────────────────────────────────
            AppButton.filled(
              text: AppStrings.auth.verifyAndProceed,
              onPressed: controller.isLoading ? null : controller.verifyOtp,
              isLoading: controller.isVerifyLoading.value,
            ),
            AppUIConstants.widgets.verticalBox$24,

            // ── Resend Row ─────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLimitReached)
                  Text(
                    AppStrings.auth.resendLimitReached,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else ...[
                  Text(
                    AppStrings.auth.didNotReceiveCode,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.textMuted,
                    ),
                  ),
                  TextButton(
                    onPressed: isTimerActive || controller.isLoading
                        ? null
                        : () => sendOtpController.sendOtp(isResend: true),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      isTimerActive ? AppStrings.auth.resendIn(countdown) : AppStrings.auth.resend,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      );
    });
  }
}
