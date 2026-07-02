import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/app_colors.dart';
import 'package:inspirelymd_patient/core/theme/text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    final colors = AppColors.light;

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: colors.brandPrimary,
          brightness: Brightness.light,
        ).copyWith(
          // ── Primary ─────────────────────────────────────────────────────
          primary: colors.brandPrimary,
          onPrimary: colors.onPrimary,
          primaryContainer: colors.brandAccent,
          onPrimaryContainer: colors.onPrimaryContainer,
          primaryFixed: colors.primaryFixed,
          primaryFixedDim: colors.primaryFixedDim,
          onPrimaryFixed: colors.onPrimaryFixed,
          onPrimaryFixedVariant: colors.onPrimaryFixedVariant,
          inversePrimary: colors.inversePrimary,

          // ── Secondary ───────────────────────────────────────────────────
          secondary: colors.secondary,
          onSecondary: colors.onSecondary,
          secondaryContainer: colors.secondaryContainer,
          onSecondaryContainer: colors.onSecondaryContainer,

          // ── Tertiary ────────────────────────────────────────────────────
          tertiary: colors.tertiary,
          onTertiary: colors.onTertiary,
          tertiaryContainer: colors.tertiaryContainer,
          onTertiaryContainer: colors.onTertiaryContainer,

          // ── Error ───────────────────────────────────────────────────────
          error: colors.error,
          onError: colors.onError,
          errorContainer: colors.errorContainer,
          onErrorContainer: colors.onErrorContainer,

          // ── Surface ─────────────────────────────────────────────────────
          surface: colors.cardSurface,
          onSurface: colors.textDefault,
          onSurfaceVariant: colors.textSubtle,
          surfaceContainerLowest: colors.cardSurface,
          surfaceContainerLow: colors.surfaceContainerLow,
          surfaceContainer: colors.tonalSurface,
          surfaceContainerHigh: colors.surfaceContainerHigh,
          surfaceContainerHighest: colors.surfaceContainerHighest,
          surfaceDim: colors.surfaceDim,
          surfaceBright: colors.background,
          inverseSurface: colors.inverseSurface,
          onInverseSurface: colors.inverseOnSurface,
          surfaceTint: colors.surfaceTint,

          // ── Outline ─────────────────────────────────────────────────────
          outline: colors.outline,
          outlineVariant: colors.ghostBorder,
        );

    return ThemeData(
      useMaterial3: true,
      primaryColor: colors.brandPrimary,
      scaffoldBackgroundColor: colors.background,
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
        iconTheme: IconThemeData(color: colors.textDefault),
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
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: AppUIConstants.spacing.space$16,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: AppTextStyles.light.bodyMedium.copyWith(
          color: colorScheme.onInverseSurface,
        ),
      ),

      // ── Buttons — Capsule (rounded-full) by default ─────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppTextStyles.light.labelLarge.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppTextStyles.light.labelLarge.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppTextStyles.light.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppTextStyles.light.labelLarge.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ),

      // ── Card ────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: colors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Chip ────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceContainerHighest,
        labelStyle: AppTextStyles.light.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
        ),
        side: BorderSide.none,
      ),

      // ── Progress indicator ──────────────────────────────────────────
      progressIndicatorTheme: _progressIndicatorTheme(colorScheme),
    );
  }

  static ThemeData get darkTheme {
    final colors = AppColors.dark;

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: colors.brandPrimary,
          brightness: Brightness.dark,
        ).copyWith(
          // ── Primary ─────────────────────────────────────────────────────
          primary: colors.brandPrimary,
          onPrimary: colors.onPrimary,
          primaryContainer: colors.brandAccent,
          onPrimaryContainer: colors.onPrimaryContainer,
          primaryFixed: colors.primaryFixed,
          primaryFixedDim: colors.primaryFixedDim,
          onPrimaryFixed: colors.onPrimaryFixed,
          onPrimaryFixedVariant: colors.onPrimaryFixedVariant,
          inversePrimary: colors.inversePrimary,

          // ── Secondary ───────────────────────────────────────────────────
          secondary: colors.secondary,
          onSecondary: colors.onSecondary,
          secondaryContainer: colors.secondaryContainer,
          onSecondaryContainer: colors.onSecondaryContainer,

          // ── Tertiary ────────────────────────────────────────────────────
          tertiary: colors.tertiary,
          onTertiary: colors.onTertiary,
          tertiaryContainer: colors.tertiaryContainer,
          onTertiaryContainer: colors.onTertiaryContainer,

          // ── Error ───────────────────────────────────────────────────────
          error: colors.error,
          onError: colors.onError,
          errorContainer: colors.errorContainer,
          onErrorContainer: colors.onErrorContainer,

          // ── Surface ─────────────────────────────────────────────────────
          surface: colors.cardSurface,
          onSurface: colors.textDefault,
          onSurfaceVariant: colors.textSubtle,
          surfaceContainerLowest: colors.cardSurface,
          surfaceContainerLow: colors.surfaceContainerLow,
          surfaceContainer: colors.tonalSurface,
          surfaceContainerHigh: colors.surfaceContainerHigh,
          surfaceContainerHighest: colors.surfaceContainerHighest,
          surfaceDim: colors.surfaceDim,
          surfaceBright: colors.background,
          inverseSurface: colors.inverseSurface,
          onInverseSurface: colors.inverseOnSurface,
          surfaceTint: colors.surfaceTint,

          // ── Outline ─────────────────────────────────────────────────────
          outline: colors.outline,
          outlineVariant: colors.ghostBorder,
        );

    return ThemeData(
      useMaterial3: true,
      primaryColor: colors.brandPrimary,
      scaffoldBackgroundColor: colors.background,
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
        iconTheme: IconThemeData(color: colors.textDefault),
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
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: AppUIConstants.spacing.space$16,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: AppTextStyles.dark.bodyMedium.copyWith(
          color: colorScheme.onInverseSurface,
        ),
      ),

      // ── Buttons — Capsule (rounded-full) by default ─────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppTextStyles.dark.labelLarge.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppTextStyles.dark.labelLarge.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppTextStyles.dark.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppTextStyles.dark.labelLarge.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ),

      // ── Card ────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: colors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Chip ────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceContainerHighest,
        labelStyle: AppTextStyles.dark.labelSmall.copyWith(
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
        ),
        side: BorderSide.none,
      ),

      // ── Progress indicator ──────────────────────────────────────────
      progressIndicatorTheme: _progressIndicatorTheme(colorScheme),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colors) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
      borderSide: BorderSide(color: colors.outlineVariant, width: 1),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: colors.surfaceContainerLowest,
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
      hintStyle: (colors.brightness == Brightness.light
              ? AppTextStyles.light.bodyMedium
              : AppTextStyles.dark.bodyMedium)
          .copyWith(color: colors.onSurfaceVariant),
    );
  }

  static ProgressIndicatorThemeData _progressIndicatorTheme(
    ColorScheme colors,
  ) {
    return ProgressIndicatorThemeData(
      color: colors.primary,
      circularTrackColor: colors.primary.withValues(alpha: 0.1),
      refreshBackgroundColor: colors.surface,
    );
  }
}
