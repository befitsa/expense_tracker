import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_icons.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class QuickAction {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const QuickAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });
}

class QuickActionsRow extends StatelessWidget {
  final VoidCallback onAddExpense;
  final List<QuickAction>? extraActions;

  const QuickActionsRow({
    super.key,
    required this.onAddExpense,
    this.extraActions,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickAction(
        label: AppStrings.ksDashboardAddExpense,
        icon: AppIcons.kiAdd,
        onTap: onAddExpense,
        color: AppColors.kcPrimary,
      ),
      ...(extraActions ?? []),
    ];

    return Row(
      children: actions
          .map(
            (action) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: UiHelpers.ksp4),
                child: _kfActionButton(action),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _kfActionButton(QuickAction action) {
    final color = action.color ?? AppColors.kcPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(UiHelpers.krad24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: UiHelpers.ksp16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(UiHelpers.krad16),
          ),
          child: Column(
            children: [
              Icon(action.icon, color: color, size: 22),
              const SizedBox(height: UiHelpers.ksp8),
              Text(
                action.label,
                style: AppTextStyles.ktsBodySmall
                    .copyWith(color: color, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
