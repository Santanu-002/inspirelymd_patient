import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/core/theme/app_colors.dart';

extension ColorSchemeExtension on ColorScheme {
  // ── Semantic status colors ──────────────────────────────────────────
  Color get pending => brightness == Brightness.light
      ? AppColors.light.pending
      : AppColors.dark.pending;

  Color get inProgress => brightness == Brightness.light
      ? AppColors.light.inProgress
      : AppColors.dark.inProgress;

  Color get completed => brightness == Brightness.light
      ? AppColors.light.completed
      : AppColors.dark.completed;

  Color get cancelled => brightness == Brightness.light
      ? AppColors.light.cancelled
      : AppColors.dark.cancelled;

  // ── Shimmer ─────────────────────────────────────────────────────────
  Color get shimmerBase => brightness == Brightness.light
      ? AppColors.light.shimmerBase
      : AppColors.dark.shimmerBase;

  Color get shimmerHighlight => brightness == Brightness.light
      ? AppColors.light.shimmerHighlight
      : AppColors.dark.shimmerHighlight;

  // ── Extra surface / text tokens ─────────────────────────────────────
  Color get black => brightness == Brightness.light
      ? AppColors.light.black
      : AppColors.dark.black;

  Color get surfaceWhite => brightness == Brightness.light
      ? AppColors.light.surfaceWhite
      : AppColors.dark.surfaceWhite;

  Color get textMuted => brightness == Brightness.light
      ? AppColors.light.textSubtle
      : AppColors.dark.textSubtle;
}

extension BuildContextThemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
