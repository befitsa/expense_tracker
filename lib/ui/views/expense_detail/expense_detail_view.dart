import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_colors.dart';
import '../../common/app_icons.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/category_config.dart';
import '../../common/ui_helpers.dart';
import '../../components/system/app_back_button.dart';
import '../../components/system/app_button.dart';
import '../../components/system/loading_indicator.dart';
import 'expense_detail_viewmodel.dart';

class ExpenseDetailView extends StackedView<ExpenseDetailViewModel> {
  final String expenseId;

  const ExpenseDetailView({super.key, required this.expenseId});

  @override
  Widget builder(
    BuildContext context,
    ExpenseDetailViewModel viewModel,
    Widget? child,
  ) {
    final expense = viewModel.expense;

    return Scaffold(
      backgroundColor: AppColors.kcBackground,
      body: SafeArea(
        child: expense == null
            ? const LoadingIndicator()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      UiHelpers.ksp20,
                      UiHelpers.ksp16,
                      UiHelpers.ksp20,
                      0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBackButton(onTap: viewModel.kfGoBack),
                        const Text(AppStrings.ksExpenseDetailTitle,
                            style: AppTextStyles.ktsHeading3),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(UiHelpers.ksp20),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(UiHelpers.ksp24),
                            decoration: BoxDecoration(
                              gradient: AppColors.kcGradientPrimary,
                              borderRadius:
                                  BorderRadius.circular(UiHelpers.krad24),
                              boxShadow: UiHelpers.kdSoftShadow,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    CategoryConfig.kfGetCategory(
                                            expense.category)
                                        .icon,
                                    color: AppColors.kcTextOnDark,
                                    size: 26,
                                  ),
                                ),
                                const SizedBox(height: UiHelpers.ksp16),
                                Text(
                                  expense.title,
                                  style: AppTextStyles.ktsHeading3
                                      .copyWith(color: AppColors.kcTextOnDark),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: UiHelpers.ksp8),
                                Text(
                                  UiHelpers.kfFormatCurrency(expense.amount),
                                  style: AppTextStyles.ktsAmountLarge,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: UiHelpers.ksp20),
                          _kfDetailRow(
                            icon: CategoryConfig.kfGetCategory(
                                    expense.category)
                                .icon,
                            label: AppStrings.ksExpenseDetailCategory,
                            value: expense.category,
                          ),
                          const SizedBox(height: UiHelpers.ksp12),
                          _kfDetailRow(
                            icon: AppIcons.kiCalendar,
                            label: AppStrings.ksExpenseDetailDate,
                            value: UiHelpers.kfFormatDate(expense.date),
                          ),
                          if (expense.note != null &&
                              expense.note!.isNotEmpty) ...[
                            const SizedBox(height: UiHelpers.ksp12),
                            _kfDetailRow(
                              icon: AppIcons.kiNote,
                              label: AppStrings.ksExpenseDetailNote,
                              value: expense.note!,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(UiHelpers.ksp20),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            title: AppStrings.ksExpenseDetailEdit,
                            variant: AppButtonVariant.secondary,
                            icon: AppIcons.kiEdit,
                            onTap: viewModel.kfNavigateToEdit,
                          ),
                        ),
                        const SizedBox(width: UiHelpers.ksp12),
                        Expanded(
                          child: AppButton(
                            title: AppStrings.ksExpenseDetailDelete,
                            variant: AppButtonVariant.danger,
                            icon: AppIcons.kiDelete,
                            isLoading: viewModel.isBusy,
                            onTap: viewModel.kfConfirmDelete,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _kfDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(UiHelpers.ksp16),
      decoration: BoxDecoration(
        color: AppColors.kcSurface,
        borderRadius: BorderRadius.circular(UiHelpers.krad16),
        boxShadow: UiHelpers.kdCardShadow,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.kcTextSecondary),
          const SizedBox(width: UiHelpers.ksp12),
          Text(label, style: AppTextStyles.ktsLabel),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.ktsBodyMedium
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  ExpenseDetailViewModel viewModelBuilder(BuildContext context) =>
      ExpenseDetailViewModel();

  @override
  void onViewModelReady(ExpenseDetailViewModel viewModel) =>
      viewModel.kfInit(expenseId);
}