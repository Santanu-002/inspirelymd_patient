import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_icon_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/common/widgets/tag/app_tag.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardContent extends GetView<DashboardController> {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.dashboard;

    return AppScaffold(
      useScrollView: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            strings.welcomeBack,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.textMuted,
              height: 1.2,
            ),
          ),
          AppUIConstants.widgets.verticalBox$4,
          Obx(
            () => Text(
              controller.userName.value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
      centerTitle: false,
      titleSpacing: AppUIConstants.spacing.space$16,
      automaticallyImplyLeading: false,
      actions: [
        AppIconButton.ghost(
          icon: Icons.notifications_none_rounded,
          iconColor: theme.colorScheme.onSurface,
          iconSize: 24,
          onPressed: () => Get.toNamed(AppRoutes.notifications),
        ),
        AppUIConstants.widgets.horizontalBox$8,
      ],
      child: Obx(() {
        if (controller.isLoading.value) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Card 1: Main Weight Goal Progress ────────────────────────────
            GestureDetector(
              onTap: () => controller.changeNavIndex(1),
              child: AppCard(
                child: Row(
                  spacing: AppUIConstants.spacing.space$16,
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
                    // Text Block
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppUIConstants.spacing.space$4,
                        children: [
                          AppTag(
                            text: 'Week 4 of 24',
                            backgroundColor: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            textColor: theme.colorScheme.primary,
                          ),
                          Text(
                            '14 lb lost',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '18 lb to your goal of 180',
                            style: theme.textTheme.bodySmall?.copyWith(
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
            AppUIConstants.widgets.verticalBox$16,

            // ── Card 2: Active Treatment ─────────────────────────────────────
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Header: Label & Status Tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active treatment',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.textMuted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppTag(
                        text: 'Active',
                        backgroundColor: theme.colorScheme.completed
                            .withValues(alpha: 0.1),
                        textColor: theme.colorScheme.completed,
                        dotColor: theme.colorScheme.completed,
                      ),
                    ],
                  ),
                  AppUIConstants.widgets.verticalBox$16,
                  // Treatment detail: Icon, Title, Description
                  Row(
                    spacing: AppUIConstants.spacing.space$16,
                    children: [
                      AppIconBox(
                        icon: Icons.view_stream_rounded,
                        backgroundColor: theme.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        iconColor: theme.colorScheme.primary,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppUIConstants.spacing.space$2,
                          children: [
                            Text(
                              'Semaglutide',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                  AppUIConstants.widgets.verticalBox$16,
                  // Dose log button
                  AppButton.filled(
                    text: '✓    Log this week\'s dose',
                    onPressed: () => controller.changeNavIndex(3),
                  ),
                ],
              ),
            ),
            AppUIConstants.widgets.verticalBox$16,

            // ── Card 3: Refill Status ────────────────────────────────────────
            GestureDetector(
              onTap: () => controller.changeNavIndex(3),
              child: AppCard(
                child: Row(
                  spacing: AppUIConstants.spacing.space$16,
                  children: [
                    AppIconBox(
                      icon: Icons.local_shipping_outlined,
                      backgroundColor: theme.colorScheme.inProgress.withValues(alpha: 0.1),
                      iconColor: theme.colorScheme.inProgress,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppUIConstants.spacing.space$2,
                        children: [
                          Text(
                            'Refill on the way',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Shipped · arrives Thu, Jun 12',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Track chip
                    GestureDetector(
                      onTap: () => controller.changeNavIndex(3),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.inProgress.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'Track',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.inProgress,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppUIConstants.widgets.verticalBox$16,

            // ── Card 4: Unread Message Banner ────────────────────────────────
            GestureDetector(
              onTap: () => controller.changeNavIndex(2),
              child: AppCard(
                child: Row(
                  spacing: AppUIConstants.spacing.space$16,
                  children: [
                    // Doctor avatar with badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'AR',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.completed,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppUIConstants.spacing.space$2,
                        children: [
                          Text(
                            'Dr. Reyes',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      spacing: AppUIConstants.spacing.space$6,
                      children: [
                        Text(
                          '9:40 AM',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.textMuted,
                          ),
                        ),
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
            ),
            AppUIConstants.widgets.verticalBox$16,

            // ── Double Grid Row: Actions ─────────────────────────────────────
            Row(
              spacing: AppUIConstants.spacing.space$16,
              children: [
                Expanded(
                  child: AppCard(
                    padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
                    onTap: () {
                      AppSnackbar.success(
                        'Refill request submitted successfully.',
                      );
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
                Expanded(
                  child: AppCard(
                    padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
                    onTap: controller.showBookAppointmentSheet,
                    child: SizedBox(
                      height: 66,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: theme.colorScheme.primary,
                            size: 22,
                          ),
                          Text(
                            'Book visit',
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
      }),
    );
  }
}
