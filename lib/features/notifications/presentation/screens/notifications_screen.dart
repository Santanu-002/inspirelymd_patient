import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
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
        titleWidget: Text(
          'Notifications',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0D253F),
            fontSize: 24,
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
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
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
                            iconBg = const Color(0xFFE3F2FD);
                            iconColor = const Color(0xFF1E88E5);
                            break;
                          case 'reply':
                            notifyIcon = Icons.chat_bubble_outline_rounded;
                            iconBg = const Color(0xFFE8F5E9);
                            iconColor = const Color(0xFF2E7D32);
                            break;
                          case 'lesson':
                          default:
                            notifyIcon = Icons.auto_awesome;
                            iconBg = const Color(0xFFFFF8E1);
                            iconColor = const Color(0xFFFFB300);
                            break;
                        }

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              child: InkWell(
                                onTap: () => controller.openNotificationAction(
                                  item['title'],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppIconBox(
                                      icon: notifyIcon,
                                      backgroundColor: iconBg,
                                      iconColor: iconColor,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['title'],
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
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
                                    const SizedBox(width: 8),
                                    Text(
                                      item['time'],
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: theme.colorScheme.textMuted,
                                            fontSize: 10,
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
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
