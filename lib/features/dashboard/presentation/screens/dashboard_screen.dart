import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_shimmer.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/programs_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/messages_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/pharmacy_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/account_content.dart';
import 'package:inspirelymd_patient/core/common/widgets/navigation/app_bottom_navigation_bar.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final navIndex = controller.currentNavIndex.value;

      return Scaffold(
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: navIndex,
          onTap: controller.changeNavIndex,
        ),
        body: controller.isLoading.value
            ? const DashboardShimmer()
            : _buildTabBody(navIndex),
      );
    });
  }

  Widget _buildTabBody(int navIndex) {
    return switch (navIndex) {
      0 => const DashboardContent(),
      1 => const ProgramsContent(),
      2 => const MessagesContent(),
      3 => const PharmacyContent(),
      4 => const AccountContent(),
      _ => const DashboardContent(),
    };
  }
}
