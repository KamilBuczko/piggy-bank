import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      theme: ThemeData.dark(),
      locale: Locale('pl', 'PL'),
      routes: routes(),
    );
  }
}


