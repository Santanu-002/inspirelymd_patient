import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/core/common/widgets/skeleton/app_skeleton_container.dart';

class AppSkeletonText extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const AppSkeletonText({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AppSkeletonContainer(
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(4),
    );
  }
}
