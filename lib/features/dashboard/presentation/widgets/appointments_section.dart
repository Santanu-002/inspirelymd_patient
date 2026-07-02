import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

class AppointmentsSection extends GetView<DashboardController> {
  final VoidCallback onBookNew;

  const AppointmentsSection({super.key, required this.onBookNew});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Obx(() {
      final upcoming = controller.appointments
          .where((a) => a['status'] == 'Upcoming')
          .toList();
      if (upcoming.isEmpty) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: AppUIConstants.spacing.space$24,
            horizontal: AppUIConstants.spacing.containerPadding,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppUIConstants.radius.lg),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 40,
                  color: theme.colorScheme.textMuted,
                ),
                AppUIConstants.widgets.verticalBox$12,
                Text(
                  AppStrings.dashboard.noUpcomingAppts,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.textMuted,
                  ),
                ),
                AppUIConstants.widgets.verticalBox$12,
                AppButton.ghost(
                  text: AppStrings.dashboard.bookNow,
                  width: null,
                  height: null,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppUIConstants.spacing.space$16,
                    vertical: AppUIConstants.spacing.space$8,
                  ),
                  onPressed: onBookNew,
                ),
              ],
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: upcoming.length,
        separatorBuilder: (_, _) => AppUIConstants.widgets.verticalBox$12,
        itemBuilder: (context, index) {
          final appt = upcoming[index];
          final rawDate = appt['dateTime'] as String;
          String formattedDate = rawDate;
          try {
            final parsed = DateTime.parse(rawDate);
            formattedDate = DateFormat('EEEE, MMM d • h:mm a').format(parsed);
          } catch (_) {}

          final isVideo = (appt['type'] as String).toLowerCase().contains(
            'video',
          );

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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppUIConstants.spacing.space$16,
              children: [
                Container(
                  padding: EdgeInsets.all(AppUIConstants.spacing.space$12),
                  decoration: BoxDecoration(
                    color:
                        (isVideo
                                ? theme.colorScheme.tertiary
                                : theme.colorScheme.primary)
                            .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isVideo
                        ? Icons.videocam_rounded
                        : Icons.location_on_rounded,
                    color: isVideo
                        ? theme.colorScheme.tertiary
                        : theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appt['doctorName'] ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppUIConstants.widgets.verticalBox$4,
                      Text(
                        '${appt['specialty'] ?? ""} • ${appt['type'] ?? ""}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                      AppUIConstants.widgets.verticalBox$8,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppUIConstants.spacing.space$8,
                          vertical: AppUIConstants.spacing.space$4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(
                            AppUIConstants.radius.sm,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: AppUIConstants.spacing.space$4,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: theme.colorScheme.textMuted,
                            ),
                            Text(
                              formattedDate,
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
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
