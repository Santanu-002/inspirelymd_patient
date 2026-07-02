import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/tag/app_tag.dart';
import 'package:inspirelymd_patient/features/account/presentation/controllers/account_controller.dart';
import 'package:inspirelymd_patient/features/account/presentation/widgets/account_settings_item.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';

class AccountContent extends GetView<AccountController> {
  const AccountContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.account;

    return AppScaffold(
      useScrollView: true,
      title: Text(
        strings.title,
        style: theme.textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
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
              spacing: AppUIConstants.spacing.space$16,
              children: [
                // JA Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'JA',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
                      AppUIConstants.widgets.verticalBox$4,
                      Text(
                        strings.email,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                      AppUIConstants.widgets.verticalBox$8,
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
                AccountSettingsItem(
                  title: strings.personalProfile,
                  subtitle: strings.personalProfileSub,
                  icon: Icons.person_outline_rounded,
                  onTap: () => controller.openSettingsSection(strings.personalProfile),
                ),
                const Divider(height: 1),
                AccountSettingsItem(
                  title: strings.paymentBilling,
                  subtitle: strings.paymentBillingSub,
                  icon: Icons.credit_card_outlined,
                  onTap: () => controller.openSettingsSection(strings.paymentBilling),
                ),
                const Divider(height: 1),
                AccountSettingsItem(
                  title: strings.subscriptions,
                  subtitle: strings.subscriptionsSub,
                  icon: Icons.sync_rounded,
                  onTap: () => controller.openSettingsSection(strings.subscriptions),
                ),
                const Divider(height: 1),
                AccountSettingsItem(
                  title: strings.medicalRecords,
                  subtitle: strings.medicalRecordsSub,
                  icon: Icons.description_outlined,
                  onTap: () => controller.openSettingsSection(strings.medicalRecords),
                ),
                const Divider(height: 1),
                AccountSettingsItem(
                  title: strings.consents,
                  subtitle: strings.consentsSub,
                  icon: Icons.shield_outlined,
                  onTap: () => controller.openSettingsSection(strings.consents),
                ),
                const Divider(height: 1),
                AccountSettingsItem(
                  title: strings.notifications,
                  subtitle: strings.notificationsSub,
                  icon: Icons.notifications_none_rounded,
                  onTap: () => controller.openSettingsSection(strings.notifications),
                ),
                const Divider(height: 1),
                AccountSettingsItem(
                  title: strings.helpSupport,
                  subtitle: strings.helpSupportSub,
                  icon: Icons.help_outline_rounded,
                  onTap: () => controller.openSettingsSection(strings.helpSupport),
                ),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$24,

          // ── Sign Out Button ──────────────────────────────────────────────
          AppButton.outlined(
            text: strings.signOut,
            onPressed: controller.handleSignOut,
          ),
          AppUIConstants.widgets.verticalBox$24,

          // Centered Muted Footer
          Center(
            child: Column(
              spacing: AppUIConstants.spacing.space$2,
              children: [
                Text(
                  strings.footerPhysician,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.textMuted,
                  ),
                ),
                Text(
                  strings.footerLicensed,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.textMuted,
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
}
