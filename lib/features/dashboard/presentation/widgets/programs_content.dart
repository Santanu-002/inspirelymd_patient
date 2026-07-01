import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/core/common/widgets/card/app_card.dart';
import 'package:inspirelymd_patient/core/common/widgets/tag/app_tag.dart';
import 'package:inspirelymd_patient/core/common/widgets/icon/app_icon_box.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

class ProgramsContent extends GetView<DashboardController> {
  const ProgramsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = AppStrings.programs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header titles
        Text(
          strings.sectionTitle,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          strings.programTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0D253F), // Dark blue header color
          ),
        ),
        AppUIConstants.widgets.verticalBox$24,

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
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                    textColor: theme.colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              // Thick progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: 0.65,
                  minHeight: 8,
                  backgroundColor: theme.colorScheme.outlineVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ),
              const SizedBox(height: 8),
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
                padding: const EdgeInsets.all(16),
                child: Text(
                  strings.planTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1),

              // Item 1: Take weekly dose
              _buildPlanItem(
                context: context,
                icon: Icons.calendar_today_outlined,
                iconColor: theme.colorScheme.primary,
                iconBg: theme.colorScheme.primary.withValues(alpha: 0.1),
                title: strings.taskDose,
                subtitle: strings.taskDoseSub,
                isCompleted: false,
              ),
              const Divider(height: 1),

              // Item 2: Log weight
              _buildPlanItem(
                context: context,
                icon: Icons.scale_outlined,
                iconColor: const Color(0xFF1E88E5),
                iconBg: const Color(0xFFE3F2FD),
                title: strings.taskWeight,
                subtitle: strings.taskWeightSub,
                isCompleted: false,
              ),
              const Divider(height: 1),

              // Item 3: Managing nausea lesson (Completed)
              _buildPlanItem(
                context: context,
                icon: Icons.auto_awesome,
                iconColor: theme.colorScheme.textMuted,
                iconBg: theme.colorScheme.outlineVariant,
                title: strings.taskLesson,
                subtitle: strings.taskLessonSub,
                isCompleted: true,
              ),
              const Divider(height: 1),

              // Item 4: Hydration goal (Completed)
              _buildPlanItem(
                context: context,
                icon: Icons.water_drop_outlined,
                iconColor: theme.colorScheme.textMuted,
                iconBg: theme.colorScheme.outlineVariant,
                title: strings.taskHydration,
                subtitle: strings.taskHydrationSub,
                isCompleted: true,
              ),
            ],
          ),
        ),
        AppUIConstants.widgets.verticalBox$16,

        // ── Card 3: Care Team Card ───────────────────────────────────────
        AppCard(
          child: Row(
            children: [
              // Initials avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'AR',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 16,
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
                      strings.drAlanaReyes('Dr. Alana Reyes, MD'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      strings.drSpecialty,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              // Care team tag chip
              const AppTag(
                text: 'Care team',
                backgroundColor: Color(0xFFE8F5E9),
                textColor: Color(0xFF2E7D32),
                dotColor: Color(0xFF2E7D32),
              ),
            ],
          ),
        ),
        AppUIConstants.widgets.verticalBox$32,
      ],
    );
  }

  Widget _buildPlanItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required bool isCompleted,
  }) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Icon Container
          AppIconBox(
            icon: icon,
            backgroundColor: iconBg,
            iconColor: iconColor,
          ),
          const SizedBox(width: 16),
          // Text block
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? theme.colorScheme.textMuted : theme.colorScheme.onSurface,
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
          // Circular status checkbox
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? const Color(0xFF2E7D32) : Colors.transparent,
              border: isCompleted
                  ? null
                  : Border.all(
                      color: theme.colorScheme.outlineVariant,
                      width: 2,
                    ),
            ),
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
