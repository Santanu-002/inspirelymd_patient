import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

class PrescriptionsSection extends GetView<DashboardController> {
  const PrescriptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Obx(() {
      if (controller.prescriptions.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Center(
            child: Text(
              AppStrings.dashboard.noPrescriptions,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.textMuted,
              ),
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.prescriptions.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final presc = controller.prescriptions[index];
          final rawDate = presc['date'] as String;
          String formattedDate = rawDate;
          try {
            final parsed = DateTime.parse(rawDate);
            formattedDate = DateFormat('MMM d, yyyy').format(parsed);
          } catch (_) {}

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007D55).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.medication_rounded,
                    color: Color(0xFF007D55),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        presc['medicineName'] ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${presc['dosage'] ?? ""} • ${presc['frequency'] ?? ""}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.textMuted,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${AppStrings.dashboard.prescribedBy} ${presc['doctorName'] ?? ""} ${AppStrings.dashboard.on} $formattedDate',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
