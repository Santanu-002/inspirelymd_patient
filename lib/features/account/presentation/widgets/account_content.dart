import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/tag/app_tag.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/features/account/presentation/controllers/account_controller.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';

class AccountContent extends GetView<AccountController> {
  const AccountContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.account;

    return AppScaffold(
      useScrollView: true,
      titleWidget: Text(
        strings.title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0D253F),
          fontSize: 24,
        ),
      ),
      centerTitle: false,
      titleSpacing: 16,
      automaticallyImplyLeading: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Profile Card ─────────────────────────────────────────────────
          AppCard(
            child: Row(
              children: [
                // JA Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'JA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jordan Avery',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        strings.email,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 6),
                      AppTag(
                        text: strings.memberTag,
                        backgroundColor: theme.colorScheme.outlineVariant
                            .withValues(alpha: 0.5),
                        textColor: theme.colorScheme.onSurface,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$16,

          // ── Settings Card ────────────────────────────────────────────────
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSettingsItem(
                  context: context,
                  title: strings.personalProfile,
                  subtitle: strings.personalProfileSub,
                  icon: Icons.person_outline_rounded,
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context: context,
                  title: strings.paymentBilling,
                  subtitle: strings.paymentBillingSub,
                  icon: Icons.credit_card_outlined,
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context: context,
                  title: strings.subscriptions,
                  subtitle: strings.subscriptionsSub,
                  icon: Icons.sync_rounded,
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context: context,
                  title: strings.medicalRecords,
                  subtitle: strings.medicalRecordsSub,
                  icon: Icons.description_outlined,
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context: context,
                  title: strings.consents,
                  subtitle: strings.consentsSub,
                  icon: Icons.shield_outlined,
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context: context,
                  title: strings.notifications,
                  subtitle: strings.notificationsSub,
                  icon: Icons.notifications_none_rounded,
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context: context,
                  title: strings.helpSupport,
                  subtitle: strings.helpSupportSub,
                  icon: Icons.help_outline_rounded,
                ),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$24,

          // ── Sign Out Button ──────────────────────────────────────────────
          OutlinedButton(
            onPressed: controller.handleSignOut,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant,
                width: 1.5,
              ),
            ),
            child: Text(
              strings.signOut,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppUIConstants.widgets.verticalBox$24,

          // Centered Muted Footer
          Center(
            child: Column(
              children: [
                Text(
                  strings.footerPhysician,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.textMuted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  strings.footerLicensed,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$32,
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: () => controller.openSettingsSection(title),
        child: Row(
          children: [
            AppIconBox(
              icon: icon,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              iconColor: theme.colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
