import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/notifications_controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppScaffold(
      useScrollView: true,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: controller.triggerBack,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          child: Icon(
            Icons.chevron_left_rounded,
            color: theme.colorScheme.onSurface,
            size: 24,
          ),
        ),
      ),
      titleWidget: Text(
        'Notifications',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0D253F),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1C1B1F), // Dark circular FAB
        shape: const CircleBorder(),
        child: const Icon(
          Icons.auto_awesome,
          color: Colors.white,
          size: 24,
        ),
      ),
      child: Obx(() {
        return AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(controller.notificationsList.length, (index) {
              final item = controller.notificationsList[index];

              IconData notifyIcon;
              Color iconBg;
              Color iconColor;

              switch (item['icon']) {
                case 'medication':
                  notifyIcon = Icons.calendar_today_outlined;
                  iconBg = theme.colorScheme.primary.withValues(alpha: 0.1);
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: InkWell(
                      onTap: () => controller.openNotificationAction(item['title']),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['subtitle'],
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.textMuted,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['time'],
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.textMuted,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index < controller.notificationsList.length - 1)
                    const Divider(height: 1),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
