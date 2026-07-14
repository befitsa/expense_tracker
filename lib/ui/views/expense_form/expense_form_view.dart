import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/category_config.dart';
import '../../common/ui_helpers.dart';
import '../../components/system/app_back_button.dart';
import '../../components/system/app_button.dart';
import '../../components/system/app_text_field.dart';
import '../../components/search/category_chip.dart';
import 'expense_form_viewmodel.dart';

class ExpenseFormView extends StackedView<ExpenseFormViewModel> {
  final String? expenseId;

  const ExpenseFormView({super.key, this.expenseId});

  @override
  Widget builder(
    BuildContext context,
    ExpenseFormViewModel viewModel,
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
                  Text(
                    viewModel.isEditing
                        ? AppStrings.ksExpenseFormAddTitle
                        : AppStrings.ksExpenseFormAddTitle,
                    style: AppTextStyles.ktsHeading2,
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(UiHelpers.ksp20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    label: AppStrings.ksExpenseFormTitleLabel,
                    hint: AppStrings.ksExpenseFormTitleHint,
                    controller: viewModel.titleController,
                    errorText: viewModel.titleError,
                    onChanged: viewModel.kfOnTitleChanged,
                  ),
                  const SizedBox(height: UiHelpers.ksp20),
                  AppTextField(
                    label: AppStrings.ksExpenseFormAmountLabel,
                    hint: AppStrings.ksExpenseFormAmountHint,
                    controller: viewModel.amountController,
                    errorText: viewModel.amountError,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChanged: viewModel.kfOnAmountChanged,
                  ),
                  const SizedBox(height: UiHelpers.ksp20),
                  Text(AppStrings.ksExpenseFormCategoryLabel,
                      style: AppTextStyles.ktsLabel),
                  const SizedBox(height: UiHelpers.ksp8),
                   Wrap(
                      spacing: UiHelpers.ksp8,
                      runSpacing: UiHelpers.ksp8,
                      children: CategoryConfig.kdCategories.map((cat) {
                        return CategoryChip(
                          label: cat.name,
                          icon: cat.icon,
                          selectedColor: cat.color,
                          isSelected: viewModel.selectedCategory == cat.name,
                          onTap: () => viewModel.kfOnCategorySelected(cat.name),
                        );
                      }).toList(),
                    ),
                    if(viewModel.categoryError != null) ...[
                      const SizedBox(height:UiHelpers.ksp8),
                      Text(
                        viewModel.categoryError!,
                        style: AppTextStyles.ktsCaption
                        .copyWith(color: AppColors.kcError),
                      ),
                    ],
                    const SizedBox(height: UiHelpers.ksp20),
                    AppTextField(
                      label: AppStrings.ksExpenseFormDateLabel, 
                      controller: viewModel.dateDisplayController,
                      readOnly: true,
                      prefixIcon: Icons.calendar_today_rounded,
                      onTap: () => viewModel.kfPickDate(context),
                      ),
                      const SizedBox(height: UiHelpers.ksp20),
                      AppTextField(
                        label: AppStrings.ksExpenseFormNoteLabel,
                        hint: AppStrings.ksExpenseFormNoteHint,
                        controller: viewModel.noteController, 
                        maxLines: 3,
                      ),
                      const SizedBox(height: UiHelpers.ksp32),
                      AppButton(
                        title: viewModel.isEditing
                        ?AppStrings.ksExpenseFormUpdateButton
                        : AppStrings.ksExpenseFormSaveButton,
                        isLoading: viewModel.isBusy,
                        onTap: viewModel.kfSubmit,

                       
                       )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  ExpenseFormViewModel viewModelBuilder(BuildContext context) =>
      ExpenseFormViewModel();

  @override
  void onViewModelReady(ExpenseFormViewModel viewModel) =>
      viewModel.kfInit(expenseId);

  @override
  void onDispose(ExpenseFormViewModel viewModel) => viewModel.kfDispose();
}
