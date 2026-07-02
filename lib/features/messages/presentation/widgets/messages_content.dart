import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_icon_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/text_field/app_text_field.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/features/messages/presentation/controllers/messages_controller.dart';
import 'package:inspirelymd_patient/features/messages/presentation/widgets/chat_bubble.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';

class MessagesContent extends GetView<MessagesController> {
  const MessagesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.messages;

    return AppScaffold(
      useScrollView: false,
      padding: EdgeInsets.zero,
      title: Row(
        spacing: AppUIConstants.spacing.space$12,
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'AR',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Name and status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Dr. Alana Reyes, MD',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  spacing: AppUIConstants.spacing.space$6,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.completed,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      'Online · your care team',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.completed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: false,
      titleSpacing: AppUIConstants.spacing.space$16,
      automaticallyImplyLeading: false,
      actions: [
        AppIconButton.ghost(
          icon: Icons.videocam_outlined,
          iconColor: theme.colorScheme.onSurface,
          onPressed: () => Get.toNamed(AppRoutes.videoCall),
        ),
      ],
      child: Column(
        children: [
          // ── Message Thread List ──────────────────────────────────────────
          Expanded(
            child: Container(
              color: theme.colorScheme.surfaceBright,
              child: Column(
                children: [
                  // Encryption notice
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppUIConstants.spacing.space$16,
                    ),
                    child: Center(
                      child: Text(
                        strings.encryptedNotice,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                    ),
                  ),
                  // Chat bubbles
                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        controller: controller.scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppUIConstants.spacing.containerPadding,
                        ),
                        itemCount: controller.messagesList.length,
                        itemBuilder: (context, index) {
                          final msg = controller.messagesList[index];
                          final isMe = msg['sender'] == 'patient';
                          return ChatBubble(
                            text: msg['text'] ?? '',
                            time: msg['time'] ?? '',
                            isMe: isMe,
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // ── Composer / Bottom Input Area ─────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppUIConstants.spacing.containerPadding,
              vertical: AppUIConstants.spacing.space$12,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              spacing: AppUIConstants.spacing.space$12,
              children: [
                // Text Field
                Expanded(
                  child: AppTextField(
                    controller: controller.textController,
                    textInputAction: TextInputAction.send,
                    textCapitalization: TextCapitalization.sentences,
                    onFieldSubmitted: (_) => controller.sendMessage(),
                    textStyle: theme.textTheme.bodyMedium,
                    hintText: strings.inputHint,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.textMuted,
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerLowest,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppUIConstants.spacing.space$16,
                      vertical: AppUIConstants.spacing.space$12,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppUIConstants.radius.full,
                    ),
                  ),
                ),
                // Send action button
                AppIconButton.filled(
                  iconWidget: Icon(
                    CupertinoIcons.paperplane,
                    color: theme.colorScheme.onPrimary,
                    size: 20,
                  ),
                  size: 48,
                  backgroundColor: theme.colorScheme.primary,
                  onPressed: controller.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
