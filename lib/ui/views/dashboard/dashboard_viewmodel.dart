import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/expense_model.dart';
import '../../../services/expense_service.dart';

class DashboardViewModel extends BaseViewModel {
  final _expenseService = locator<ExpenseService>();
  final _navigationService = locator<NavigationService>();

  final double monthlyBudget = 1000.0;

  String userName = 'Fitsum';

  double totalSpent = 0;
  double monthlyTotal = 0;
  double weeklyTotal = 0;
  double previousMonthTotal = 0;

  int expenseCount = 0;
  List<ExpenseModel> recentExpenses = [];
  Map<String, double> categoryBreakdown = {};

  double get averageExpense =>
      expenseCount == 0 ? 0 : totalSpent / expenseCount;

  void kfInit() {
    kfLoadData();
  }

  void kfLoadData() {
    final all = _expenseService.kfGetAllExpenses();

    totalSpent = _expenseService.kfGetTotalSpent();
    monthlyTotal = _expenseService.kfGetTotalForCurrentMonth();
    weeklyTotal = _expenseService.kfGetTotalForLast7Days();
    expenseCount = all.length;

    recentExpenses = _expenseService.kfGetRecentExpenses(limit: 5);

    categoryBreakdown =
        _expenseService.kfGetCategoryBreakdownForCurrentMonth();

    final now = DateTime.now();
    final prevMonth = DateTime(now.year, now.month - 1);

    previousMonthTotal = all
        .where((e) =>
            e.date.year == prevMonth.year && e.date.month == prevMonth.month)
        .fold(0.0, (sum, e) => sum + e.amount);

    notifyListeners();
  }

  Future<void> kfRefresh() async {
    kfLoadData();
  }

  Future<void> kfNavigateToAddExpense() async {
    final result = await _navigationService.navigateToExpenseFormView();
    if (result == true) {
      kfLoadData();
    }
  }

  Future<void> kfNavigateToExpenseList() async {
    await _navigationService.navigateToExpenseListView();
  }

  Future<void> kfNavigateToExpenseDetail(String expenseId) async {
    final result = await _navigationService.navigateToExpenseDetailView(
      expenseId: expenseId,
    );
    if (result == true) {
      kfLoadData();
    }
  }
}