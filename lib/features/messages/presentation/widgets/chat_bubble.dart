import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: EdgeInsets.only(bottom: AppUIConstants.spacing.space$8),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        spacing: AppUIConstants.spacing.space$4,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
            decoration: BoxDecoration(
              color: isMe
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceWhite,
              border: isMe
                  ? null
                  : Border.all(
                      color: theme.colorScheme.outlineVariant,
                      width: 1,
                    ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppUIConstants.radius.lg),
                topRight: Radius.circular(AppUIConstants.radius.lg),
                bottomLeft: Radius.circular(isMe ? AppUIConstants.radius.lg : 4),
                bottomRight: Radius.circular(isMe ? 4 : AppUIConstants.radius.lg),
              ),
            ),
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                height: 1.4,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppUIConstants.spacing.space$4,
            ),
            child: Text(
              time,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
