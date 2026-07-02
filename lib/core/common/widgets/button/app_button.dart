import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';

enum ButtonShape {
  pill,
  rounded,
  circle,
  hardEdge,
}

enum AppButtonVariant {
  primary,
  secondary,
  outlined,
  ghost,
  filledWithOpacity,
}

class AppButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonShape shape;
  final AppButtonVariant variant;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderWidth;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;

  const AppButton({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.shape = ButtonShape.pill,
    this.variant = AppButtonVariant.primary,
    this.width = double.infinity,
    this.height = 48.0,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.opacity = 0.1,
    this.padding,
    this.boxShadow,
  });

  const AppButton.primary({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.shape = ButtonShape.pill,
    this.width = double.infinity,
    this.height = 48.0,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.boxShadow,
  })  : variant = AppButtonVariant.primary,
        borderColor = null,
        borderWidth = 1.5,
        opacity = 0.1;

  const AppButton.filled({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.shape = ButtonShape.pill,
    this.width = double.infinity,
    this.height = 48.0,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.boxShadow,
  })  : variant = AppButtonVariant.primary,
        borderColor = null,
        borderWidth = 1.5,
        opacity = 0.1;

  const AppButton.secondary({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.shape = ButtonShape.pill,
    this.width = double.infinity,
    this.height = 48.0,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.boxShadow,
  })  : variant = AppButtonVariant.secondary,
        borderColor = null,
        borderWidth = 1.5,
        opacity = 0.1;

  const AppButton.outlined({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.shape = ButtonShape.pill,
    this.width = double.infinity,
    this.height = 48.0,
    this.backgroundColor = Colors.transparent,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.padding,
    this.boxShadow,
  })  : variant = AppButtonVariant.outlined,
        opacity = 0.1;

  const AppButton.ghost({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.shape = ButtonShape.pill,
    this.width = double.infinity,
    this.height = 48.0,
    this.textColor,
    this.padding,
  })  : variant = AppButtonVariant.ghost,
        backgroundColor = Colors.transparent,
        borderColor = null,
        borderWidth = 0.0,
        opacity = 0.1,
        boxShadow = null;

  const AppButton.filledWithOpacity({
    super.key,
    this.text,
    this.child,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.shape = ButtonShape.pill,
    this.width = double.infinity,
    this.height = 48.0,
    this.backgroundColor,
    this.textColor,
    this.opacity = 0.1,
    this.padding,
    this.boxShadow,
  })  : variant = AppButtonVariant.filledWithOpacity,
        borderColor = null,
        borderWidth = 1.5;

  BorderRadius _getBorderRadius() {
    return switch (shape) {
      ButtonShape.pill => BorderRadius.circular(9999),
      ButtonShape.circle => BorderRadius.circular(9999),
      ButtonShape.rounded => BorderRadius.circular(AppUIConstants.radius.radius$12),
      ButtonShape.hardEdge => BorderRadius.zero,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final borderRadius = _getBorderRadius();

    Color effectiveBg;
    Color effectiveFg;
    BorderSide effectiveSide = BorderSide.none;

    switch (variant) {
      case AppButtonVariant.primary:
        effectiveBg = backgroundColor ?? theme.colorScheme.primary;
        effectiveFg = textColor ?? theme.colorScheme.onPrimary;
        break;
      case AppButtonVariant.secondary:
        effectiveBg = backgroundColor ?? theme.colorScheme.secondary;
        effectiveFg = textColor ?? theme.colorScheme.onSecondary;
        break;
      case AppButtonVariant.outlined:
        effectiveBg = backgroundColor ?? Colors.transparent;
        effectiveFg = textColor ?? theme.colorScheme.primary;
        effectiveSide = BorderSide(
          color: borderColor ?? textColor ?? theme.colorScheme.outlineVariant,
          width: borderWidth,
        );
        break;
      case AppButtonVariant.ghost:
        effectiveBg = backgroundColor ?? Colors.transparent;
        effectiveFg = textColor ?? theme.colorScheme.primary;
        break;
      case AppButtonVariant.filledWithOpacity:
        final baseColor = backgroundColor ?? theme.colorScheme.primary;
        effectiveBg = baseColor.withValues(alpha: opacity);
        effectiveFg = textColor ?? baseColor;
        break;
    }

    // Priority order: child > text
    Widget contentWidget;
    if (isLoading) {
      contentWidget = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
        ),
      );
    } else if (child != null) {
      contentWidget = child!;
    } else if (icon != null) {
      contentWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: AppUIConstants.spacing.space$8,
        children: [
          icon!,
          Text(
            text ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: effectiveFg,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      contentWidget = Text(
        text ?? '',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: effectiveFg,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: AppUIConstants.spacing.space$16,
          vertical: AppUIConstants.spacing.space$12,
        );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBg,
      foregroundColor: effectiveFg,
      disabledBackgroundColor: effectiveBg.withValues(alpha: 0.5),
      disabledForegroundColor: effectiveFg.withValues(alpha: 0.5),
      elevation: 0,
      padding: effectivePadding,
      minimumSize: Size(
        width == double.infinity ? double.infinity : (width ?? 0.0),
        height ?? 48.0,
      ),
      maximumSize: Size(
        double.infinity,
        height ?? double.infinity,
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: effectiveSide,
      shape: shape == ButtonShape.circle
          ? const CircleBorder()
          : RoundedRectangleBorder(borderRadius: borderRadius),
      splashFactory: isLoading ? NoSplash.splashFactory : null,
    );

    Widget result = ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: buttonStyle,
      child: contentWidget,
    );

    if (boxShadow != null && boxShadow!.isNotEmpty) {
      result = Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: result,
      );
    }

    if (width != null && width != double.infinity) {
      result = SizedBox(
        width: width,
        child: result,
      );
    }

    if (height != null) {
      result = SizedBox(
        height: height,
        child: result,
      );
    }

    return result;
  }
}
