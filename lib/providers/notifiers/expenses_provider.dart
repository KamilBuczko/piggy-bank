import 'package:flutter/material.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/model/plan_config.dart';
import 'package:skarbonka/providers/shared_preferences/expenses_preference.dart';
import 'package:skarbonka/utils/date_utils.dart';

class ExpensesProvider with ChangeNotifier {
  ExpensesPreference expensesPreference = ExpensesPreference();
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  bool get isEmpty => _expenses.isEmpty;

  bool get isNotEmpty => _expenses.isNotEmpty;

  set expenses(List<Expense> value) {
    _sortByDate(value);
    _expenses = value;
    expensesPreference.setExpenses(value);
    notifyListeners();
  }

  Expense getExpense(int idx) {
    return expenses[idx];
  }

  void setExpense(int idx, Expense expense) {
    _expenses[idx] = expense;
    expenses = _expenses;
  }

  deleteExpenses() {
    _expenses = [];
    expensesPreference.deleteExpenses();
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    expenses = _expenses;
  }

  void deleteExpense(int expenseIdx) {
    _expenses.removeAt(expenseIdx);
    expenses = _expenses;
  }

  void _sortByDate(List<Expense> value) {
    value.sort((b, a) => a.date.compareTo(b.date));
  }

  Map<DateTime, GroupedExpenseData> getExpenseDataDividedByDateRange(
      List<DateTime> dateRange, PlanConfig planConfig) {
    Map<DateTime, GroupedExpenseData> result =
        Map<DateTime, GroupedExpenseData>();

    var planMonthSpan =
        getDatesMonthDiff(planConfig.dateFrom, planConfig.dateTo) + 1;

    _groupExpenses(dateRange, result, planMonthSpan,
        planConfig.spareGoal, planConfig.monthlyIncome);

    return result;
  }

  void _groupExpenses(
      List<DateTime> dateRange,
      Map<DateTime, GroupedExpenseData> result,
      int planMonthSpan,
      double spareGoal,
      double monthlyIncome) {
    var reversedExpenses = _expenses.reversed.toList();

    for (int i = 0, j = 0; i < dateRange.length; ++i) {
      DateTime date = dateRange[i];
      List<IndexedExpense> buffer = [];
      double spent = 0;
      int monthsLeft = planMonthSpan - i;
      bool alreadyAdded = false;

      for (; j < reversedExpenses.length; ++j) {
        Expense ex = reversedExpenses[j];

        if (ex.date.month == date.month && ex.date.year == date.year) {
          buffer.add(ex.toIndexed(reversedExpenses.length - 1 - j));
          spent += ex.value;
        } else {
          spareGoal = _addToResult(
              result, date, buffer, spent, spareGoal, monthlyIncome, monthsLeft);
          alreadyAdded = true;
          break;
        }

        if (j == reversedExpenses.length - 1 && !alreadyAdded) {
          spareGoal = _addToResult(
              result, date, buffer, spent, spareGoal, monthlyIncome, monthsLeft);
          alreadyAdded = true;
        }
      }

      if (j == reversedExpenses.length && !alreadyAdded) {
        spareGoal = _addToResult(
            result, date, buffer, spent, spareGoal, monthlyIncome, monthsLeft);
        alreadyAdded = true;
      }

      if (i == 0 && !alreadyAdded) {
        spareGoal = _addToResult(
            result, date, buffer, spent, spareGoal, monthlyIncome, monthsLeft);
        alreadyAdded = true;
      }
    }
  }

  double _addToResult(
      Map<DateTime, GroupedExpenseData> result,
      DateTime date,
      List<IndexedExpense> buffer,
      double spent,
      double spareGoal,
      double monthlyIncome, int monthsLeft) {


    double spared = monthlyIncome - spent;
    double monthSpareGoal = spareGoal / monthsLeft;
    spareGoal -= spared;


    result.putIfAbsent(
      date,
      () => GroupedExpenseData(
        expenses: buffer.reversed.toList(),
        spent: spent,
        monthlySpareGoal: monthSpareGoal,
        spared: spared,
        date: date
      ),
    );

    return spareGoal < 0 ? 0 : spareGoal;
  }
}
