import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../models/expense_model.dart';
import '../../../services/expense_service.dart';
import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';

class ExpenseFormViewModel extends BaseViewModel {
  final _expenseService = locator<ExpenseService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateDisplayController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String? _editingExpenseId;
  bool get isEditing => _editingExpenseId != null;

  String titleValue = '';
  double? amountValue;
  String selectedCategory = '';
  DateTime selectedDate = DateTime.now();

  // Explicit field-error map instead of generated FormViewModel validators
  final Map<String, String?> _fieldErrors = {
    'title': null,
    'amount': null,
    'category': null,
  };

  String? get titleError => _fieldErrors['title'];
  String? get amountError => _fieldErrors['amount'];
  String? get categoryError => _fieldErrors['category'];

  void kfInit(String? expenseId) {
    dateDisplayController.text = UiHelpers.kfFormatDate(selectedDate);

    if (expenseId != null) {
      final existing = _expenseService.kfGetExpenseById(expenseId);
      if (existing != null) {
        _editingExpenseId = existing.id;
        titleValue = existing.title;
        amountValue = existing.amount;
        selectedCategory = existing.category;
        selectedDate = existing.date;

        titleController.text = existing.title;
        amountController.text = existing.amount.toString();
        dateDisplayController.text = UiHelpers.kfFormatDate(existing.date);
        noteController.text = existing.note ?? '';
      }
    }
    notifyListeners();
  }

  void kfOnTitleChanged(String value) {
    titleValue = value;
    if (_fieldErrors['title'] != null) {
      _fieldErrors['title'] = null;
      notifyListeners();
    }
  }

  void kfOnAmountChanged(String value) {
    amountValue = double.tryParse(value);
    if (_fieldErrors['amount'] != null) {
      _fieldErrors['amount'] = null;
      notifyListeners();
    }
  }

  void kfOnCategorySelected(String category) {
    selectedCategory = category;
    _fieldErrors['category'] = null;
    notifyListeners();
  }

  Future<void> kfPickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      selectedDate = picked;
      dateDisplayController.text = UiHelpers.kfFormatDate(picked);
      notifyListeners();
    }
  }

  bool kfValidate() {
    bool isValid = true;

    if (titleValue.trim().isEmpty) {
      _fieldErrors['title'] = AppStrings.ksValidationTitleRequired;
      isValid = false;
    } else {
      _fieldErrors['title'] = null;
    }

    if (amountController.text.trim().isEmpty) {
      _fieldErrors['amount'] = AppStrings.ksValidationAmountRequired;
      isValid = false;
    } else if (amountValue == null || amountValue! <= 0) {
      _fieldErrors['amount'] = AppStrings.ksValidationAmountInvalid;
      isValid = false;
    } else {
      _fieldErrors['amount'] = null;
    }

    if (selectedCategory.isEmpty) {
      _fieldErrors['category'] = AppStrings.ksValidationCategoryRequired;
      isValid = false;
    } else {
      _fieldErrors['category'] = null;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> kfSubmit() async {
    if (!kfValidate()) return;

    setBusy(true);
    try {
      if (isEditing) {
        final updated = ExpenseModel(
          id: _editingExpenseId!,
          title: titleValue.trim(),
          amount: amountValue!,
          category: selectedCategory,
          date: selectedDate,
          note: noteController.text.trim().isEmpty
              ? null
              : noteController.text.trim(),
        );
        _expenseService.kfUpdateExpense(updated);
        _navigationService.back(result: true);
        await Future.delayed(const Duration(milliseconds: 100));
        _snackbarService.closeSnackbar();
        _snackbarService.showSnackbar(
          message: AppStrings.ksSnackbarExpenseUpdated,
          duration: const Duration(seconds: 2),
        );
      } else {
        _expenseService.kfAddExpense(
          title: titleValue.trim(),
          amount: amountValue!,
          category: selectedCategory,
          date: selectedDate,
          note: noteController.text.trim().isEmpty
              ? null
              : noteController.text.trim(),
        );
        _navigationService.back(result: true);
        await Future.delayed(const Duration(milliseconds: 100));
        _snackbarService.closeSnackbar();
        _snackbarService.showSnackbar(
          message: AppStrings.ksSnackbarExpenseAdded,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      _snackbarService.closeSnackbar();
      _snackbarService.showSnackbar(
        message: AppStrings.ksSnackbarError,
        duration: const Duration(seconds: 2),
      );
    } finally {
      setBusy(false);
    }
  }

  void kfGoBack() {
    _navigationService.back();
  }

  void kfDispose() {
    titleController.dispose();
    amountController.dispose();
    dateDisplayController.dispose();
    noteController.dispose();
  }
}