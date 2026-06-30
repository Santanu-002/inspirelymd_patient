import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class AppSkeletonContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;
  final Widget? child;

  const AppSkeletonContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.shimmerBase,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? (borderRadius ?? BorderRadius.circular(8))
            : null,
      ),
      child: child,
    );
  }
}
