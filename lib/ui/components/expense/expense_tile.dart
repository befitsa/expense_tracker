import 'package:flutter/material.dart';
import '../../../models/expense_model.dart';
import '../../common/app_text_styles.dart';
import '../../common/category_config.dart';
import '../../common/ui_helpers.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback? onTap;

  const ExpenseTile({
    super.key,
    required this.expense,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final category = CategoryConfig.kfGetCategory(expense.category);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(UiHelpers.krad12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: UiHelpers.ksp8,
          horizontal: UiHelpers.ksp4,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(category.icon, color: category.color, size: 18),
            ),
            const SizedBox(width: UiHelpers.ksp12),
            Expanded(
              child: Text(
                expense.title,
                style: AppTextStyles.ktsBodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              UiHelpers.kfFormatCurrency(expense.amount),
              style: AppTextStyles.ktsBodyMedium
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}