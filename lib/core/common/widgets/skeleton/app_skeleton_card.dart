import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/core/common/widgets/skeleton/app_skeleton_container.dart';

class AppSkeletonCard extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const AppSkeletonCard({
    super.key,
    this.width,
    this.height = 100,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AppSkeletonContainer(
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
    );
  }
}
