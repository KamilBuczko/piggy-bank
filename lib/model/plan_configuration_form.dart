import 'package:flutter/material.dart';

class PlanFormControllers {
  BasicDataFormControllers basicData = BasicDataFormControllers();
  List<CyclicExpensesFormControllers> cyclicExpenses = [];
  List<ExpenseCategoriesFormControllers> expenseCategories = [];
}

class BasicDataFormControllers {
  TextEditingController monthlyIncome = TextEditingController();
  TextEditingController spareGoal = TextEditingController();
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
}

class CyclicExpensesFormControllers {
  TextEditingController name = TextEditingController();
  TextEditingController value = TextEditingController();
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
}

class ExpenseCategoriesFormControllers {
  TextEditingController name = TextEditingController();
  TextEditingController limit = TextEditingController();
}