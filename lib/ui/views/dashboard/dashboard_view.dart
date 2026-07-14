import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/expense_model.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../components/analytics/category_analytics_card.dart';
import '../../components/home/budget_progress_card.dart';
import '../../components/home/gradient_summary_card.dart';
import '../../components/home/quick_actions_row.dart';
import '../../components/home/recent_expense_section.dart';
import '../../components/home/stat_card.dart';
import '../../common/app_icons.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.kcBackground,
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: viewModel.kfRefresh,
            child: ListView(
              padding: const EdgeInsets.all(UiHelpers.ksp20),
              children: [
                GradientSummaryCard(
                    userName: viewModel.userName,
                    totalSpent: viewModel.totalSpent,
                    monthlySpent: viewModel.monthlyTotal),
                const SizedBox(height: UiHelpers.krad20),
                Row(
                  children: [
                    StatCard(
                      label: 'This WEek',
                      value: UiHelpers.kfFormatCurrency(viewModel.weeklyTotal),
                      icon: AppIcons.kiTrendingDown,
                      iconColor: AppColors.kcSecondary,
                    ),
                    const SizedBox(width: 12),
                    StatCard(
                      label: 'Per Day',
                      value: UiHelpers.kfFormatCurrency(viewModel.weeklyTotal),
                      icon: AppIcons.kiTrendingDown,
                      iconColor: AppColors.kcSecondary,
                    ),
                  ],
                ),
                const SizedBox(height: UiHelpers.ksp24),
                QuickActionsRow(onAddExpense: viewModel.kfNavigateToAddExpense),
                const SizedBox(height: UiHelpers.ksp20),
                BudgetProgressCard(
                    spent: viewModel.monthlyTotal,
                    budget: viewModel.monthlyTotal),
                const SizedBox(height: UiHelpers.ksp20),
                CategoryAnalyticsCard(breakdown: viewModel.categoryBreakdown),
                const SizedBox(height: UiHelpers.krad20),
                RecentExpenseSection(
                  expenses: viewModel.recentExpenses,
                  onViewAll: viewModel.kfNavigateToExpenseList,
                  onExpenseTap: (ExpenseModel e) =>
                      viewModel.kfNavigateToExpenseDetail(e.id),
                ),
                const SizedBox(height: UiHelpers.ksp20)
              ],
            )),
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboardViewModel();
}
