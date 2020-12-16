import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

// @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
// class Expenses {
//   List<Expenses> value;
//
//   factory Expenses.fromJson(Map<String, dynamic> json) =>
//       _$ExpensesFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ExpensesToJson(this);
// }

@JsonSerializable(fieldRename: FieldRename.snake)
class Expense {
  String name;
  int categoryId;
  double value;
  DateTime date;

  Expense({this.name, this.categoryId, this.value, this.date});

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  @override
  String toString() {
    return "name: " + name + "category: " + categoryId.toString() + ", value: " + value.toString() + ", date: " + date.toString();
  }

  IndexedExpense toIndexed(int idx) {
    return IndexedExpense(index: idx, name: name, categoryId: categoryId, value: value, date: date);
  }
}

class IndexedExpense {
  int index;
  String name;
  int categoryId;
  double value;
  DateTime date;

  IndexedExpense({this.index, this.name, this.categoryId, this.value, this.date});
}

class GroupedExpenseData {
  List<IndexedExpense> expenses;
  double spent;
  double spared;
  double monthlySpareGoal;
  DateTime date;

  GroupedExpenseData({this.expenses, this.spent, this.spared, this.monthlySpareGoal, this.date});
}
