import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/vital_card.dart';

class VitalsGrid extends GetView<DashboardController> {
  const VitalsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Obx(() {
      if (controller.vitals.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Center(
            child: Text(
              AppStrings.dashboard.noVitals,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.textMuted,
              ),
            ),
          ),
        );
      }

      final latest = controller.vitals.first;
      final heartRate = '${latest['heartRate'] ?? "--"} bpm';
      final bp = '${latest['bloodPressure'] ?? "--"} mmHg';
      final temp = '${latest['temperature'] ?? "--"} °F';
      final weight = '${latest['weight'] ?? "--"} lbs';

      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.4,
        children: [
          VitalCard(
            label: AppStrings.dashboard.heartRate,
            value: heartRate,
            icon: Icons.favorite_rounded,
            color: theme.colorScheme.error,
          ),
          VitalCard(
            label: AppStrings.dashboard.bloodPressure,
            value: bp,
            icon: Icons.monitor_heart_rounded,
            color: theme.colorScheme.inProgress,
          ),
          VitalCard(
            label: AppStrings.dashboard.bodyTemp,
            value: temp,
            icon: Icons.thermostat_rounded,
            color: theme.colorScheme.pending,
          ),
          VitalCard(
            label: AppStrings.dashboard.weight,
            value: weight,
            icon: Icons.scale_rounded,
            color: theme.colorScheme.completed,
          ),
        ],
      );
    });
  }
}
