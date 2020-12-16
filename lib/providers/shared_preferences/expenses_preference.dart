import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skarbonka/model/expense.dart';

class ExpensesPreference {
  static const EXPENSES = "EXPENSES";

  setExpenses(List<Expense> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EXPENSES, jsonEncode(value));
  }

  Future<List<Expense>> getExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var expensesString = prefs.getString(EXPENSES) ?? null;

    if (expensesString == null) {
      return [];
    }

    Iterable decodedString = jsonDecode(expensesString);

    return List<dynamic>.from(decodedString)
        .map((model) => Expense.fromJson(model))
        .toList();
  }

  void deleteExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(EXPENSES);
  }
}
