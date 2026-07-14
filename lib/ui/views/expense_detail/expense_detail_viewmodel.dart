import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/expense_model.dart';
import '../../../services/expense_service.dart';
import '../../common/app_strings.dart';

class ExpenseDetailViewModel extends BaseViewModel {
  final _expenseService = locator<ExpenseService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();

  String _expenseId = '';
  ExpenseModel? expense;

  void kfInit(String expenseId) {
    _expenseId = expenseId;
    expense = _expenseService.kfGetExpenseById(expenseId);
    notifyListeners();
  }

  void kfNavigateToEdit() async {
    final result = await _navigationService.navigateToExpenseFormView(
      expenseId: _expenseId,
    );
    if (result == true) {
      kfInit(_expenseId);
    }
  }

  Future<void> kfConfirmDelete() async {
    final response = await _dialogService.showDialog(
      title: AppStrings.ksDialogDeleteTitle,
      description: AppStrings.ksDialogDeleteDescription,
      buttonTitle: AppStrings.ksDialogDeleteConfirm,
      cancelTitle: AppStrings.ksDialogDeleteCancel,
    );

    if (response?.confirmed == true) {
      setBusy(true);
      _expenseService.kfDeleteExpense(_expenseId);
      _snackbarService.showSnackbar(
          message: AppStrings.ksSnackbarExpenseDeleted);
      setBusy(false);
      _navigationService.back(result: true);
    }
  }

  void kfGoBack() {
    _navigationService.back();
  }
}