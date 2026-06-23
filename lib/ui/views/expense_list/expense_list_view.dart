import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'expense_list_viewmodel.dart';

class ExpenseListView extends StackedView<ExpenseListViewModel> {
  const ExpenseListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExpenseListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("ExpenseListView")),
      ),
    );
  }

  @override
  ExpenseListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExpenseListViewModel();
}
