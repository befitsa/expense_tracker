import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ExpenseDetailViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
