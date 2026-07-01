import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inspirelymd_patient/core/theme/app_colors.dart';

class AppTextStyles {
  static const LightTextStyles light = LightTextStyles();
  static const DarkTextStyles dark = DarkTextStyles();
}

class LightTextStyles {
  const LightTextStyles();

  /// headline-lg — 30/38, Bold, tight tracking
  TextStyle get displayLarge => GoogleFonts.hankenGrotesk(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 38 / 30,
    letterSpacing: -0.6, // -0.02em × 30
    color: AppColors.light.textDefault,
  );

  /// headline-lg-mobile — 24/32, Bold
  TextStyle get headlineLarge => GoogleFonts.hankenGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
    letterSpacing: -0.24, // -0.01em × 24
    color: AppColors.light.textDefault,
  );

  /// headline-md — 20/28, SemiBold
  TextStyle get titleLarge => GoogleFonts.hankenGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    color: AppColors.light.textDefault,
  );

  /// body-lg — 18/26, Regular
  TextStyle get bodyLarge => GoogleFonts.hankenGrotesk(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 26 / 18,
    color: AppColors.light.textDefault,
  );

  /// body-md — 16/24, Regular
  TextStyle get bodyMedium => GoogleFonts.hankenGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: AppColors.light.textDefault,
  );

  /// label-md — 14/20, SemiBold, slight positive tracking
  TextStyle get labelLarge => GoogleFonts.hankenGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    letterSpacing: 0.14, // 0.01em × 14
    color: AppColors.light.textDefault,
  );

  /// label-sm — 12/16, Medium
  TextStyle get labelSmall => GoogleFonts.hankenGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    color: AppColors.light.textSubtle,
  );
}

class DarkTextStyles {
  const DarkTextStyles();

  /// headline-lg — 30/38, Bold, tight tracking
  TextStyle get displayLarge => GoogleFonts.hankenGrotesk(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 38 / 30,
    letterSpacing: -0.6,
    color: AppColors.dark.textDefault,
  );

  /// headline-lg-mobile — 24/32, Bold
  TextStyle get headlineLarge => GoogleFonts.hankenGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
    letterSpacing: -0.24,
    color: AppColors.dark.textDefault,
  );

  /// headline-md — 20/28, SemiBold
  TextStyle get titleLarge => GoogleFonts.hankenGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    color: AppColors.dark.textDefault,
  );

  /// body-lg — 18/26, Regular
  TextStyle get bodyLarge => GoogleFonts.hankenGrotesk(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 26 / 18,
    color: AppColors.dark.textDefault,
  );

  /// body-md — 16/24, Regular
  TextStyle get bodyMedium => GoogleFonts.hankenGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: AppColors.dark.textDefault,
  );

  /// label-md — 14/20, SemiBold
  TextStyle get labelLarge => GoogleFonts.hankenGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    letterSpacing: 0.14,
    color: AppColors.dark.textDefault,
  );

  /// label-sm — 12/16, Medium
  TextStyle get labelSmall => GoogleFonts.hankenGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    color: AppColors.dark.textSubtle,
  );
}
