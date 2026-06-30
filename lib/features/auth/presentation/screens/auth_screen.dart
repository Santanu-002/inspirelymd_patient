import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/auth_layout.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/country_code_selector.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/social_signin_button.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AuthLayout(
      title: AppStrings.auth.welcomeTitle,
      subtitle: AppStrings.auth.welcomeSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Mobile Number Label ──────────────────────────────────────────
          Text(
            AppStrings.auth.phoneInputLabel,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          AppUIConstants.widgets.verticalBox$8,

          // ── Country Dropdown + Phone Input Row ────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => CountryCodeSelector(
                    selectedCountry: controller.selectedCountry.value,
                    onCountryChanged: controller.onCountryChanged,
                  )),
              AppUIConstants.widgets.horizontalBox$12,
              Expanded(
                child: TextFormField(
                  controller: controller.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: AppStrings.auth.phoneInputHint,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(
                        Icons.phone_outlined,
                        color: theme.colorScheme.textMuted,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AppUIConstants.widgets.verticalBox$24,

          // ── Send OTP Button ──────────────────────────────────────────────
          Obx(() => AppButton.filled(
                text: AppStrings.auth.sendOtpButton,
                onPressed: controller.isLoading.value ? null : controller.sendOtp,
                isLoading: controller.isLoading.value,
              )),
          AppUIConstants.widgets.verticalBox$32,

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
          AppUIConstants.widgets.verticalBox$24,

          // ── Google Sign In ───────────────────────────────────────────────
          SocialSignInButton(
            text: AppStrings.auth.googleSignIn,
            icon: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png',
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.g_mobiledata_rounded,
                  color: theme.colorScheme.primary,
                  size: 24,
                );
              },
            ),
            onPressed: () => controller.loginWithGoogle(),
          ),

          // ── Apple Sign In (Platform Specific) ─────────────────────────────
          if (GetPlatform.isIOS) ...[
            AppUIConstants.widgets.verticalBox$16,
            SocialSignInButton(
              text: AppStrings.auth.appleSignIn,
              icon: Icon(
                Icons.apple,
                color: theme.brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                size: 24,
              ),
              onPressed: () => controller.loginWithApple(),
            ),
          ],
        ],
      ),
    );
  }
}
