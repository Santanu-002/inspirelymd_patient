import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_icon_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/common/widgets/text_field/app_text_field.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

class RecordVitalsSheet extends StatefulWidget {
  const RecordVitalsSheet({super.key});

  @override
  State<RecordVitalsSheet> createState() => _RecordVitalsSheetState();
}

class _RecordVitalsSheetState extends State<RecordVitalsSheet> {
  final hrController = TextEditingController();
  final bpController = TextEditingController();
  final tempController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hrController.text = '75';
    bpController.text = '118/76';
    tempController.text = '98.4';
    weightController.text = '141.8';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = Get.find<DashboardController>();

    return Container(
      padding: EdgeInsets.all(AppUIConstants.spacing.space$24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppUIConstants.radius.xl),
          topRight: Radius.circular(AppUIConstants.radius.xl),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.dashboard.recordVitalsTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppIconButton.ghost(
                  icon: Icons.close_rounded,
                  iconColor: theme.colorScheme.onSurface,
                  onPressed: controller.navigateBack,
                ),
              ],
            ),
            AppUIConstants.widgets.verticalBox$16,
            Row(
              spacing: AppUIConstants.spacing.space$12,
              children: [
                Expanded(
                  child: AppTextField(
                    label: AppStrings.dashboard.heartRateInputLabel,
                    controller: hrController,
                    keyboardType: TextInputType.number,
                    hintText: AppStrings.dashboard.heartRateInputHint,
                  ),
                ),
                Expanded(
                  child: AppTextField(
                    label: AppStrings.dashboard.bpInputLabel,
                    controller: bpController,
                    hintText: AppStrings.dashboard.bpInputHint,
                  ),
                ),
              ],
            ),
            AppUIConstants.widgets.verticalBox$12,
            Row(
              spacing: AppUIConstants.spacing.space$12,
              children: [
                Expanded(
                  child: AppTextField(
                    label: AppStrings.dashboard.tempInputLabel,
                    controller: tempController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    hintText: AppStrings.dashboard.tempInputHint,
                  ),
                ),
                Expanded(
                  child: AppTextField(
                    label: AppStrings.dashboard.weightInputLabel,
                    controller: weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    hintText: AppStrings.dashboard.weightInputHint,
                  ),
                ),
              ],
            ),
            AppUIConstants.widgets.verticalBox$24,
            AppButton.filled(
              text: AppStrings.dashboard.saveVitalsButton,
              onPressed: () {
                final hr = int.tryParse(hrController.text.trim()) ?? 0;
                final bp = bpController.text.trim();
                final temp = double.tryParse(tempController.text.trim()) ?? 0.0;
                final weight =
                    double.tryParse(weightController.text.trim()) ?? 0.0;

                if (hr <= 0 || bp.isEmpty || temp <= 0 || weight <= 0) {
                  AppSnackbar.destructive(
                    AppStrings.dashboard.enterValidVitals,
                  );
                  return;
                }

                controller.navigateBack();
                controller.recordVitals(
                  heartRate: hr,
                  bloodPressure: bp,
                  temperature: temp,
                  weight: weight,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    hrController.dispose();
    bpController.dispose();
    tempController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
