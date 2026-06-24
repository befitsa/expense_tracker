import 'package:flutter/material.dart';
import '../../../models/expense_model.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/category_config.dart';
import '../../common/ui_helpers.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback onTap;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final category = CategoryConfig.kfGetCategory(expense.category);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UiHelpers.krad20),
        child: Container(
          padding: const EdgeInsets.all(UiHelpers.ksp16),
          decoration: BoxDecoration(
            color: AppColors.kcSurface,
            borderRadius: BorderRadius.circular(UiHelpers.krad20),
            boxShadow: UiHelpers.kdCardShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: category.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(UiHelpers.krad16),
                ),
                child: Icon(category.icon, color: category.color, size: 22),
              ),
              const SizedBox(width: UiHelpers.ksp12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      style: AppTextStyles.ktsBodyLarge
                          .copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: UiHelpers.ksp4),
                    Text(
                      '${expense.category} • ${UiHelpers.kfFormatDateShort(expense.date)}',
                      style: AppTextStyles.ktsBodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: UiHelpers.ksp8),
              Text(
                '-${UiHelpers.kfFormatCurrency(expense.amount)}',
                style: AppTextStyles.ktsAmountSmall
                    .copyWith(color: AppColors.kcError),
              ),
            ],
          ),
        ),
      ),
    );
  }
}