import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

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
          _VitalCard(
            label: AppStrings.dashboard.heartRate,
            value: heartRate,
            icon: Icons.favorite_rounded,
            color: const Color(0xFFBA1A1A),
          ),
          _VitalCard(
            label: AppStrings.dashboard.bloodPressure,
            value: bp,
            icon: Icons.monitor_heart_rounded,
            color: const Color(0xFF005272),
          ),
          _VitalCard(
            label: AppStrings.dashboard.bodyTemp,
            value: temp,
            icon: Icons.thermostat_rounded,
            color: const Color(0xFFFEA619),
          ),
          _VitalCard(
            label: AppStrings.dashboard.weight,
            value: weight,
            icon: Icons.scale_rounded,
            color: const Color(0xFF007D55),
          ),
        ],
      );
    });
  }
}

class _VitalCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _VitalCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.end,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
