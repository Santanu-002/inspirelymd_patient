import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUIConstants {
  const AppUIConstants._();

  static const radius = _AppRadius();
  static const spacing = _AppSpacing();
  static const widgets = _AppWidgets();
  static const shadows = _AppShadows();
}

class _AppRadius {
  const _AppRadius();

  // ── Numeric getters (backward compat) ───────────────────────────────
  double get radius$4 => 4.0;
  double get radius$8 => 8.0;
  double get radius$12 => 12.0;
  double get radius$16 => 16.0;
  double get radius$24 => 24.0;
  double get radius$32 => 32.0;
  double get radius$48 => 48.0;

  // ── Named design-token aliases ──────────────────────────────────────
  /// rounded-sm  (0.25rem)
  double get sm => 4.0;

  /// rounded-DEFAULT (0.5rem) — cards, inputs, chips
  double get base => 8.0;

  /// rounded-md  (0.75rem)
  double get md => 12.0;

  /// rounded-lg  (1rem)
  double get lg => 16.0;

  /// rounded-xl  (1.5rem) — bottom sheets, modals top corners
  double get xl => 24.0;

  /// rounded-full (9999px) — capsule buttons, pills
  double get full => 9999.0;
}

class _AppSpacing {
  const _AppSpacing();

  // ── Numeric getters (backward compat) ───────────────────────────────
  double get space$2 => 2.0;
  double get space$4 => 4.0;
  double get space$6 => 6.0;
  double get space$8 => 8.0;
  double get space$12 => 12.0;
  double get space$16 => 16.0;
  double get space$20 => 20.0;
  double get space$24 => 24.0;
  double get space$32 => 32.0;

  // ── Named design-token aliases ──────────────────────────────────────
  /// 8px base unit
  double get unit => 8.0;

  /// Container padding (20px)
  double get containerPadding => 20.0;

  /// Gutter between columns (16px)
  double get gutter => 16.0;

  /// Vertical stack — small (8px)
  double get stackSm => 8.0;

  /// Vertical stack — medium (16px)
  double get stackMd => 16.0;

  /// Vertical stack — large (24px)
  double get stackLg => 24.0;

  /// Minimum hit-target size for interactive elements (44px)
  double get minHitTarget => 44.0;
}

class _AppWidgets {
  const _AppWidgets();

  SizedBox get verticalBox$4 => const SizedBox(height: 4.0);
  SizedBox get verticalBox$8 => const SizedBox(height: 8.0);
  SizedBox get verticalBox$12 => const SizedBox(height: 12.0);
  SizedBox get verticalBox$16 => const SizedBox(height: 16.0);
  SizedBox get verticalBox$24 => const SizedBox(height: 24.0);
  SizedBox get verticalBox$32 => const SizedBox(height: 32.0);

  SizedBox get horizontalBox$4 => const SizedBox(width: 4.0);
  SizedBox get horizontalBox$8 => const SizedBox(width: 8.0);
  SizedBox get horizontalBox$12 => const SizedBox(width: 12.0);
  SizedBox get horizontalBox$16 => const SizedBox(width: 16.0);
  SizedBox get horizontalBox$24 => const SizedBox(width: 24.0);

  /// Maximum content width for readability (600px per spec)
  double get maxContentWidth => 600.0;
}

class _AppShadows {
  const _AppShadows();

  /// Soft floating shadow — use only for FABs and Modals per design spec.
  /// 10% opacity, no color tinting, highly diffused.
  List<BoxShadow> get normal => [
    BoxShadow(
      color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.1),
      blurRadius: 10,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
  ];
}
