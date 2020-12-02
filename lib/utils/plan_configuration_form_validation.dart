import 'package:Skarbonka/model/plan_configuration_form.dart';
import 'package:Skarbonka/utils/date_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final _invalidDateRangeText = "Data końca musi następować po dacie startu";
final _spareGoalOutOfRangeText = "Wartośc zbyt duża dla podanego przychodu i zakresu dat";
final _fieldRequiredText = "Pole jest wymagane";



Function(String) dateRangeValidator(
    {@required TextEditingController dateFromController}) {
  return (String dateTo) {
    DateTime parsedDateFrom = toDateTime(dateFromController.text);
    DateTime parsedDateTo = toDateTime(dateTo);
    
    int monthDiff = _getDatesMonthDiff(parsedDateFrom, parsedDateTo);

    if (monthDiff <= 0) {
      return _invalidDateRangeText;
    }

    return null;
  };
}

Function(String) spareGoalValidator(
    {@required BasicDataFormControllers controllers}) {
  return (String value) {
    String monthlyIncome = controllers.monthlyIncome.text;
    String spareGoal = controllers.spareGoal.text;
    DateTime dateFrom = toDateTime(controllers.dateFrom.text);
    DateTime dateTo = toDateTime(controllers.dateTo.text);
      
    if (spareGoal.isEmpty) {
      return _fieldRequiredText;
    }

    if (monthlyIncome.isEmpty) {
      return null;
    }

   int monthsDiff = _getDatesMonthDiff(dateFrom, dateTo);
    
    if (monthsDiff * int.parse(monthlyIncome) < int.parse(spareGoal)) {
      return _spareGoalOutOfRangeText;
    }
    
    return null;
  };
}


int _getDatesMonthDiff(DateTime dateFrom, DateTime dateTo) {
  int yearDiff = dateTo.year - dateFrom.year;
  int monthDiff = dateTo.month - dateFrom.month + yearDiff * 12;
  
  return monthDiff;
}