import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/core/common/widgets/skeleton/app_skeleton_container.dart';

class AppSkeletonButton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const AppSkeletonButton({
    super.key,
    this.width = double.infinity,
    this.height = 48,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AppSkeletonContainer(
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(9999),
    );
  }
}
