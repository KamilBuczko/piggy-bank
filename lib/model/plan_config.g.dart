// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanConfig _$PlanConfigFromJson(Map<String, dynamic> json) {
  return PlanConfig(
    monthlyIncome: (json['monthly_income'] as num)?.toDouble(),
    spareGoal: (json['spare_goal'] as num)?.toDouble(),
    dateFrom: json['date_from'] == null
        ? null
        : DateTime.parse(json['date_from'] as String),
    dateTo: json['date_to'] == null
        ? null
        : DateTime.parse(json['date_to'] as String),
    cyclicExpenses: (json['cyclic_expenses'] as List)
        ?.map((e) => e == null
            ? null
            : CyclicExpense.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    expenseCategories: (json['expense_categories'] as List)
        ?.map((e) => e == null
            ? null
            : ExpenseCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlanConfigToJson(PlanConfig instance) =>
    <String, dynamic>{
      'monthly_income': instance.monthlyIncome,
      'spare_goal': instance.spareGoal,
      'date_from': instance.dateFrom?.toIso8601String(),
      'date_to': instance.dateTo?.toIso8601String(),
      'cyclic_expenses':
          instance.cyclicExpenses?.map((e) => e?.toJson())?.toList(),
      'expense_categories':
          instance.expenseCategories?.map((e) => e?.toJson())?.toList(),
    };

CyclicExpense _$CyclicExpenseFromJson(Map<String, dynamic> json) {
  return CyclicExpense(
    name: json['name'] as String,
    value: (json['value'] as num)?.toDouble(),
    dateFrom: json['date_from'] == null
        ? null
        : DateTime.parse(json['date_from'] as String),
    dateTo: json['date_to'] == null
        ? null
        : DateTime.parse(json['date_to'] as String),
  );
}

Map<String, dynamic> _$CyclicExpenseToJson(CyclicExpense instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'date_from': instance.dateFrom?.toIso8601String(),
      'date_to': instance.dateTo?.toIso8601String(),
    };

ExpenseCategory _$ExpenseCategoryFromJson(Map<String, dynamic> json) {
  return ExpenseCategory(
    id: json['id'] as int,
    name: json['name'] as String,
    limit: (json['limit'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ExpenseCategoryToJson(ExpenseCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'limit': instance.limit,
    };
