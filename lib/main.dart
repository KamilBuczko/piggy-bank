import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appTitle = "Skarbonka";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
       // theme: ThemeData.dark(),
       // theme: ThemeData.light(),
      theme: ThemeData(brightness: Brightness.dark, accentColor: Colors.purple),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pl', 'PL'),
      ],
      routes: routes(),
    );
  }
}


