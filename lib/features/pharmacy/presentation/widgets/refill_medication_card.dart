import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class RefillMedicationCard extends StatelessWidget {
  const RefillMedicationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AppCard(
      padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
      child: Row(
        spacing: AppUIConstants.spacing.space$16,
        children: [
          // Left Icon Box using theme primary color tokens
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppUIConstants.radius.md),
            ),
            child: Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),

          // Right details text adhering to Theme TextStyles & Column spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: AppUIConstants.spacing.space$4,
              children: [
                Text(
                  AppStrings.pharmacy.semaglutideMedication,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  AppStrings.pharmacy.semaglutideDosageAndPrice,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
