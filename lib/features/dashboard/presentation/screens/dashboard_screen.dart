import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_icons.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_shimmer.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:inspirelymd_patient/core/common/widgets/navigation/app_bottom_navigation_bar.dart';

import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppScaffold(
      useScrollView: true,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.greeting,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.textMuted,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Obx(() => Text(
                controller.userName.value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  height: 1.2,
                ),
              )),
        ],
      ),
      centerTitle: false,
      titleSpacing: 16,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () => controller.signOut(),
          icon: Icon(
            AppIcons.common.logout,
            color: theme.colorScheme.textMuted,
            size: 22,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 8),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  AppIcons.common.bellInactive,
                  color: theme.colorScheme.onSurface,
                  size: 22,
                ),
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      bottomNavigationBar: Obx(() => AppBottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            onTap: controller.changeNavIndex,
          )),
      floatingActionButton: Obx(() {
        if (controller.currentNavIndex.value == 0) {
          return FloatingActionButton(
            onPressed: () {
              AppSnackbar.info('Spark action triggered.');
            },
            shape: const CircleBorder(),
            backgroundColor: theme.colorScheme.onSurface,
            child: Icon(
              AppIcons.common.sparkle,
              color: theme.colorScheme.surface,
              size: 24,
            ),
          );
        }
        return const SizedBox.shrink();
      }),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const DashboardShimmer();
        }
        return switch (controller.currentNavIndex.value) {
          0 => RefreshIndicator(
              onRefresh: controller.refreshData,
              color: theme.colorScheme.primary,
              child: const DashboardContent(),
            ),
          1 => Center(
              child: Text(
                'Programs Screen',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          2 => Center(
              child: Text(
                'Messages Screen',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          3 => Center(
              child: Text(
                'Pharmacy Screen',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          4 => Center(
              child: Text(
                'Account Screen',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          _ => const DashboardContent(),
        };
      }),
    );
  }
}
