import 'package:skarbonka/model/plan_config.dart';
import 'package:skarbonka/model/plan_configuration_form.dart';

import '../date_utils.dart';

class PlanConfigMapper {
  static PlanConfig toPlanConfig(PlanFormControllers controllers) {
    var basicData = controllers.basicData;

    return PlanConfig(
      monthlyIncome: double.parse(basicData.monthlyIncome.text),
      spareGoal: double.parse(basicData.spareGoal.text),
      dateFrom: toDateTime(basicData.dateFrom.text),
      dateTo: setDayAsLast(toDateTime(basicData.dateTo.text)),
      cyclicExpenses: toCyclicExpenseList(controllers.cyclicExpenses),
      expenseCategories: toExpenseCategoryList(controllers.expenseCategories),
    );
  }

  static List<CyclicExpense> toCyclicExpenseList(List cyclicExpenses) {
    return cyclicExpenses.map((e) => toCyclicExpense(e)).toList();
  }

  static List<ExpenseCategory> toExpenseCategoryList(List expenseCategories) {
    var customExpenseslist = List.generate(expenseCategories.length,
        (i) => toExpenseCategory(i + 2, expenseCategories[i]));

    List<ExpenseCategory> result = [
      ExpenseCategory(id: 0, name: "Stały wydatek"),
      ExpenseCategory(id: 1, name: "Ogólne")
    ];

    result.addAll(customExpenseslist);

    return result;
  }

  static CyclicExpense toCyclicExpense(
      CyclicExpensesFormControllers cyclicExpense) {
    return CyclicExpense(
      name: cyclicExpense.name.text,
      value: double.parse(cyclicExpense.value.text),
      dateFrom: toDateTime(cyclicExpense.dateFrom.text),
      dateTo: toDateTime(cyclicExpense.dateTo.text),
    );
  }

  static ExpenseCategory toExpenseCategory(
      int id, ExpenseCategoriesFormControllers expenseCategory) {
    return ExpenseCategory(
      id: id,
      name: expenseCategory.name.text,
      limit: expenseCategory.limit.text.isNotEmpty
          ? double.parse(expenseCategory.limit.text)
          : null,
    );
  }
}
