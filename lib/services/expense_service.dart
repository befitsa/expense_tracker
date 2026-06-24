import '../models/expense_model.dart';
import '../ui/common/category_config.dart';
import '../ui/common/ui_helpers.dart';

enum SortOption { newest, oldest, highest, lowest }

class ExpenseService {
  final List<ExpenseModel> _kdExpenses = [];

  // Seed data so the dashboard isn't empty on first run
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
        amount: 0,
        category: CategoryConfig.ksShopping,
        date: now.subtract(const Duration(days: 7)),
      ),
    ]);
  }

  // ==========================
  // CRUD
  // ==========================

  List<ExpenseModel> kfGetAllExpenses() {
    return List.unmodifiable(_kdExpenses);
  }

  ExpenseModel? kfGetExpenseById(String id) {
    try {
      return _kdExpenses.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
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

    if (index == -1) {
      return false;
    }

    _kdExpenses[index] = updated;
    return true;
  }

  bool kfDeleteExpense(String id) {
    final lengthBefore = _kdExpenses.length;

    _kdExpenses.removeWhere((e) => e.id == id);

    return _kdExpenses.length < lengthBefore;
  }

  // ==========================
  // Aggregates
  // ==========================

  double kfGetTotalSpent() {
    return _kdExpenses.fold(
      0.0,
      (sum, expense) => sum + expense.amount,
    );
  }

  double kfGetTotalForCurrentMonth() {
    final now = DateTime.now();

    return _kdExpenses
        .where(
          (expense) => UiHelpers.kfIsSameMonth(
            expense.date,
            now,
          ),
        )
        .fold(
          0.0,
          (sum, expense) => sum + expense.amount,
        );
  }

  /// NEW METHOD ADDED
  double kfGetTotalForLast7Days() {
    final sevenDaysAgo = DateTime.now().subtract(
      const Duration(days: 7),
    );

    return _kdExpenses
        .where(
          (expense) => expense.date.isAfter(
            sevenDaysAgo,
          ),
        )
        .fold(
          0.0,
          (sum, expense) => sum + expense.amount,
        );
  }

  List<ExpenseModel> kfGetRecentExpenses({
    int limit = 5,
  }) {
    final sorted = List<ExpenseModel>.from(_kdExpenses)
      ..sort(
        (a, b) => b.date.compareTo(a.date),
      );

    return sorted.take(limit).toList();
  }

  Map<String, double> kfGetCategoryBreakdown() {
    final Map<String, double> breakdown = {};

    for (final expense in _kdExpenses) {
      breakdown[expense.category] =
          (breakdown[expense.category] ?? 0) + expense.amount;
    }

    return breakdown;
  }

  Map<String, double> kfGetCategoryBreakdownForCurrentMonth() {
    final now = DateTime.now();

    final Map<String, double> breakdown = {};

    for (final expense in _kdExpenses.where(
      (e) => UiHelpers.kfIsSameMonth(
        e.date,
        now,
      ),
    )) {
      breakdown[expense.category] =
          (breakdown[expense.category] ?? 0) + expense.amount;
    }

    return breakdown;
  }

  // ==========================
  // Search / Filter / Sort
  // ==========================

  List<ExpenseModel> kfQueryExpenses({
    String? searchTerm,
    String? category,
    SortOption sort = SortOption.newest,
  }) {
    List<ExpenseModel> result = List.from(
      _kdExpenses,
    );

    if (searchTerm != null && searchTerm.trim().isNotEmpty) {
      final term = searchTerm.toLowerCase();

      result = result.where(
        (expense) {
          return expense.title.toLowerCase().contains(term);
        },
      ).toList();
    }

    if (category != null &&
        category != CategoryConfig.kdCategories.first.name &&
        category.isNotEmpty) {
      result = result.where(
        (expense) {
          return expense.category == category;
        },
      ).toList();
    }

    switch (sort) {
      case SortOption.newest:
        result.sort(
          (a, b) => b.date.compareTo(a.date),
        );
        break;

      case SortOption.oldest:
        result.sort(
          (a, b) => a.date.compareTo(b.date),
        );
        break;

      case SortOption.highest:
        result.sort(
          (a, b) => b.amount.compareTo(a.amount),
        );
        break;

      case SortOption.lowest:
        result.sort(
          (a, b) => a.amount.compareTo(b.amount),
        );
        break;
    }

    return result;
  }
}
