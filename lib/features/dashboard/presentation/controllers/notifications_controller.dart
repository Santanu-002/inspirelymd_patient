import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';

class NotificationsController extends GetxController {
  final notificationsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
  }

  void _loadNotifications() {
    notificationsList.assignAll([
      {
        'title': 'Time for your dose',
        'subtitle': 'Take your 0.5mg Semaglutide today',
        'time': '2h ago',
        'icon': 'medication',
        'group': 'Today',
      },
      {
        'title': 'Your order shipped',
        'subtitle': 'FedEx · arrives Jun 12',
        'time': '10:30 AM',
        'icon': 'shipping',
        'group': 'Today',
      },
      {
        'title': 'Dr. Reyes replied',
        'subtitle': 'Eat smaller meals and stay hydrated...',
        'time': '3:45 PM',
        'icon': 'reply',
        'group': 'Yesterday',
      },
      {
        'title': 'Refill request approved',
        'subtitle': 'Your Semaglutide refill request was approved',
        'time': '9:15 AM',
        'icon': 'medication',
        'group': 'Yesterday',
      },
      {
        'title': 'New lesson unlocked',
        'subtitle': 'Week 4: Building lasting habits',
        'time': 'Jun 8',
        'icon': 'lesson',
        'group': 'Earlier this week',
      },
      {
        'title': 'Weight check-in reminder',
        'subtitle': 'Please log your weight for this week',
        'time': 'Jun 6',
        'icon': 'lesson',
        'group': 'Earlier this week',
      },
      {
        'title': 'Appointment confirmed',
        'subtitle': 'Dr. Reyes · Jun 10 · 2:00 PM',
        'time': 'Jun 5',
        'icon': 'reply',
        'group': 'Earlier this week',
      },
      {
        'title': 'Payment successful',
        'subtitle': '\$299 charged for Semaglutide program',
        'time': 'Jun 2',
        'icon': 'shipping',
        'group': 'Earlier this week',
      },
    ]);
  }

  Map<String, List<Map<String, dynamic>>> get groupedNotifications {
    final Map<String, List<Map<String, dynamic>>> groups = {};
    for (var item in notificationsList) {
      final group = item['group'] as String? ?? 'Earlier';
      if (!groups.containsKey(group)) {
        groups[group] = [];
      }
      groups[group]!.add(item);
    }
    return groups;
  }

  void triggerBack() {
    Get.back();
  }

  void openNotificationAction(String title) {
    AppSnackbar.success('Opened alert action for: $title');
  }
}
