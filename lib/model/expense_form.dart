import 'package:flutter/material.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/utils/date_utils.dart';

class ExpenseFormControllers {
  TextEditingController name = TextEditingController();
  TextEditingController value = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController category = TextEditingController(text: '1');

  void update(Expense expense) {
    name.text = expense.name;
    value.text = expense.value.toString();
    date.text = toExpenseDateTimeString(expense.date);
    category.text = expense.categoryId.toString();
  }
}
