import 'package:skarbonka/pages/expense/expense_page.dart';
import 'package:skarbonka/pages/home/home_page.dart';
import 'package:skarbonka/pages/month_analytics/month_analytics_page.dart';
import 'package:skarbonka/pages/plan_config/plan_configuration_page.dart';
import 'package:skarbonka/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:skarbonka/pages/view_expense/view_expense_page.dart';

enum AppRoute {
  HOME,
  PLAN_CONFIGURATION,
  SETTINGS,
  EXPENSE,
  VIEW_EXPENSE,
  MONTH_ANALYTICS
}

extension AppRouteExtension on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.HOME:
        return "/";
        break;
      case AppRoute.PLAN_CONFIGURATION:
        return "/plan/configuration";
        break;
      case AppRoute.SETTINGS:
        return "/settings";
        break;
      case AppRoute.EXPENSE:
        return "/expense";
        break;
      case AppRoute.VIEW_EXPENSE:
        return "/view/expense";
        break;
      case AppRoute.MONTH_ANALYTICS:
        return "/month/analytics";
        break;
      default:
        return "/";
    }
  }
}

Map<String, WidgetBuilder> routes() {
  return {
    AppRoute.HOME.path: (context) => HomePage(),
    AppRoute.PLAN_CONFIGURATION.path: (context) => PlanConfigurationPage(),
    AppRoute.SETTINGS.path: (context) => SettingsPage(),
    AppRoute.EXPENSE.path: (context) => ExpensePage(),
    AppRoute.MONTH_ANALYTICS.path: (context) => MonthAnalyticsPage(),
    AppRoute.VIEW_EXPENSE.path: (context) => ViewExpensePage(),
  };
}

void navigateTo(BuildContext context, AppRoute route, {
  Object arguments,
}) {
  Navigator.pushNamed(context, route.path, arguments: arguments);
}

void navigateBack(BuildContext context, {count = 1}) {
  int i = 0;
  Navigator.popUntil(context, (_) => i++ >= count);
}

void navigateWithReplacement(BuildContext context, AppRoute route) {
  Navigator.of(context).pushReplacementNamed(route.path);
}