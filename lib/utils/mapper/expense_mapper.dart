import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/model/expense_form.dart';

import '../date_utils.dart';

class ExpenseMapper {
  static Expense toExpense(ExpenseFormControllers controllers) {
    return Expense(
      name: controllers.name.text,
      categoryId: int.parse(controllers.category.text),
      value: double.parse(controllers.value.text),
      date: toExpenseDateTime(controllers.date.text),
    );
  }
}
