import 'package:Skarbonka/pages/home_page.dart';
import 'package:Skarbonka/pages/plan_configuration_page.dart';
import 'package:Skarbonka/pages/settings_page.dart';
import 'package:flutter/material.dart';

enum AppRoute {
  HOME,
  PLAN_CONFIGURATION,
  SETTINGS
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
  };
}

void navigateTo(BuildContext context, AppRoute route) {
  Navigator.pushNamed(context, route.path);
}