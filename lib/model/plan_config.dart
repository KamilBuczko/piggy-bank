import 'package:json_annotation/json_annotation.dart';

part 'plan_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PlanConfig {
  double monthlyIncome;
  double spareGoal;
  DateTime dateFrom;
  DateTime dateTo;
  List<CyclicExpense> cyclicExpenses;
  List<ExpenseCategory> expenseCategories;

  PlanConfig({this.monthlyIncome, this.spareGoal, this.dateFrom,
      this.dateTo, this.cyclicExpenses, this.expenseCategories});


  factory PlanConfig.fromJson(Map<String, dynamic> json) =>
      _$PlanConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PlanConfigToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CyclicExpense {
  String name;
  double value;
  DateTime dateFrom;
  DateTime dateTo;

  CyclicExpense({this.name, this.value, this.dateFrom, this.dateTo});


  factory CyclicExpense.fromJson(Map<String, dynamic> json) =>
      _$CyclicExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$CyclicExpenseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ExpenseCategory {
  int id;
  String name;
  double limit;

  ExpenseCategory({this.id, this.name, this.limit});


  factory ExpenseCategory.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoryToJson(this);
}