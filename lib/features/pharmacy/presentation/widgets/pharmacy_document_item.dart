import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_icon_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class PharmacyDocumentItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onDownload;

  const PharmacyDocumentItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppUIConstants.spacing.space$16,
        vertical: AppUIConstants.spacing.space$12,
      ),
      child: Row(
        spacing: AppUIConstants.spacing.space$16,
        children: [
          // Icon Container
          AppIconBox(
            icon: icon,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            iconColor: theme.colorScheme.primary,
          ),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppUIConstants.spacing.space$2,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          // Download icon button
          AppIconButton.ghost(
            icon: CupertinoIcons.arrow_down_to_line_alt,
            iconColor: theme.colorScheme.textMuted,
            onPressed: onDownload,
          ),
        ],
      ),
    );
  }
}
