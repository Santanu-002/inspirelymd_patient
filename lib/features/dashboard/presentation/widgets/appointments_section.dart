import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

class AppointmentsSection extends GetView<DashboardController> {
  final VoidCallback onBookNew;

  const AppointmentsSection({
    super.key,
    required this.onBookNew,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Obx(() {
      final upcoming = controller.appointments.where((a) => a['status'] == 'Upcoming').toList();
      if (upcoming.isEmpty) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.calendar_today_outlined, size: 40, color: theme.colorScheme.textMuted),
                const SizedBox(height: 12),
                Text(
                  AppStrings.dashboard.noUpcomingAppts,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                 TextButton(
                  onPressed: onBookNew,
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(AppStrings.dashboard.bookNow),
                )
              ],
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: upcoming.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final appt = upcoming[index];
          final rawDate = appt['dateTime'] as String;
          String formattedDate = rawDate;
          try {
            final parsed = DateTime.parse(rawDate);
            formattedDate = DateFormat('EEEE, MMM d • h:mm a').format(parsed);
          } catch (_) {}

          final isVideo = (appt['type'] as String).toLowerCase().contains('video');

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (isVideo ? theme.colorScheme.tertiary : theme.colorScheme.primary).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isVideo ? Icons.videocam_rounded : Icons.location_on_rounded,
                    color: isVideo ? theme.colorScheme.tertiary : theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appt['doctorName'] ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${appt['specialty'] ?? ""} • ${appt['type'] ?? ""}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: theme.colorScheme.textMuted,
                            ),
                            const SizedBox(width: 6),
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
