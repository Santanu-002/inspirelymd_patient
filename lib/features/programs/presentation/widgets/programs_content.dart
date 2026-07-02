import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/core/common/widgets/tag/app_tag.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/programs/presentation/widgets/program_plan_item.dart';

class ProgramsContent extends StatelessWidget {
  const ProgramsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.programs;

    final planItems = [
      {
        'icon': Icons.calendar_today_outlined,
        'iconColor': theme.colorScheme.primary,
        'iconBg': theme.colorScheme.primary.withValues(alpha: 0.1),
        'title': strings.taskDose,
        'subtitle': strings.taskDoseSub,
        'isCompleted': false,
      },
      {
        'icon': Icons.scale_outlined,
        'iconColor': theme.colorScheme.inProgress,
        'iconBg': theme.colorScheme.inProgress.withValues(alpha: 0.1),
        'title': strings.taskWeight,
        'subtitle': strings.taskWeightSub,
        'isCompleted': false,
      },
      {
        'icon': Icons.auto_awesome,
        'iconColor': theme.colorScheme.textMuted,
        'iconBg': theme.colorScheme.outlineVariant,
        'title': strings.taskLesson,
        'subtitle': strings.taskLessonSub,
        'isCompleted': true,
      },
      {
        'icon': Icons.water_drop_outlined,
        'iconColor': theme.colorScheme.textMuted,
        'iconBg': theme.colorScheme.outlineVariant,
        'title': strings.taskHydration,
        'subtitle': strings.taskHydrationSub,
        'isCompleted': true,
      },
    ];

    return AppScaffold(
      useScrollView: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            strings.sectionTitle,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.textMuted,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              height: 1.1,
            ),
          ),
          AppUIConstants.widgets.verticalBox$4,
          Text(
            strings.programName,
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
          // ── Card 1: Weight Progress ──────────────────────────────────────
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strings.weightProgress,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppTag(
                      text: strings.week4Tag,
                      backgroundColor: theme.colorScheme.primary.withValues(
                        alpha: 0.1,
                      ),
                      textColor: theme.colorScheme.primary,
                    ),
                  ],
                ),
                AppUIConstants.widgets.verticalBox$16,
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                    children: [
                      const TextSpan(text: '198 '),
                      TextSpan(
                        text: 'lb · -14 lb',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                AppUIConstants.widgets.verticalBox$16,
                // Thick progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 8,
                    backgroundColor: theme.colorScheme.outlineVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                  ),
                ),
                AppUIConstants.widgets.verticalBox$8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strings.startWeight,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.textMuted,
                      ),
                    ),
                    Text(
                      strings.goalWeight,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$16,

          // ── Card 2: This week's plan ─────────────────────────────────────
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(AppUIConstants.spacing.space$16),
                  child: Text(
                    strings.planTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),

                ...List.generate(planItems.length, (index) {
                  final item = planItems[index];
                  return Column(
                    children: [
                      ProgramPlanItem(
                        icon: item['icon'] as IconData,
                        iconColor: item['iconColor'] as Color,
                        iconBg: item['iconBg'] as Color,
                        title: item['title'] as String,
                        subtitle: item['subtitle'] as String,
                        isCompleted: item['isCompleted'] as bool,
                      ),
                      if (index < planItems.length - 1) const Divider(height: 1),
                    ],
                  );
                }),
              ],
            ),
          ),
          AppUIConstants.widgets.verticalBox$16,

          // ── Card 3: Care Team Card ───────────────────────────────────────
          AppCard(
            child: Row(
              spacing: AppUIConstants.spacing.space$16,
              children: [
                // Doctor Avatar with green online badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: theme.colorScheme.primary.withValues(
                        alpha: 0.1,
                      ),
                      child: Icon(
                        Icons.medical_services_rounded,
                        color: theme.colorScheme.primary,
                        size: 26,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.completed,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.surface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Doctor info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppUIConstants.spacing.space$2,
                    children: [
                      Text(
                        strings.assignedProvider,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        strings.assignedProviderSub,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                // Care team tag chip
                AppTag(
                  text: 'Care team',
                  backgroundColor: theme.colorScheme.completed.withValues(alpha: 0.1),
                  textColor: theme.colorScheme.completed,
                  dotColor: theme.colorScheme.completed,
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
