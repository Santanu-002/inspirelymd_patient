import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';

enum AppIconButtonVariant {
  filled,
  outlined,
  ghost,
  filledOutlined,
  filledWithOpacity,
}

class AppIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final Widget? child;
  final VoidCallback? onPressed;
  final ButtonShape shape;
  final AppIconButtonVariant variant;
  final double? width;
  final double? height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final double borderWidth;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  const AppIconButton({
    super.key,
    this.icon,
    this.iconWidget,
    this.child,
    this.onPressed,
    this.shape = ButtonShape.circle,
    this.variant = AppIconButtonVariant.filled,
    double? width,
    double? height,
    double? size,
    this.iconSize = 20.0,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.opacity = 0.1,
    this.padding,
    this.isLoading = false,
  })  : width = size ?? width,
        height = size ?? height;

  const AppIconButton.filled({
    super.key,
    this.icon,
    this.iconWidget,
    this.child,
    this.onPressed,
    this.shape = ButtonShape.circle,
    double? width,
    double? height,
    double? size,
    this.iconSize = 20.0,
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.isLoading = false,
  })  : variant = AppIconButtonVariant.filled,
        width = size ?? width,
        height = size ?? height,
        borderColor = null,
        borderWidth = 1.5,
        opacity = 0.1;

  const AppIconButton.outlined({
    super.key,
    this.icon,
    this.iconWidget,
    this.child,
    this.onPressed,
    this.shape = ButtonShape.circle,
    double? width,
    double? height,
    double? size,
    this.iconSize = 20.0,
    this.backgroundColor = Colors.transparent,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.padding,
    this.isLoading = false,
  })  : variant = AppIconButtonVariant.outlined,
        width = size ?? width,
        height = size ?? height,
        opacity = 0.1;

  const AppIconButton.ghost({
    super.key,
    this.icon,
    this.iconWidget,
    this.child,
    this.onPressed,
    this.shape = ButtonShape.circle,
    double? width,
    double? height,
    double? size,
    this.iconSize = 20.0,
    this.iconColor,
    this.padding,
    this.isLoading = false,
  })  : variant = AppIconButtonVariant.ghost,
        width = size ?? width,
        height = size ?? height,
        backgroundColor = Colors.transparent,
        borderColor = null,
        borderWidth = 0.0,
        opacity = 0.1;

  const AppIconButton.filledOutlined({
    super.key,
    this.icon,
    this.iconWidget,
    this.child,
    this.onPressed,
    this.shape = ButtonShape.circle,
    double? width,
    double? height,
    double? size,
    this.iconSize = 20.0,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.padding,
    this.isLoading = false,
  })  : variant = AppIconButtonVariant.filledOutlined,
        width = size ?? width,
        height = size ?? height,
        opacity = 0.1;

  const AppIconButton.filledWithOpacity({
    super.key,
    this.icon,
    this.iconWidget,
    this.child,
    this.onPressed,
    this.shape = ButtonShape.circle,
    double? width,
    double? height,
    double? size,
    this.iconSize = 20.0,
    this.backgroundColor,
    this.iconColor,
    this.opacity = 0.1,
    this.padding,
    this.isLoading = false,
  })  : variant = AppIconButtonVariant.filledWithOpacity,
        width = size ?? width,
        height = size ?? height,
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
      case AppIconButtonVariant.filled:
        effectiveBg = backgroundColor ?? theme.colorScheme.primary;
        effectiveFg = iconColor ?? theme.colorScheme.onPrimary;
        break;
      case AppIconButtonVariant.outlined:
        effectiveBg = backgroundColor ?? Colors.transparent;
        effectiveFg = iconColor ?? theme.colorScheme.primary;
        effectiveSide = BorderSide(
          color: borderColor ?? iconColor ?? theme.colorScheme.outlineVariant,
          width: borderWidth,
        );
        break;
      case AppIconButtonVariant.ghost:
        effectiveBg = backgroundColor ?? Colors.transparent;
        effectiveFg = iconColor ?? theme.colorScheme.primary;
        break;
      case AppIconButtonVariant.filledOutlined:
        effectiveBg = backgroundColor ?? theme.colorScheme.surface;
        effectiveFg = iconColor ?? theme.colorScheme.onSurface;
        effectiveSide = BorderSide(
          color: borderColor ?? theme.colorScheme.outlineVariant,
          width: borderWidth,
        );
        break;
      case AppIconButtonVariant.filledWithOpacity:
        final baseColor = iconColor ?? backgroundColor ?? theme.colorScheme.primary;
        effectiveBg = (backgroundColor ?? baseColor).withValues(alpha: opacity);
        effectiveFg = iconColor ?? baseColor;
        break;
    }

    // Priority order: child > iconWidget > Icon(icon)
    Widget contentWidget;
    if (isLoading) {
      contentWidget = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
        ),
      );
    } else if (child != null) {
      contentWidget = child!;
    } else if (iconWidget != null) {
      contentWidget = iconWidget!;
    } else if (icon != null) {
      contentWidget = Icon(
        icon,
        size: iconSize,
        color: effectiveFg,
      );
    } else {
      contentWidget = const SizedBox.shrink();
    }

    final effectivePadding = padding ?? EdgeInsets.all(AppUIConstants.spacing.space$8);

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBg,
      foregroundColor: effectiveFg,
      disabledBackgroundColor: effectiveBg.withValues(alpha: 0.5),
      disabledForegroundColor: effectiveFg.withValues(alpha: 0.5),
      elevation: 0,
      padding: effectivePadding,
      minimumSize: Size(
        width == double.infinity ? double.infinity : (width ?? 0.0),
        height ?? 0.0,
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
