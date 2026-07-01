import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/tag/app_tag.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_pill_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';

class DashboardContent extends GetView<DashboardController> {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Card 1: Weight Loss Progress ─────────────────────────────────
        AppCard(
          child: Row(
            children: [
              // Circular Progress Ring
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: 0.65,
                  strokeWidth: 6,
                ),
              ),
              const SizedBox(width: 16),
              // Text Block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTag(
                      text: 'Week 4 of 24',
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                      textColor: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '14 lb lost',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '18 lb to your goal of 180',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              // Trailing chevron
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.textMuted,
              ),
            ],
          ),
        ),
        AppUIConstants.widgets.verticalBox$16,

        // ── Card 2: Active Treatment ─────────────────────────────────────
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header tag & next dose
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppTag(
                    text: 'Active treatment',
                    backgroundColor: Color(0xFFE8F5E9),
                    textColor: Color(0xFF2E7D32),
                    dotColor: Color(0xFF2E7D32),
                  ),
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.textMuted,
                      ),
                      children: const [
                        TextSpan(text: 'Next dose · '),
                        TextSpan(
                          text: 'Sunday',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Treatment detail: Icon, Title, Description
              Row(
                children: [
                  AppIconBox(
                    icon: Icons.view_stream_rounded,
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                    iconColor: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semaglutide',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '0.5 mg / week · weekly injection',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Dose log button
              AppButton.filled(
                text: '✓ Log this week\'s dose',
                onPressed: () {
                  AppSnackbar.success('Logged this week\'s dose successfully.');
                },
              ),
            ],
          ),
        ),
        AppUIConstants.widgets.verticalBox$16,

        // ── Card 3: Refill Status ────────────────────────────────────────
        AppCard(
          child: Row(
            children: [
              const AppIconBox(
                icon: Icons.local_shipping_outlined,
                backgroundColor: Color(0xFFE3F2FD),
                iconColor: Color(0xFF1E88E5),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Refill on the way',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Shipped · arrives Thu, Jun 12',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              // Track button
              AppPillButton(
                text: 'Track',
                backgroundColor: const Color(0xFFE3F2FD),
                textColor: const Color(0xFF1E88E5),
                onTap: () {
                  AppSnackbar.info('Tracking refill order status...');
                },
              ),
            ],
          ),
        ),
        AppUIConstants.widgets.verticalBox$16,

        // ── Card 4: Doctor Message ───────────────────────────────────────
        AppCard(
          child: Row(
            children: [
              // Initial circle avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'AR',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Reyes',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Eat smaller meals and stay hydrated...',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.textMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Timestamp and unread status dot
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '9:40 AM',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.textMuted,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppUIConstants.widgets.verticalBox$16,

        // ── Double Grid Row: Actions ─────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: AppCard(
                padding: const EdgeInsets.all(16),
                onTap: () {
                  AppSnackbar.success('Refill request submitted successfully.');
                },
                child: SizedBox(
                  height: 66,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.sync_rounded,
                        color: theme.colorScheme.primary,
                        size: 24,
                      ),
                      Text(
                        'Request refill',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppCard(
                padding: const EdgeInsets.all(16),
                onTap: controller.showBookAppointmentSheet,
                child: SizedBox(
                  height: 66,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: theme.colorScheme.primary,
                        size: 24,
                      ),
                      Text(
                        'Book check-in',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        AppUIConstants.widgets.verticalBox$32,
      ],
    );
  }
}
