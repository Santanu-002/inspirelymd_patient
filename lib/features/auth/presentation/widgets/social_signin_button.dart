import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          backgroundColor: theme.colorScheme.surface,
          elevation: 0,
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
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 24, height: 24, child: icon),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
