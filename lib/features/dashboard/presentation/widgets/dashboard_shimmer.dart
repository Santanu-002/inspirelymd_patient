import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/core/common/widgets/skeleton/app_shimmer.dart';
import 'package:inspirelymd_patient/core/common/widgets/skeleton/app_skeleton_container.dart';
import 'package:inspirelymd_patient/core/common/widgets/skeleton/app_skeleton_text.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header shimmer
          const AppSkeletonContainer(height: 120),
          AppUIConstants.widgets.verticalBox$24,

          // Quick actions header
          const AppSkeletonText(width: 120, height: 20),
          AppUIConstants.widgets.verticalBox$12,

          // Quick actions row
          Row(
            spacing: AppUIConstants.spacing.space$12,
            children: const [
              Expanded(child: AppSkeletonContainer(height: 80)),
              Expanded(child: AppSkeletonContainer(height: 80)),
            ],
          ),
          AppUIConstants.widgets.verticalBox$24,

          // Vitals section
          const AppSkeletonText(width: 150, height: 20),
          AppUIConstants.widgets.verticalBox$12,
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppUIConstants.spacing.space$12,
            crossAxisSpacing: AppUIConstants.spacing.space$12,
            childAspectRatio: 1.4,
            children: const [
              AppSkeletonContainer(),
              AppSkeletonContainer(),
              AppSkeletonContainer(),
              AppSkeletonContainer(),
            ],
          ),
          AppUIConstants.widgets.verticalBox$24,

          // Appointment section
          const AppSkeletonText(width: 180, height: 20),
          AppUIConstants.widgets.verticalBox$12,
          const AppSkeletonContainer(height: 100),
        ],
      ),
    );
  }
}
