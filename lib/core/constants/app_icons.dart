import 'package:flutter/material.dart';

class AppIcons {
  AppIcons._();

  static const auth = _AuthIcons();
  static const status = _StatusIcons();
  static const common = _CommonIcons();
}

class _AuthIcons {
  const _AuthIcons();

  IconData get email => Icons.email_outlined;
  IconData get password => Icons.lock_outline_rounded;
  IconData get user => Icons.person_outline_rounded;
  IconData get phone => Icons.phone_android_rounded;
  String get googleLogo => 'assets/icons/google.svg';
  String get appleLogo => 'assets/icons/apple.svg';
}

class _StatusIcons {
  const _StatusIcons();

  IconData get error => Icons.error_outline_rounded;
  IconData get success => Icons.check_circle_outline_rounded;
  IconData get info => Icons.info_outline_rounded;
  IconData get warn => Icons.warning_amber_rounded;
}

class _CommonIcons {
  const _CommonIcons();

  IconData get edit => Icons.edit_outlined;
  IconData get back => Icons.arrow_back_ios_new_rounded;
  IconData get logout => Icons.logout_rounded;
  IconData get search => Icons.search_rounded;
  IconData get add => Icons.add_rounded;
  IconData get close => Icons.close_rounded;
  IconData get settings => Icons.settings_rounded;
}
