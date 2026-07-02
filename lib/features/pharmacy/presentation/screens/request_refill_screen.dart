import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/core/constants/app_icons.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/controllers/request_refill_controller.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/widgets/refill_medication_card.dart';

class RequestRefillScreen extends GetView<RequestRefillController> {
  const RequestRefillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppScaffold(
      useScrollView: true,
      onBackPressed: controller.navigateBack,
      leadingWidth: 40.0,
      title: Text(
        AppStrings.pharmacy.requestRefillTitle,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppUIConstants.spacing.space$24,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppUIConstants.spacing.space$16,
            children: [
              // Medication Card
              const RefillMedicationCard(),
              // Refill notice description
              Text(
                AppStrings.pharmacy.refillNotice,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.textMuted,
                ),
              ),
            ],
          ),

          // Confirm refill request button
          Obx(
            () => AppButton.filled(
              text: AppStrings.pharmacy.confirmRefillRequest,
              onPressed: controller.confirmRefill,
              isLoading: controller.isLoading.value,
              icon: Icon(
                AppIcons.common.sync,
                color: theme.colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
