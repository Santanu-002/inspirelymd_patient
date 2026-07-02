import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class AppSnackbar {
  const AppSnackbar._();

  static void custom({
    String? message,
    Widget? child,
    Widget? leading,
    IconData? icon,
    Widget? trailing,
    required Color backgroundColor,
    Color? iconColor,
    Color? textColor,
    SnackBarAction? action,
  }) {
    final context = Get.context;
    if (context == null) return;

    final defaultTextColor =
        context.theme.snackBarTheme.contentTextStyle?.color ??
            context.theme.colorScheme.onInverseSurface;

    Widget? effectiveLeading;
    if (leading != null) {
      effectiveLeading = leading;
    } else if (icon != null) {
      effectiveLeading = Icon(
        icon,
        color: iconColor ?? defaultTextColor,
        size: 20.0,
      );
    }

    Widget contentWidget;
    if (child != null) {
      contentWidget = child;
    } else {
      contentWidget = Text(
        message ?? '',
        style: context.theme.snackBarTheme.contentTextStyle?.copyWith(
              color: textColor ?? defaultTextColor,
            ) ??
            TextStyle(color: textColor ?? defaultTextColor),
      );
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          if (effectiveLeading != null) ...[
            effectiveLeading,
            AppUIConstants.widgets.horizontalBox$12,
          ],
          Expanded(child: contentWidget),
          if (trailing != null) ...[
            AppUIConstants.widgets.horizontalBox$12,
            trailing,
          ],
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 3),
      elevation: 4,
      action: action,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void success(
    String? message, {
    Widget? child,
    Widget? leading,
    IconData? icon,
    Widget? trailing,
    SnackBarAction? action,
  }) {
    custom(
      message: message,
      child: child,
      leading: leading,
      icon: icon,
      trailing: trailing,
      backgroundColor: Get.theme.colorScheme.completed,
      iconColor: Get.theme.colorScheme.onPrimary,
      textColor: Get.theme.colorScheme.onPrimary,
      action: action,
    );
  }

  static void destructive(
    String? message, {
    Widget? child,
    Widget? leading,
    IconData? icon,
    Widget? trailing,
    SnackBarAction? action,
  }) {
    custom(
      message: message,
      child: child,
      leading: leading,
      icon: icon,
      trailing: trailing,
      backgroundColor: Get.theme.colorScheme.error,
      iconColor: Get.theme.colorScheme.onError,
      textColor: Get.theme.colorScheme.onError,
      action: action,
    );
  }

  static void warn(
    String? message, {
    Widget? child,
    Widget? leading,
    IconData? icon,
    Widget? trailing,
    SnackBarAction? action,
  }) {
    custom(
      message: message,
      child: child,
      leading: leading,
      icon: icon,
      trailing: trailing,
      backgroundColor: Get.theme.colorScheme.pending,
      iconColor: Get.theme.colorScheme.onSurface,
      textColor: Get.theme.colorScheme.onSurface,
      action: action,
    );
  }

  static void info(
    String? message, {
    Widget? child,
    Widget? leading,
    IconData? icon,
    Widget? trailing,
    SnackBarAction? action,
  }) {
    custom(
      message: message,
      child: child,
      leading: leading,
      icon: icon,
      trailing: trailing,
      backgroundColor: Get.theme.colorScheme.primary,
      iconColor: Get.theme.colorScheme.onPrimary,
      textColor: Get.theme.colorScheme.onPrimary,
      action: action,
    );
  }

  static void standard(
    String? message, {
    Widget? child,
    Widget? leading,
    IconData? icon,
    Widget? trailing,
    SnackBarAction? action,
  }) {
    custom(
      message: message,
      child: child,
      leading: leading,
      icon: icon,
      trailing: trailing,
      backgroundColor: Get.theme.colorScheme.inverseSurface,
      iconColor: Get.theme.colorScheme.onInverseSurface,
      textColor: Get.theme.colorScheme.onInverseSurface,
      action: action,
    );
  }

  static void normal(
    String? message, {
    Widget? child,
    Widget? leading,
    IconData? icon,
    Widget? trailing,
    SnackBarAction? action,
  }) =>
      standard(
        message,
        child: child,
        leading: leading,
        icon: icon,
        trailing: trailing,
        action: action,
      );
}
