import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';

class AppTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? dotColor;

  const AppTag({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppUIConstants.spacing.space$8,
        vertical: AppUIConstants.spacing.space$4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppUIConstants.spacing.space$4,
        children: [
          if (dotColor != null)
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          Text(
            text,
            style: textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
