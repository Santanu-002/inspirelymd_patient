import 'package:flutter/material.dart';

class AppColors {
  static const LightColors light = LightColors();
  static const DarkColors dark = DarkColors();
}

class LightColors {
  const LightColors();

  // ── Surfaces ──────────────────────────────────────────────────────────
  final Color background = const Color(0xFFFBF9F7); // surface (warm bone)
  final Color tonalSurface = const Color(0xFFEFEDEC); // surface-container
  final Color cardSurface = const Color(0xFFFFFFFF); // surface-container-lowest
  final Color surfaceContainerLow = const Color(0xFFF5F3F1);
  final Color surfaceContainerHigh = const Color(0xFFEAE8E6);
  final Color surfaceContainerHighest = const Color(0xFFE4E2E0);
  final Color surfaceDim = const Color(0xFFDBDAD8);
  final Color surfaceWhite = const Color(0xFFFFFFFF);

  // ── Primary ───────────────────────────────────────────────────────────
  final Color brandPrimary = const Color(0xFF9C0514); // primary (clinical red)
  final Color brandAccent = const Color(0xFFBF2729); // primary-container
  final Color onPrimaryContainer = const Color(0xFFFFD9D5);
  final Color surfaceTint = const Color(0xFFB72124);

  // ── Inverse ───────────────────────────────────────────────────────────
  final Color inverseSurface = const Color(0xFF30302F);
  final Color inverseOnSurface = const Color(0xFFF2F0EE);
  final Color inversePrimary = const Color(0xFFFFB3AD);

  // ── Secondary ─────────────────────────────────────────────────────────
  final Color secondary = const Color(0xFF645C5E);
  final Color onSecondary = const Color(0xFFFFFFFF);
  final Color secondaryContainer = const Color(0xFFE8DDDE);
  final Color onSecondaryContainer = const Color(0xFF686162);

  // ── Tertiary ──────────────────────────────────────────────────────────
  final Color tertiary = const Color(0xFF005272);
  final Color onTertiary = const Color(0xFFFFFFFF);
  final Color tertiaryContainer = const Color(0xFF006B94);
  final Color onTertiaryContainer = const Color(0xFFC3E6FF);

  // ── Error ─────────────────────────────────────────────────────────────
  final Color error = const Color(0xFFBA1A1A);
  final Color onError = const Color(0xFFFFFFFF);
  final Color errorContainer = const Color(0xFFFFDAD6);
  final Color onErrorContainer = const Color(0xFF93000A);

  // ── Outline ───────────────────────────────────────────────────────────
  final Color outline = const Color(0xFF8F706D);
  final Color ghostBorder = const Color(0xFFE3BEBA); // outline-variant

  // ── Semantic status ───────────────────────────────────────────────────
  final Color pending = const Color(0xFFFEA619);
  final Color inProgress = const Color(0xFF005272); // reuses tertiary
  final Color completed = const Color(0xFF007D55);
  final Color cancelled = const Color(0xFFBA1A1A); // reuses error

  // ── Shimmer ───────────────────────────────────────────────────────────
  final Color shimmerBase = const Color(0xFFE4E2E0); // surface-container-highest
  final Color shimmerHighlight = const Color(0xFFF5F3F1); // surface-container-low

  // ── Text ──────────────────────────────────────────────────────────────
  final Color textDefault = const Color(0xFF1B1C1B); // on-surface
  final Color textSubtle = const Color(0xFF6B6768); // text-muted
  final Color onSurfaceVariant = const Color(0xFF5A403E);
  final Color onPrimary = const Color(0xFFFFFFFF);
  final Color black = const Color(0xFF000000);

  // ── Primary Fixed ─────────────────────────────────────────────────────
  final Color primaryFixed = const Color(0xFFFFDAD6);
  final Color primaryFixedDim = const Color(0xFFFFB3AD);
  final Color onPrimaryFixed = const Color(0xFF410003);
  final Color onPrimaryFixedVariant = const Color(0xFF930011);
}

/// Stubbed with light values. Replace once a dark-mode design is provided.
class DarkColors {
  const DarkColors();

  // ── Surfaces ──────────────────────────────────────────────────────────
  final Color background = const Color(0xFF121212);
  final Color tonalSurface = const Color(0xFF1E1E1E);
  final Color cardSurface = const Color(0xFF2C2C2C);
  final Color surfaceContainerLow = const Color(0xFF252525);
  final Color surfaceContainerHigh = const Color(0xFF353535);
  final Color surfaceContainerHighest = const Color(0xFF3F3F3F);
  final Color surfaceDim = const Color(0xFF141413);
  final Color surfaceWhite = const Color(0xFF2C2C2C);

  // ── Primary ───────────────────────────────────────────────────────────
  final Color brandPrimary = const Color(0xFFFBF9F7); // scaffold reddish-white as primary in dark mode
  final Color brandAccent = const Color(0xFFBF2729);
  final Color onPrimaryContainer = const Color(0xFFFFD9D5);
  final Color surfaceTint = const Color(0xFFFBF9F7);

  // ── Inverse ───────────────────────────────────────────────────────────
  final Color inverseSurface = const Color(0xFFE4E2E0);
  final Color inverseOnSurface = const Color(0xFF30302F);
  final Color inversePrimary = const Color(0xFF9C0514);

  // ── Secondary ─────────────────────────────────────────────────────────
  final Color secondary = const Color(0xFFCFC4C5);
  final Color onSecondary = const Color(0xFF352F30);
  final Color secondaryContainer = const Color(0xFF4C4546);
  final Color onSecondaryContainer = const Color(0xFFEBE0E1);

  // ── Tertiary ──────────────────────────────────────────────────────────
  final Color tertiary = const Color(0xFF84CFFD);
  final Color onTertiary = const Color(0xFF00344B);
  final Color tertiaryContainer = const Color(0xFF006B94);
  final Color onTertiaryContainer = const Color(0xFFC3E6FF);

  // ── Error ─────────────────────────────────────────────────────────────
  final Color error = const Color(0xFFFFB4AB);
  final Color onError = const Color(0xFF690005);
  final Color errorContainer = const Color(0xFF93000A);
  final Color onErrorContainer = const Color(0xFFFFDAD6);

  // ── Outline ───────────────────────────────────────────────────────────
  final Color outline = const Color(0xFF9F8C89);
  final Color ghostBorder = const Color(0xFF534342);

  // ── Semantic status ───────────────────────────────────────────────────
  final Color pending = const Color(0xFFFEA619);
  final Color inProgress = const Color(0xFF84CFFD);
  final Color completed = const Color(0xFF03DAC6);
  final Color cancelled = const Color(0xFFFFB4AB);

  // ── Shimmer ───────────────────────────────────────────────────────────
  final Color shimmerBase = const Color(0xFF424242);
  final Color shimmerHighlight = const Color(0xFF616161);

  // ── Text ──────────────────────────────────────────────────────────────
  final Color textDefault = const Color(0xFFE4E2E0);
  final Color textSubtle = const Color(0xB3FFFFFF);
  final Color onSurfaceVariant = const Color(0xFFD7C1BF);
  final Color onPrimary = const Color(0xFF9C0514); // brand red text color on reddish-white buttons
  final Color black = const Color(0xFF000000);

  // ── Primary Fixed ─────────────────────────────────────────────────────
  final Color primaryFixed = const Color(0xFFFFDAD6);
  final Color primaryFixedDim = const Color(0xFFFFB3AD);
  final Color onPrimaryFixed = const Color(0xFF410003);
  final Color onPrimaryFixedVariant = const Color(0xFF930011);
}
