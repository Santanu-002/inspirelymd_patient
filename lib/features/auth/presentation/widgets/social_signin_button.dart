import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';

class SocialSignInButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialSignInButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppButton.outlined(
      text: text,
      icon: SizedBox(width: 20, height: 20, child: icon),
      height: 48.0,
      shape: ButtonShape.pill,
      backgroundColor: theme.colorScheme.surface,
      textColor: theme.colorScheme.onSurface,
      borderColor: theme.colorScheme.outlineVariant,
      borderWidth: 1.0,
      padding: EdgeInsets.symmetric(
        horizontal: AppUIConstants.spacing.space$24,
      ),
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
