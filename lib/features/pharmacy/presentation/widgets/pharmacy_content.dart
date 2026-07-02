import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_icon_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/core/common/widgets/tag/app_tag.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/controllers/pharmacy_controller.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/widgets/pharmacy_document_item.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/widgets/pharmacy_timeline_step.dart';

class PharmacyContent extends GetView<PharmacyController> {
  const PharmacyContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.pharmacy;

    final timelineSteps = [
      {
        'title': strings.planApproved,
        'subtitle': strings.planApprovedSub,
        'isPassed': true,
        'isCurrent': false,
        'isFirst': true,
        'isLast': false,
      },
      {
        'title': strings.paymentCharged,
        'subtitle': strings.paymentChargedSub,
        'isPassed': true,
        'isCurrent': false,
        'isFirst': false,
        'isLast': false,
      },
      {
        'title': strings.sentToPharmacy,
        'subtitle': strings.sentToPharmacySub,
        'isPassed': true,
        'isCurrent': false,
        'isFirst': false,
        'isLast': false,
      },
      {
        'title': strings.preparedFilled,
        'subtitle': strings.preparedFilledSub,
        'isPassed': false,
        'isCurrent': true,
        'isFirst': false,
        'isLast': false,
        'currentIcon': Icons.local_shipping,
        'currentColor': theme.colorScheme.primary,
      },
      {
        'title': strings.shipped,
        'subtitle': strings.shippedSub,
        'isPassed': false,
        'isCurrent': false,
        'isFirst': false,
        'isLast': true,
      },
    ];

    final documents = [
      {
        'title': strings.semaglutideRx,
        'subtitle': strings.semaglutideRxSub,
        'icon': Icons.description_outlined,
      },
      {
        'title': strings.visitSummary,
        'subtitle': strings.visitSummarySub,
        'icon': Icons.description_outlined,
      },
      {
        'title': strings.hormonePanel,
        'subtitle': strings.hormonePanelSub,
        'icon': Icons.description_outlined,
      },
      {
        'title': strings.signedConsents,
        'subtitle': strings.signedConsentsSub,
        'icon': Icons.shield_outlined,
      },
    ];

    return AppScaffold(
      useScrollView: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            strings.rxManagementSubtitle,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.textMuted,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              height: 1.1,
            ),
          ),
          AppUIConstants.widgets.verticalBox$4,
          Text(
            strings.ordersTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              height: 1.1,
            ),
          ),
        ],
      ),
      centerTitle: false,
      titleSpacing: AppUIConstants.spacing.space$16,
      automaticallyImplyLeading: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                    AppTag(
                      text: 'In transit',
                      backgroundColor: theme.colorScheme.inProgress.withValues(
                        alpha: 0.1,
                      ),
                      textColor: theme.colorScheme.inProgress,
                      dotColor: theme.colorScheme.inProgress,
                    ),
                  ],
                ),
                AppUIConstants.widgets.verticalBox$24,

                // Vertical timeline list
                ...timelineSteps.map((step) {
                  return PharmacyTimelineStep(
                    title: step['title'] as String,
                    subtitle: step['subtitle'] as String,
                    isPassed: step['isPassed'] as bool,
                    isCurrent: step['isCurrent'] as bool,
                    isFirst: step['isFirst'] as bool,
                    isLast: step['isLast'] as bool,
                    currentIcon: step['currentIcon'] as IconData?,
                    currentColor: step['currentColor'] as Color?,
                  );
                }),

                AppUIConstants.widgets.verticalBox$24,
                // Reorder button
                AppButton.outlined(
                  text: strings.reorderButton,
                  icon: Icon(
                    Icons.sync_rounded,
                    color: theme.colorScheme.onSurface,
                    size: 20,
                  ),
                  borderColor: theme.colorScheme.outlineVariant,
                  textColor: theme.colorScheme.onSurface,
                  onPressed: () => Get.toNamed(AppRoutes.requestRefill),
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
                  padding: EdgeInsets.all(
                    AppUIConstants.spacing.space$16,
                  ),
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

                ...List.generate(documents.length, (index) {
                  final doc = documents[index];
                  return Column(
                    children: [
                      PharmacyDocumentItem(
                        title: doc['title'] as String,
                        subtitle: doc['subtitle'] as String,
                        icon: doc['icon'] as IconData,
                        onDownload: () => controller.downloadDocument(
                          doc['title'] as String,
                        ),
                      ),
                      if (index < documents.length - 1)
                        const Divider(height: 1),
                    ],
                  );
                }),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$16,

          // ── Title: Recommended for you ───────────────────────────────────
          Text(
            strings.recommendedTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          AppUIConstants.widgets.verticalBox$12,

          // ── Recommendations Card ─────────────────────────────────────────
          AppCard(
            padding: EdgeInsets.zero,
            child: Obx(() {
              return Column(
                children: List.generate(
                  controller.recommendationList.length,
                  (index) {
                    final item = controller.recommendationList[index];
                    final isAdded = item['added'] as bool;

                    IconData itemIcon;
                    Color iconColor;
                    Color iconBg;

                    if (item['id'] == 'tirzepatide') {
                      itemIcon = Icons.local_mall_outlined;
                      iconColor = theme.colorScheme.inProgress;
                      iconBg = theme.colorScheme.inProgress.withValues(
                        alpha: 0.1,
                      );
                    } else if (item['id'] == 'nausea_kit') {
                      itemIcon = Icons.medical_services_outlined;
                      iconColor = theme.colorScheme.completed;
                      iconBg = theme.colorScheme.completed.withValues(
                        alpha: 0.1,
                      );
                    } else {
                      itemIcon = Icons.auto_awesome;
                      iconColor = theme.colorScheme.primary;
                      iconBg = theme.colorScheme.primary.withValues(
                        alpha: 0.1,
                      );
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppUIConstants.spacing.space$16,
                            vertical: AppUIConstants.spacing.space$12,
                          ),
                          child: Row(
                            spacing: AppUIConstants.spacing.space$16,
                            children: [
                              AppIconBox(
                                icon: itemIcon,
                                backgroundColor: iconBg,
                                iconColor: iconColor,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  spacing: AppUIConstants.spacing.space$2,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      item['subtitle'],
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: theme
                                                .colorScheme
                                                .textMuted,
                                          ),
                                    ),
                                  ],
                                ),
                              ),

                              // Dynamic state button
                              if (isAdded)
                                AppIconButton.filled(
                                  icon: Icons.check,
                                  backgroundColor:
                                      theme.colorScheme.completed,
                                  iconColor: theme.colorScheme.onPrimary,
                                  onPressed: null,
                                )
                              else
                                AppButton.outlined(
                                  text: strings.addButton,
                                  backgroundColor: Colors.transparent,
                                  textColor: theme.colorScheme.primary,
                                  borderColor:
                                      theme.colorScheme.outlineVariant,
                                  width: null,
                                  height: 36,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppUIConstants.spacing.space$16,
                                    vertical: AppUIConstants.spacing.space$6,
                                  ),
                                  onPressed: () => controller
                                      .toggleRecommendation(index),
                                ),
                            ],
                          ),
                        ),
                        if (index <
                            controller.recommendationList.length - 1)
                          const Divider(height: 1),
                      ],
                    );
                  },
                ),
              );
            }),
          ),
          AppUIConstants.widgets.verticalBox$32,
        ],
      ),
    );
  }
}
