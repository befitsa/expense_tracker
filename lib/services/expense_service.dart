import '../models/expense_model.dart';
import '../ui/common/category_config.dart';
import '../ui/common/ui_helpers.dart';

enum SortOption { newest, oldest, highest, lowest }

class ExpenseService {
  final List<ExpenseModel> _kdExpenses = [];

  ExpenseService() {
    _seedData();
  }

  void _seedData() {
    final now = DateTime.now();

    _kdExpenses.addAll([
      ExpenseModel(
        id: '1',
        title: 'Grocery',
        amount: 3000,
        category: CategoryConfig.ksFood,
        date: now.subtract(const Duration(days: 1)),
      ),
      ExpenseModel(
        id: '2',
        title: 'Ride',
        amount: 500,
        category: CategoryConfig.ksTransport,
        date: now.subtract(const Duration(days: 2)),
      ),
      ExpenseModel(
        id: '3',
        title: 'Electricity Bill',
        amount: 1000,
        category: CategoryConfig.ksEntertainment,
        date: now.subtract(const Duration(days: 3)),
      ),
      ExpenseModel(
        id: '4',
        title: 'Subscription',
        amount: 500,
        category: CategoryConfig.ksBills,
        date: now.subtract(const Duration(days: 5)),
      ),
      ExpenseModel(
        id: '5',
        title: 'Shopping',
        amount: 200,
        category: CategoryConfig.ksShopping,
        date: now.subtract(const Duration(days: 7)),
      ),
    ]);
  }

  List<ExpenseModel> kfGetAllExpenses() {
    return List.unmodifiable(_kdExpenses);
  }

  ExpenseModel? kfGetExpenseById(String id) {
    for (final e in _kdExpenses) {
      if (e.id == id) return e;
    }
    return null;
  }


  ExpenseModel kfAddExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
    String? note,
  }) {
    final expense = ExpenseModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: category,
      date: date,
      note: note,
    );

    _kdExpenses.insert(0, expense);
    return expense;
  }

  bool kfUpdateExpense(ExpenseModel updated) {
    final index = _kdExpenses.indexWhere((e) => e.id == updated.id);

    if (index == -1) return false;

    _kdExpenses[index] = updated;
    return true;
  }

  bool kfDeleteExpense(String id) {
  final before = _kdExpenses.length;

  _kdExpenses.removeWhere((e) => e.id == id);

  return _kdExpenses.length < before;
}

  double kfGetTotalSpent() {
    double total = 0;
    for (final e in _kdExpenses) {
      total += e.amount;
    }
    return total;
  }

  double kfGetTotalForCurrentMonth() {
    final now = DateTime.now();
    double total = 0;

    for (final e in _kdExpenses) {
      if (UiHelpers.kfIsSameMonth(e.date, now)) {
        total += e.amount;
      }
    }

    return total;
  }

  double kfGetTotalForLast7Days() {
    final now = DateTime.now();
    final last7 = now.subtract(const Duration(days: 7));

    double total = 0;

    for (final e in _kdExpenses) {
      if (e.date.isAfter(last7)) {
        total += e.amount;
      }
    }

    return total;
  }

  List<ExpenseModel> kfGetRecentExpenses({int limit = 5}) {
    final list = List<ExpenseModel>.from(_kdExpenses);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list.take(limit).toList();
  }


  Map<String, double> kfGetCategoryBreakdownForCurrentMonth() {
    final now = DateTime.now();
    final Map<String, double> map = {};

    for (final e in _kdExpenses) {
      if (UiHelpers.kfIsSameMonth(e.date, now)) {
        map[e.category] = (map[e.category] ?? 0) + e.amount;
      }
    }

    return map;
  }


  List<ExpenseModel> kfQueryExpenses({
    String? searchTerm,
    String? category,
    SortOption sort = SortOption.newest,
  }) {
    List<ExpenseModel> result = List.from(_kdExpenses);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      final term = searchTerm.toLowerCase();
      result = result
          .where((e) => e.title.toLowerCase().contains(term))
          .toList();
    }

    if (category != null && category.isNotEmpty) {
      result = result.where((e) => e.category == category).toList();
    }

    switch (sort) {
      case SortOption.newest:
        result.sort((a, b) => b.date.compareTo(a.date));
        break;
      case SortOption.oldest:
        result.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortOption.highest:
        result.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case SortOption.lowest:
        result.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }

    return result;
  }
}