import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class BudgetProgressCard extends StatelessWidget {
  final double spent;
  final double budget;

  const BudgetProgressCard({
    super.key,
    required this.spent,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = budget <= 0 ? 0 : (spent / budget).clamp(0, 1);
    final bool isOverBudget = spent > budget;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(UiHelpers.ksp16),
      decoration: BoxDecoration(
        color: AppColors.kcSurface,
        borderRadius: BorderRadius.circular(UiHelpers.krad20),
        boxShadow: UiHelpers.kdCardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(AppStrings.ksDashboardBudget,
                  style: AppTextStyles.ktsHeading3),
              Text(
                '${UiHelpers.kfFormatCurrency(spent)} / ${UiHelpers.kfFormatCurrency(budget)}',
                style: AppTextStyles.ktsBodySmall.copyWith(
                  color: isOverBudget
                      ? AppColors.kcError
                      : AppColors.kcTextSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: UiHelpers.ksp12),
          ClipRRect(
            borderRadius: BorderRadius.circular(UiHelpers.krad12),
            child: LinearProgressIndicator(
              value: progress.toDouble(),
              minHeight: 10,
              backgroundColor: AppColors.kcBackground,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOverBudget ? AppColors.kcError : AppColors.kcSecondary,
              ),
            ),
          ),
          const SizedBox(height: UiHelpers.ksp8),
          Text(
            isOverBudget
                ? 'Over budget by ${UiHelpers.kfFormatCurrency(spent - budget)}'
                : '${UiHelpers.kfFormatCurrency(budget - spent)} remaining',
            style: AppTextStyles.ktsCaption,
          ),
        ],
      ),
    );
  }
}

