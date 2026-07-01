import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.onBackPressed,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppScaffold(
      automaticallyImplyLeading: showBackButton,
      onBackPressed: onBackPressed,
      useScrollView: true,
      padding: EdgeInsets.symmetric(
        horizontal: AppUIConstants.spacing.containerPadding,
        vertical: AppUIConstants.spacing.space$24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppUIConstants.widgets.maxContentWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header Logo Section ──────────────────────────────────
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.06,
                        ),
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.health_and_safety,
                    size: 40,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              AppUIConstants.widgets.verticalBox$24,

              // ── Title & Subtitle ─────────────────────────────────────
              Center(
                child: SizedBox(
                  width: context.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      AppUIConstants.widgets.verticalBox$8,
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppUIConstants.widgets.verticalBox$32,

              // ── Screen Specific Content ──────────────────────────────
              child,
            ],
          ),
        ),
      ),
    );
  }
}
