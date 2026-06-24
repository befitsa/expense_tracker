import 'package:flutter/material.dart';
import '../../../models/expense_model.dart';
import '../../common/app_strings.dart';
import '../system/empty_state.dart';
import 'dashboard_card.dart';
import 'recent_expense_card.dart';

class RecentExpenseSection extends StatelessWidget {
  final List<ExpenseModel> expenses;
  final VoidCallback onViewAll;
  final void Function(ExpenseModel expense) onExpenseTap;

  const RecentExpenseSection({
    super.key,
    required this.expenses,
    required this.onViewAll,
    required this.onExpenseTap,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: AppStrings.ksDashboardRecentExpenses,
      actionLabel: expenses.isEmpty ? null : AppStrings.ksDashboardViewAll,
      onActionTap: onViewAll,
      child: expenses.isEmpty
          ? const EmptyState(
              title: AppStrings.ksExpenseListEmpty,
              subtitle: AppStrings.ksExpenseListEmptySubtitle,
            )
          : Column(
              children: expenses
                  .map(
                    (e) => RecentExpenseCard(
                      expense: e,
                      onTap: () => onExpenseTap(e),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
