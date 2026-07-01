import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/tag/app_tag.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_pill_button.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/pharmacy_controller.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';

class PharmacyContent extends GetView<PharmacyController> {
  const PharmacyContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.pharmacy;

    return AppScaffold(
      useScrollView: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header titles
          Text(
            strings.headerTitle,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            strings.ordersTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0D253F),
            ),
          ),
          AppUIConstants.widgets.verticalBox$24,

          // ── Card 1: Order INSP-7841 ──────────────────────────────────────
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strings.orderId,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const AppTag(
                      text: 'In transit',
                      backgroundColor: Color(0xFFE3F2FD),
                      textColor: Color(0xFF1E88E5),
                      dotColor: Color(0xFF1E88E5),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Vertical timeline list
                _buildTimelineStep(
                  context: context,
                  title: strings.planApproved,
                  subtitle: strings.planApprovedSub,
                  isPassed: true,
                  isCurrent: false,
                  isFirst: true,
                  isLast: false,
                ),
                _buildTimelineStep(
                  context: context,
                  title: strings.paymentCharged,
                  subtitle: strings.paymentChargedSub,
                  isPassed: true,
                  isCurrent: false,
                  isFirst: false,
                  isLast: false,
                ),
                _buildTimelineStep(
                  context: context,
                  title: strings.sentToPharmacy,
                  subtitle: strings.sentToPharmacySub,
                  isPassed: true,
                  isCurrent: false,
                  isFirst: false,
                  isLast: false,
                ),
                _buildTimelineStep(
                  context: context,
                  title: strings.preparedFilled,
                  subtitle: strings.preparedFilledSub,
                  isPassed: false,
                  isCurrent: true,
                  isFirst: false,
                  isLast: false,
                  currentIcon: Icons.local_shipping,
                  currentColor: theme.colorScheme.primary,
                ),
                _buildTimelineStep(
                  context: context,
                  title: strings.shipped,
                  subtitle: strings.shippedSub,
                  isPassed: false,
                  isCurrent: false,
                  isFirst: false,
                  isLast: true,
                ),

                const SizedBox(height: 24),
                // Reorder button
                OutlinedButton(
                  onPressed: controller.triggerReorder,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sync_rounded,
                        color: theme.colorScheme.onSurface,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        strings.reorderButton,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$16,

          // ── Card 2: Document Vault ───────────────────────────────────────
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.documentVault,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        strings.documentCount,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Item 1
                _buildDocumentItem(
                  context: context,
                  title: strings.semaglutideRx,
                  subtitle: strings.semaglutideRxSub,
                  icon: Icons.description_outlined,
                ),
                const Divider(height: 1),

                // Item 2
                _buildDocumentItem(
                  context: context,
                  title: strings.visitSummary,
                  subtitle: strings.visitSummarySub,
                  icon: Icons.description_outlined,
                ),
                const Divider(height: 1),

                // Item 3
                _buildDocumentItem(
                  context: context,
                  title: strings.hormonePanel,
                  subtitle: strings.hormonePanelSub,
                  icon: Icons.description_outlined,
                ),
                const Divider(height: 1),

                // Item 4
                _buildDocumentItem(
                  context: context,
                  title: strings.signedConsents,
                  subtitle: strings.signedConsentsSub,
                  icon: Icons.shield_outlined,
                ),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$24,

          // ── Title 2: Recommended for you ─────────────────────────────────
          Text(
            strings.recommendedTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // ── Recommendations Card ──────────────────────────────────────────
          AppCard(
            padding: EdgeInsets.zero,
            child: Obx(() {
              return Column(
                children: List.generate(controller.recommendationList.length, (
                  index,
                ) {
                  final item = controller.recommendationList[index];
                  final isAdded = item['added'] as bool;

                  IconData itemIcon;
                  Color iconColor;
                  Color iconBg;

                  if (item['id'] == 'tirzepatide') {
                    itemIcon = Icons.local_mall_outlined;
                    iconColor = const Color(0xFF1E88E5);
                    iconBg = const Color(0xFFE3F2FD);
                  } else if (item['id'] == 'nausea_kit') {
                    itemIcon = Icons.medical_services_outlined;
                    iconColor = const Color(0xFF2E7D32);
                    iconBg = const Color(0xFFE8F5E9);
                  } else {
                    itemIcon = Icons.auto_awesome;
                    iconColor = theme.colorScheme.primary;
                    iconBg = theme.colorScheme.primary.withValues(alpha: 0.1);
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            AppIconBox(
                              icon: itemIcon,
                              backgroundColor: iconBg,
                              iconColor: iconColor,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['subtitle'],
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Custom Add Pill Tag button
                            AppPillButton(
                              text: isAdded ? 'Added' : strings.addButton,
                              backgroundColor: isAdded
                                  ? theme.colorScheme.outlineVariant
                                  : theme.colorScheme.primary.withValues(
                                      alpha: 0.1,
                                    ),
                              textColor: isAdded
                                  ? theme.colorScheme.textMuted
                                  : theme.colorScheme.primary,
                              onTap: () =>
                                  controller.toggleRecommendation(index),
                            ),
                          ],
                        ),
                      ),
                      if (index < controller.recommendationList.length - 1)
                        const Divider(height: 1),
                    ],
                  );
                }),
              );
            }),
          ),
          AppUIConstants.widgets.verticalBox$32,
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool isPassed,
    required bool isCurrent,
    required bool isFirst,
    required bool isLast,
    IconData? currentIcon,
    Color? currentColor,
  }) {
    final theme = context.theme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left timeline graphic
          Column(
            children: [
              // Top line
              Container(
                width: 2,
                height: 12,
                color: isFirst
                    ? Colors.transparent
                    : (isPassed || isCurrent
                          ? const Color(0xFF2E7D32)
                          : theme.colorScheme.outlineVariant),
              ),
              // Circle/Icon
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPassed
                      ? const Color(0xFF2E7D32)
                      : (isCurrent
                            ? (currentColor ?? theme.colorScheme.primary)
                            : Colors.transparent),
                  border: isPassed || isCurrent
                      ? null
                      : Border.all(
                          color: theme.colorScheme.outlineVariant,
                          width: 2,
                        ),
                ),
                child: Center(
                  child: isPassed
                      ? const Icon(Icons.check, color: Colors.white, size: 14)
                      : (isCurrent && currentIcon != null
                            ? Icon(currentIcon, color: Colors.white, size: 14)
                            : null),
                ),
              ),
              // Bottom line
              Expanded(
                child: Container(
                  width: 2,
                  color: isLast
                      ? Colors.transparent
                      : (isPassed
                            ? const Color(0xFF2E7D32)
                            : theme.colorScheme.outlineVariant),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Right text contents
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isPassed || isCurrent
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.textMuted,
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
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Icon Container
          AppIconBox(
            icon: icon,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            iconColor: theme.colorScheme.primary,
          ),
          const SizedBox(width: 16),
          // Details
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
          // Download icon button
          IconButton(
            icon: const Icon(Icons.download_rounded),
            color: theme.colorScheme.textMuted,
            onPressed: () => controller.downloadDocument(title),
          ),
        ],
      ),
    );
  }
}
