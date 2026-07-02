import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
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
          padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppUIConstants.radius.lg),
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
        separatorBuilder: (_, _) => AppUIConstants.widgets.verticalBox$12,
        itemBuilder: (context, index) {
          final presc = controller.prescriptions[index];
          final rawDate = presc['date'] as String;
          String formattedDate = rawDate;
          try {
            final parsed = DateTime.parse(rawDate);
            formattedDate = DateFormat('MMM d, yyyy').format(parsed);
          } catch (_) {}

          return Container(
            padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppUIConstants.radius.lg),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: Row(
              spacing: AppUIConstants.spacing.space$16,
              children: [
                Container(
                  padding: EdgeInsets.all(AppUIConstants.spacing.space$8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.completed.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppUIConstants.radius.sm),
                  ),
                  child: Icon(
                    Icons.medication_rounded,
                    color: theme.colorScheme.completed,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppUIConstants.spacing.space$2,
                    children: [
                      Text(
                        presc['medicineName'] ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${presc['dosage'] ?? ""} • ${presc['frequency'] ?? ""}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                      Text(
                        '${AppStrings.dashboard.prescribedBy} ${presc['doctorName'] ?? ""} ${AppStrings.dashboard.on} $formattedDate',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.textMuted,
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
