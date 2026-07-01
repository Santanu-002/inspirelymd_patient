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
      },
      {
        'title': 'Your order shipped',
        'subtitle': 'FedEx · arrives Jun 12',
        'time': 'Yesterday',
        'icon': 'shipping',
      },
      {
        'title': 'Dr. Reyes replied',
        'subtitle': 'Eat smaller meals and stay hydrated...',
        'time': 'Yesterday',
        'icon': 'reply',
      },
      {
        'title': 'New lesson unlocked',
        'subtitle': 'Week 4: Building lasting habits',
        'time': '2 days ago',
        'icon': 'lesson',
      },
    ]);
  }

  void triggerBack() {
    Get.back();
  }

  void openNotificationAction(String title) {
    AppSnackbar.success('Opened alert action for: $title');
  }
}
