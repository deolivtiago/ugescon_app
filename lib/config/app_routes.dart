import 'package:flutter/material.dart';

import '../ui/balance_sheet/balance_sheet_page.dart';
import '../ui/coa/coa.dart';
import '../ui/entry/entry.dart';
import '../ui/home/home.dart';
import '../ui/income_statement/income_statement.dart';
import '../ui/journal/journal.dart';
import '../ui/organization/organization.dart';
import '../ui/profile/profile.dart';
import '../ui/signin/signin.dart';
import '../ui/signup/signup.dart';

abstract class AppRoutes {
  static const home = '/';
  static const signUp = '/signup';
  static const signIn = '/signin';
  static const profile = '/profile';
  static const organization = '/organization';
  static const coa = '/coa';
  static const journal = '/journal';
  static const operation = '/journal/new/operation';
  static const operationType = '/journal/new/operation/type';
  static const createEntry = 'journal/create/entry';
  static const editEntry = 'journal/edit/entry';
  static const balanceSheet = '/balance-sheet';
  static const incomeStatement = '/income-statement';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signIn:
        return SignInPage.route(settings);
      case AppRoutes.signUp:
        return SignUpPage.route(settings);
      case AppRoutes.home:
        return HomePage.route(settings);
      case AppRoutes.profile:
        return ProfilePage.route(settings);
      case AppRoutes.organization:
        return OrganizationPage.route(settings);
      case AppRoutes.journal:
        return EntriesPage.route(settings);
      case AppRoutes.coa:
        return CoaPage.route(settings);
      case AppRoutes.createEntry:
        return CreateEntryPage.route(settings);
      case AppRoutes.editEntry:
        return EditEntryPage.route(settings);
      case AppRoutes.operation:
        return OperationPage.route(settings);
      case AppRoutes.operationType:
        return OperationTypePage.route(settings);
      case AppRoutes.balanceSheet:
        return BalanceSheetPage.route(settings);
      case AppRoutes.incomeStatement:
        return IncomeStatementPage.route(settings);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute({String? message}) {
    return MaterialPageRoute(
      builder: (_) => SafeArea(
        child: Scaffold(
          body: Center(
            child: Text(message ?? 'Ocorreu um erro'),
          ),
        ),
      ),
    );
  }
}
