import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/core/common/widgets/skeleton/app_skeleton_container.dart';

class AppSkeletonAvatar extends StatelessWidget {
  final double size;

  const AppSkeletonAvatar({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonContainer(
      width: size,
      height: size,
      shape: BoxShape.circle,
    );
  }
}
