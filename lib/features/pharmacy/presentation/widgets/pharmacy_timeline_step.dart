import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class PharmacyTimelineStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isPassed;
  final bool isCurrent;
  final bool isFirst;
  final bool isLast;
  final IconData? currentIcon;
  final Color? currentColor;

  const PharmacyTimelineStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isPassed,
    required this.isCurrent,
    required this.isFirst,
    required this.isLast,
    this.currentIcon,
    this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppUIConstants.spacing.space$16,
        children: [
          // Left timeline graphic
          Column(
            children: [
              // Top line
              Container(
                width: 2,
                height: 12,
                color: isFirst
                    ? Colors.transparent
                    : (isPassed || isCurrent
                          ? theme.colorScheme.completed
                          : theme.colorScheme.outlineVariant),
              ),
              // Circle/Icon
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPassed
                      ? theme.colorScheme.completed
                      : (isCurrent
                            ? (currentColor ?? theme.colorScheme.primary)
                            : Colors.transparent),
                  border: isPassed || isCurrent
                      ? null
                      : Border.all(
                          color: theme.colorScheme.outlineVariant,
                          width: 2,
                        ),
                ),
                child: Center(
                  child: isPassed
                      ? Icon(Icons.check, color: theme.colorScheme.onPrimary, size: 14)
                      : (isCurrent && currentIcon != null
                            ? Icon(currentIcon, color: theme.colorScheme.onPrimary, size: 14)
                            : null),
                ),
              ),
              // Bottom line
              Expanded(
                child: Container(
                  width: 2,
                  color: isLast
                      ? Colors.transparent
                      : (isPassed
                            ? theme.colorScheme.completed
                            : theme.colorScheme.outlineVariant),
                ),
              ),
            ],
          ),
          // Right text contents
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: AppUIConstants.spacing.space$12,
                bottom: AppUIConstants.spacing.space$16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: AppUIConstants.spacing.space$2,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isPassed || isCurrent
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.textMuted,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
