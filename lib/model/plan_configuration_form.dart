import 'package:flutter/material.dart';

class PlanFormControllers {
  BasicDataFormControllers basicData = BasicDataFormControllers();
  List<CyclicExpensesFormControllers> cyclicExpenses = [];
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