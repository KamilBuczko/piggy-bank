import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/providers/notifiers/dark_theme_provider.dart';
import 'package:skarbonka/providers/notifiers/expenses_provider.dart';
import 'package:skarbonka/providers/notifiers/plan_config_provider.dart';
import 'package:skarbonka/utils/app_theme.dart';

import 'utils/navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appTitle = "Skarbonka";
  final darkThemeProvider = DarkThemeProvider();
  final planConfigProvider = PlanConfigProvider();
  final expensesProvider = ExpensesProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => darkThemeProvider),
        ChangeNotifierProvider(create: (_) => planConfigProvider),
        ChangeNotifierProvider(create: (_) => expensesProvider),
      ],
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, themeData, Widget child) {
        return MaterialApp(
          title: _appTitle,
          theme: AppTheme.themeData(isDarkTheme: themeData.darkTheme),
          localizationsDelegates: [GlobalMaterialLocalizations.delegate],
          supportedLocales: [Locale('pl', 'PL')],
          routes: routes(),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    getCurrentPlanConfig();
    getCurrentExpenses();
  }

  void getCurrentAppTheme() async {
    darkThemeProvider.darkTheme =
        await darkThemeProvider.darkThemePreference.getTheme();
  }

  void getCurrentPlanConfig() async {
    planConfigProvider.planConfig =
        await planConfigProvider.planConfigPreference.getPlanConfig();
  }

  void getCurrentExpenses() async {
    expensesProvider.expenses =
        await expensesProvider.expensesPreference.getExpenses();
  }
}
