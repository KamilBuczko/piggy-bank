import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData({bool isDarkTheme}) {
    return isDarkTheme
        ? ThemeData(
            brightness: Brightness.dark,
            accentColor: Color(0xFFB37CDB),
            textSelectionHandleColor: Color(0xFFB37CDB),
            indicatorColor: Color(0xFFE6AF2E),
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: Colors.white, ),
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        )
      )
          )
        : ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.purple,
            accentColor: Colors.white,
          );
  }
}
