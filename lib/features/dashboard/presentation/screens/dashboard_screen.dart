import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/core/constants/app_icons.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_shimmer.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/programs_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/messages_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/pharmacy_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/account_content.dart';
import 'package:inspirelymd_patient/core/common/widgets/navigation/app_bottom_navigation_bar.dart';

import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Obx(() {
      final navIndex = controller.currentNavIndex.value;
      final showAppBar = navIndex == 0 || navIndex == 1 || navIndex == 4;

      return AppScaffold(
        useScrollView: navIndex != 2, // Disable scroll view for Messages chat tab
        titleWidget: showAppBar
            ? Column(
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
                  Text(
                    controller.userName.value,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      height: 1.2,
                    ),
                  ),
                ],
              )
            : null,
        centerTitle: false,
        titleSpacing: 16,
        automaticallyImplyLeading: false,
        actions: showAppBar
            ? [
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
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.notifications),
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
                ),
              ]
            : null,
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: navIndex,
          onTap: controller.changeNavIndex,
        ),
        floatingActionButton: navIndex == 0
            ? FloatingActionButton(
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
              )
            : null,
        child: controller.isLoading.value
            ? const DashboardShimmer()
            : _buildTabBody(navIndex, theme),
      );
    });
  }

  Widget _buildTabBody(int navIndex, ThemeData theme) {
    return switch (navIndex) {
      0 => RefreshIndicator(
          onRefresh: controller.refreshData,
          color: theme.colorScheme.primary,
          child: const DashboardContent(),
        ),
      1 => const ProgramsContent(),
      2 => const MessagesContent(),
      3 => const PharmacyContent(),
      4 => const AccountContent(),
      _ => const DashboardContent(),
    };
  }
}
