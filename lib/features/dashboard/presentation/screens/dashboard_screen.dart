import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/navigation/app_bottom_navigation_bar.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_shimmer.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_tab_body.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final navIndex = controller.currentNavIndex.value;

      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          controller.handleBackPress();
        },
        child: Scaffold(
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: navIndex,
            onTap: controller.changeNavIndex,
          ),
          body: controller.isLoading.value
              ? const DashboardShimmer()
              : DashboardTabBody(navIndex: navIndex),
        ),
      );
    });
  }
}
