import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/app_colors.dart';
import 'package:inspirelymd_patient/core/theme/text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      primary: AppColors.light.brandBlue,
      onPrimary: AppColors.light.onPrimary,
      primaryContainer: AppColors.light.brandAccent,
      secondary: AppColors.light.brandAccent,
      surface: AppColors.light.cardSurface,
      onSurface: AppColors.light.textDefault,
      error: AppColors.light.error,
      tertiary: AppColors.light.completed,
      outlineVariant: AppColors.light.ghostBorder.withValues(alpha: 0.15),
      onSurfaceVariant: AppColors.light.textSubtle,
    );

    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.light.brandBlue,
      scaffoldBackgroundColor: AppColors.light.background,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.light.displayLarge,
        headlineLarge: AppTextStyles.light.headlineLarge,
        titleLarge: AppTextStyles.light.titleLarge,
        bodyLarge: AppTextStyles.light.bodyLarge,
        bodyMedium: AppTextStyles.light.bodyMedium,
        labelLarge: AppTextStyles.light.labelLarge,
        labelSmall: AppTextStyles.light.labelSmall,
      ),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.light.titleLarge,
        iconTheme: IconThemeData(color: AppColors.light.textDefault),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      listTileTheme: ListTileThemeData(
        selectedTileColor: colorScheme.primary,
        selectedColor: colorScheme.onPrimary,
        iconColor: colorScheme.onSurfaceVariant,
        titleTextStyle: AppTextStyles.light.bodyLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$12),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.dark.brandBlue,
      onPrimary: AppColors.dark.onPrimary,
      primaryContainer: AppColors.dark.brandAccent,
      secondary: AppColors.dark.brandAccent,
      surface: AppColors.dark.cardSurface,
      onSurface: AppColors.dark.textDefault,
      error: AppColors.dark.error,
      tertiary: AppColors.dark.completed,
      outlineVariant: AppColors.dark.ghostBorder.withValues(alpha: 0.15),
      onSurfaceVariant: AppColors.dark.textSubtle,
    );

    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.dark.brandBlue,
      scaffoldBackgroundColor: AppColors.dark.background,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.dark.displayLarge,
        headlineLarge: AppTextStyles.dark.headlineLarge,
        titleLarge: AppTextStyles.dark.titleLarge,
        bodyLarge: AppTextStyles.dark.bodyLarge,
        bodyMedium: AppTextStyles.dark.bodyMedium,
        labelLarge: AppTextStyles.dark.labelLarge,
        labelSmall: AppTextStyles.dark.labelSmall,
      ),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.dark.titleLarge,
        iconTheme: IconThemeData(color: AppColors.dark.textDefault),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      listTileTheme: ListTileThemeData(
        selectedTileColor: colorScheme.primary,
        selectedColor: colorScheme.onPrimary,
        iconColor: colorScheme.onSurfaceVariant,
        titleTextStyle: AppTextStyles.dark.bodyLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$12),
        ),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colors) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$12),
      borderSide: BorderSide(
        color: colors.onSurfaceVariant.withValues(alpha: 0.2),
        width: 1,
      ),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppUIConstants.spacing.space$16,
        vertical: AppUIConstants.spacing.space$16,
      ),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: colors.primary, width: 1.5),
      ),
      errorBorder: border.copyWith(
        borderSide: BorderSide(color: colors.error, width: 1),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: BorderSide(color: colors.error, width: 1.5),
      ),
    );
  }
}
