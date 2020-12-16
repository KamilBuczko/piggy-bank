import 'package:skarbonka/model/plan_config.dart';

class MockedPlan {
  static PlanConfig build() {
    double monthlyIncome = 5000.0;
    double spareGoal = 6000.0;
    DateTime dateFrom = DateTime(2020, 8, 1);
    DateTime dateTo = DateTime(2020, 11, 30);
    List<CyclicExpense> cyclicExpenses = [
      CyclicExpense(
        value: 1000.0,
        name: "Mieszkanie",
        dateFrom: DateTime(2020, 8, 1),
        dateTo: DateTime(2020, 11, 31),
      ),
      CyclicExpense(
        value: 800.0,
        name: "Catering",
        dateFrom: DateTime(2020, 8, 1),
        dateTo: DateTime(2020, 9, 5),
      ),
      CyclicExpense(
        value: 50.0,
        name: "Karnet na siłownie",
        dateFrom: DateTime(2020, 8, 1),
        dateTo: DateTime(2020, 11, 31),
      ),

    ];
    List<ExpenseCategory> expenseCategories = [
      ExpenseCategory(id: 0, name: "Stały wydatek"),
      ExpenseCategory(id: 1, name: "Ogólne"),
      ExpenseCategory(id: 2, name: "Jedzenie"),
      ExpenseCategory(id: 3, name: "Biżuteria", limit: 200),
      ExpenseCategory(id: 4, name: "Ubrania", limit: 400),
      ExpenseCategory(id: 5, name: "Gry", limit: 200),
    ];

    return PlanConfig(
        monthlyIncome: monthlyIncome,
        spareGoal: spareGoal,
        dateFrom: dateFrom,
        dateTo: dateTo,
        cyclicExpenses: cyclicExpenses,
        expenseCategories: expenseCategories);
  }
}
