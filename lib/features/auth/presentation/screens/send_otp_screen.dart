import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/text_field/app_text_field.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/send_otp_controller.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/auth_layout.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/country_code_selector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inspirelymd_patient/core/constants/app_icons.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/social_signin_button.dart';

class SendOtpScreen extends GetView<SendOtpController> {
  const SendOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AuthLayout(
      title: AppStrings.auth.welcomeTitle,
      subtitle: AppStrings.auth.welcomeSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Phone Input & Selector ───────────────────────────────────────
          Obx(() => AppTextField(
                hintText: AppStrings.auth.phoneInputHint,
                controller: controller.phoneNumberController,
                keyboardType: TextInputType.phone,
                errorText: controller.phoneError.value,
                onChanged: (_) => controller.phoneError.value = null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                    controller.selectedCountry.value.digitCount,
                  ),
                ],
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: theme.colorScheme.textMuted,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      CountryCodeSelector(
                        selectedCountry: controller.selectedCountry.value,
                        countries: controller.countries,
                        onCountryChanged: controller.onCountryChanged,
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: theme.colorScheme.outlineVariant,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ],
                  ),
                ),
              )),
          AppUIConstants.widgets.verticalBox$24,

          // ── Send OTP Button ──────────────────────────────────────────────
          Obx(() => AppButton.filled(
                text: AppStrings.auth.sendOtpButton,
                onPressed: controller.isLoading ? null : controller.sendOtp,
                isLoading: controller.isOtpLoading.value,
              )),
          AppUIConstants.widgets.verticalBox$24,

          // ── Social Divider ───────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: theme.colorScheme.outlineVariant,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppStrings.auth.orDivider,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.textMuted,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: theme.colorScheme.outlineVariant,
                  thickness: 1,
                ),
              ),
            ],
          ),
          AppUIConstants.widgets.verticalBox$16,

          // ── Google Sign In ───────────────────────────────────────────────
          Obx(() {
            final authController = Get.find<AuthController>();
            return SocialSignInButton(
              text: AppStrings.auth.googleSignIn,
              icon: SvgPicture.asset(
                AppIcons.auth.googleLogo,
              ),
              onPressed: controller.isLoading ? null : () => authController.loginWithGoogle(),
              isLoading: authController.isGoogleLoading.value,
            );
          }),

          // ── Apple Sign In (Platform Specific) ─────────────────────────────
          if (GetPlatform.isIOS) ...[
            AppUIConstants.widgets.verticalBox$16,
            Obx(() {
              final authController = Get.find<AuthController>();
              return SocialSignInButton(
                text: AppStrings.auth.appleSignIn,
                icon: SvgPicture.asset(
                  AppIcons.auth.appleLogo,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: controller.isLoading ? null : () => authController.loginWithApple(),
                isLoading: authController.isAppleLoading.value,
              );
            }),
          ],
        ],
      ),
    );
  }
}
