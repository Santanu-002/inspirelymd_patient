import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardHeader extends GetView<DashboardController> {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.dashboard.welcomeBack,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppUIConstants.widgets.verticalBox$4,
                Obx(
                  () => Text(
                    controller.userName.value,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                AppUIConstants.widgets.verticalBox$8,
                Text(
                  AppStrings.dashboard.localDbStatus,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.health_and_safety_rounded,
                color: theme.colorScheme.onPrimary,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
