import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';
import '../../components/expense/expense_card.dart';
import '../../components/search/filter_chips_row.dart';
import '../../components/search/search_bar.dart';
import '../../components/search/sort_dropdown.dart';
import '../../components/system/app_back_button.dart';
import '../../components/system/empty_state.dart';
import 'expense_list_viewmodel.dart';

class ExpenseListView extends StackedView<ExpenseListViewModel> {
  const ExpenseListView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ExpenseListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.kcBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                UiHelpers.ksp20,
                UiHelpers.ksp16,
                UiHelpers.ksp20,
                0,
              ),
              child: Row(
                children: [
                  AppBackButton(onTap: viewModel.kfGoBack),
                  const SizedBox(width: UiHelpers.ksp12),
                  const Text(
                    AppStrings.ksExpenseListTitle,
                    style: AppTextStyles.ktsHeading2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(UiHelpers.ksp20),
              child: Column(
                children: [
                  AppSearchBar(
                    controller: viewModel.searchController,
                    onChanged: viewModel.kfOnSearchChanged,
                  ),
                  const SizedBox(height: UiHelpers.ksp16),
                  Row(
                    children: [
                      Expanded(
                        child: FilterChipsRow(
                          selectedCategory: viewModel.selectedCategory,
                          onCategorySelected: viewModel.kfOnCategorySelected,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UiHelpers.ksp12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${viewModel.filteredExpenses.length} expenses',
                        style: AppTextStyles.ktsBodySmall,
                      ),
                      SortDropdown(
                        selected: viewModel.sortOption,
                        onChanged: viewModel.kfOnSortChanged,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: viewModel.filteredExpenses.isEmpty
                  ? const EmptyState(
                      title: AppStrings.ksExpenseListEmpty,
                      subtitle: AppStrings.ksExpenseListEmptySubtitle,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        UiHelpers.ksp20,
                        0,
                        UiHelpers.ksp20,
                        UiHelpers.ksp20,
                      ),
                      itemCount: viewModel.filteredExpenses.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: UiHelpers.ksp12),
                      itemBuilder: (context, index) {
                        final expense = viewModel.filteredExpenses[index];
                        return ExpenseCard(
                          expense: expense,
                          onTap: () => viewModel.kfNavigateToDetail(expense.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ExpenseListViewModel viewModelBuilder(BuildContext context) =>
      ExpenseListViewModel();

  @override
  void onViewModelReady(ExpenseListViewModel viewModel) => viewModel.kfInit();

  @override
  void onDispose(ExpenseListViewModel viewModel) => viewModel.kfDispose();
}
