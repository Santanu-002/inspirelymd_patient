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
    return switch (shape) {
      AppButtonShape.capsule => BorderRadius.circular(9999),
      AppButtonShape.sharpEdge => BorderRadius.zero,
      AppButtonShape.roundEdge => BorderRadius.circular(
        AppUIConstants.radius.radius$12,
      ),
    };
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
          onPressed: isLoading ? () {} : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            splashFactory: isLoading ? NoSplash.splashFactory : null,
          ),
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                  ),
                )
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
          onPressed: isLoading ? () {} : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            splashFactory: isLoading ? NoSplash.splashFactory : null,
          ),
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 16,
                  ),
                ),
        ),
      );
    }
  }
}
