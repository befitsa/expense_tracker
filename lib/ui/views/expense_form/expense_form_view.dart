import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'expense_form_viewmodel.dart';

class ExpenseFormView extends StackedView<ExpenseFormViewModel> {
  const ExpenseFormView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExpenseFormViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("ExpenseFormView")),
      ),
    );
  }

  @override
  ExpenseFormViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExpenseFormViewModel();
}
