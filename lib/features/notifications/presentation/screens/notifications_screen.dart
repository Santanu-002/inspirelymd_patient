import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/features/notifications/presentation/controllers/notifications_controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        controller.triggerBack();
      },
      child: AppScaffold(
        useScrollView: true,
        automaticallyImplyLeading: true,
        onBackPressed: controller.triggerBack,
        title: Text(
          'Notifications',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        child: Obx(() {
          final grouped = controller.groupedNotifications;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: grouped.entries.map((entry) {
              final groupTitle = entry.key;
              final groupItems = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppUIConstants.spacing.space$8,
                      bottom: AppUIConstants.spacing.space$8,
                      left: AppUIConstants.spacing.space$4,
                    ),
                    child: Text(
                      groupTitle.toUpperCase(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: List.generate(groupItems.length, (index) {
                        final item = groupItems[index];

                        IconData notifyIcon;
                        Color iconBg;
                        Color iconColor;

                        switch (item['icon']) {
                          case 'medication':
                            notifyIcon = Icons.calendar_today_outlined;
                            iconBg = theme.colorScheme.primary.withValues(
                              alpha: 0.1,
                            );
                            iconColor = theme.colorScheme.primary;
                            break;
                          case 'shipping':
                            notifyIcon = Icons.local_shipping_outlined;
                            iconBg = theme.colorScheme.inProgress.withValues(alpha: 0.1);
                            iconColor = theme.colorScheme.inProgress;
                            break;
                          case 'reply':
                            notifyIcon = Icons.chat_bubble_outline_rounded;
                            iconBg = theme.colorScheme.completed.withValues(alpha: 0.1);
                            iconColor = theme.colorScheme.completed;
                            break;
                          case 'lesson':
                          default:
                            notifyIcon = Icons.auto_awesome;
                            iconBg = theme.colorScheme.pending.withValues(alpha: 0.1);
                            iconColor = theme.colorScheme.pending;
                            break;
                        }

                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppUIConstants.spacing.space$16,
                                vertical: AppUIConstants.spacing.space$12,
                              ),
                              child: InkWell(
                                onTap: () => controller.openNotificationAction(
                                  item['title'],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: AppUIConstants.spacing.space$16,
                                  children: [
                                    AppIconBox(
                                      icon: notifyIcon,
                                      backgroundColor: iconBg,
                                      iconColor: iconColor,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: AppUIConstants.spacing.space$4,
                                        children: [
                                          Text(
                                            item['title'],
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            item['subtitle'],
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                  color: theme
                                                      .colorScheme
                                                      .textMuted,
                                                  height: 1.3,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      item['time'],
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: theme.colorScheme.textMuted,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (index < groupItems.length - 1)
                              const Divider(height: 1),
                          ],
                        );
                      }),
                    ),
                  ),
                  AppUIConstants.widgets.verticalBox$16,
                ],
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
