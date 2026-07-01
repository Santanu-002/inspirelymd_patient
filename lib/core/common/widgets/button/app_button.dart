import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';

enum AppButtonShape { capsule, sharpEdge, roundEdge }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonShape shape;
  final bool isOutlined;

  const AppButton.filled({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.shape = AppButtonShape.capsule,
  }) : isOutlined = false;

  const AppButton.outlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.shape = AppButtonShape.capsule,
  }) : isOutlined = true;

  BorderRadius _getBorderRadius() {
    switch (shape) {
      case AppButtonShape.capsule:
        return BorderRadius.circular(9999);
      case AppButtonShape.sharpEdge:
        return BorderRadius.zero;
      case AppButtonShape.roundEdge:
        return BorderRadius.circular(AppUIConstants.radius.radius$12);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = _getBorderRadius();
    final theme = context.theme;

    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  text,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
        ),
      );
    }
  }
}
