import 'package:expense_tracker/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:expense_tracker/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:expense_tracker/ui/views/home/home_view.dart';
import 'package:expense_tracker/ui/views/startup/startup_view.dart';
import 'package:expense_tracker/ui/views/dashboard/dashboard_view.dart';
import 'package:expense_tracker/ui/views/expense_detail/expense_detail_view.dart';
import 'package:expense_tracker/ui/views/expense_form/expense_form_view.dart';
import 'package:expense_tracker/ui/views/expense_list/expense_list_view.dart';

import 'package:expense_tracker/services/expense_service.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: ExpenseDetailView),
    MaterialRoute(page: ExpenseFormView),
    MaterialRoute(page: ExpenseListView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService), // ADD THIS
    LazySingleton(classType: ExpenseService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}