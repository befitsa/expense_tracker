import 'package:flutter/material.dart';
import '../../../models/expense_model.dart';
import '../../common/app_text_styles.dart';
import '../../common/category_config.dart';
import '../../common/ui_helpers.dart';

class RecentExpenseCard extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback onTap;

  const RecentExpenseCard({
    super.key,
    required this.expense,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final category = CategoryConfig.kfGetCategory(expense.category);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(UiHelpers.krad16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: UiHelpers.ksp8),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(UiHelpers.krad12),
              ),
              child: Icon(category.icon, color: category.color, size: 20),
            ),
            const SizedBox(width: UiHelpers.ksp12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: AppTextStyles.ktsBodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    UiHelpers.kfFormatDateShort(expense.date),
                    style: AppTextStyles.ktsCaption,
                  ),
                ],
              ),
            ),
            Text(
              '-${UiHelpers.kfFormatCurrency(expense.amount)}',
              style: AppTextStyles.ktsBodyMedium
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
