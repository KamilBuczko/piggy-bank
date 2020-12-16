// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return Expense(
    name: json['name'] as String,
    categoryId: json['category_id'] as int,
    value: (json['value'] as num)?.toDouble(),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'name': instance.name,
      'category_id': instance.categoryId,
      'value': instance.value,
      'date': instance.date?.toIso8601String(),
    };
