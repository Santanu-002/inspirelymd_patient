import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.messages;

    return Scaffold(
      backgroundColor: theme.colorScheme.black,
      body: Stack(
        children: [
          // ── Centered Call Status Info ────────────────────────────────────
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Doctor Avatar
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      strings.videoCallAvatarInitials,
                      style: GoogleFonts.hankenGrotesk(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                AppUIConstants.widgets.verticalBox$24,
                // Doctor Name
                Text(
                  strings.videoCallDoctorName,
                  style: GoogleFonts.hankenGrotesk(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.2,
                  ),
                ),
                AppUIConstants.widgets.verticalBox$8,
                // Connection Status
                Text(
                  strings.videoCallConnecting,
                  style: GoogleFonts.hankenGrotesk(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // ── Top Right User Video Preview (PIP) ───────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            right: 20,
            child: Container(
              width: 100,
              height: 156,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white38,
                  size: 32,
                ),
              ),
            ),
          ),

          // ── Bottom Action Buttons row ────────────────────────────────────
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppUIConstants.spacing.space$24,
              children: [
                // Toggle Video Button
                _buildCircularButton(
                  icon: Icons.videocam_outlined,
                  onPressed: () {
                    AppSnackbar.info(strings.videoCallToggleCamera);
                  },
                ),
                // End Call Button (Hangup)
                GestureDetector(
                  onTap: () {
                    AppSnackbar.destructive(strings.videoCallCallEnded);
                    Get.back();
                  },
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 16,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.call_end,
                      color: theme.colorScheme.onPrimary,
                      size: 28,
                    ),
                  ),
                ),
                // Message/Chat Button
                _buildCircularButton(
                  icon: CupertinoIcons.chat_bubble,
                  onPressed: () {
                    Get.back(); // returns to chat conversation
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onPressed,
    double size = 56,
    double iconSize = 24,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
