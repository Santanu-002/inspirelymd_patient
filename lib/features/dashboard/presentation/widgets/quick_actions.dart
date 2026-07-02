import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onBookAppointment;
  final VoidCallback onRecordVitals;

  const QuickActions({
    super.key,
    required this.onBookAppointment,
    required this.onRecordVitals,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      spacing: AppUIConstants.spacing.space$12,
      children: [
        Expanded(
          child: InkWell(
            onTap: onBookAppointment,
            borderRadius: BorderRadius.circular(AppUIConstants.radius.lg),
            child: Container(
              padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppUIConstants.radius.lg),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Row(
                spacing: AppUIConstants.spacing.space$12,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppUIConstants.spacing.space$8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: theme.colorScheme.primary,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.dashboard.bookAppt,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          AppStrings.dashboard.bookApptSub,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: onRecordVitals,
            borderRadius: BorderRadius.circular(AppUIConstants.radius.lg),
            child: Container(
              padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppUIConstants.radius.lg),
                border: Border.all(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Row(
                spacing: AppUIConstants.spacing.space$12,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppUIConstants.spacing.space$8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: theme.colorScheme.tertiary,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.dashboard.recordVitals,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          AppStrings.dashboard.recordVitalsSub,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
