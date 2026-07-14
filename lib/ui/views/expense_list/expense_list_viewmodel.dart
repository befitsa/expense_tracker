import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/expense_model.dart';
import '../../../services/expense_service.dart';
import '../../common/app_strings.dart';

class ExpenseListViewModel extends BaseViewModel {
  final _expenseService = locator<ExpenseService>();
  final _navigationService = locator<NavigationService>();

  final TextEditingController searchController = TextEditingController();

  String searchTerm = '';
  String selectedCategory = AppStrings.ksFilterAll;
  SortOption sortOption = SortOption.newest;

  List<ExpenseModel> filteredExpenses = [];

  void kfInit() {
    kfApplyQuery();
  }

  void kfApplyQuery() {
    filteredExpenses = _expenseService.kfQueryExpenses(
      searchTerm: searchTerm,
      category: selectedCategory,
      sort: sortOption,
    );
    notifyListeners();
  }

  void kfOnSearchChanged(String value) {
    searchTerm = value;
    kfApplyQuery();
  }

  void kfOnCategorySelected(String category) {
    selectedCategory = category;
    kfApplyQuery();
  }

  void kfOnSortChanged(SortOption option) {
    sortOption = option;
    kfApplyQuery();
  }

  void kfNavigateToDetail(String expenseId) async {
    final result = await _navigationService.navigateToExpenseDetailView(
      expenseId: expenseId,
    );
    if (result == true) {
      kfApplyQuery();
    }
  }

  void kfGoBack() {
    _navigationService.back();
  }

  void kfDispose() {
    searchController.dispose();
  }
}
