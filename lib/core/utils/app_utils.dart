import 'package:flutter/services.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';

class AppUtils {
  const AppUtils._();

  static void copyToClipboard(String text, {String? message}) {
    Clipboard.setData(ClipboardData(text: text));
    AppSnackbar.info(message ?? AppStrings.common.copied);
  }

  static String formatNotificationCount(int count) {
    if (count <= 0) return '';
    if (count > 99) return '99+';
    return count.toString();
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Maps a timezone name abbreviation (e.g. "IST") to a country ISO code (e.g. "IN")
  static String? getIsoCodeFromTimezone(String timezoneName) {
    final tz = timezoneName.toUpperCase().trim();
    return switch (tz) {
      'IST' => 'IN',
      'GMT' || 'BST' => 'GB',
      'EST' ||
      'EDT' ||
      'CST' ||
      'CDT' ||
      'MST' ||
      'MDT' ||
      'PST' ||
      'PDT' => 'US',
      'AEST' || 'AEDT' || 'AWST' || 'ACST' || 'ACDT' => 'AU',
      'SGT' => 'SG',
      'JST' => 'JP',
      'CET' || 'CEST' => 'DE',
      'GST' => 'AE',
      'NZST' || 'NZDT' => 'NZ',
      'SAST' => 'ZA',
      _ => null,
    };
  }
}
