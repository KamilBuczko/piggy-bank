import 'package:skarbonka/model/plan_configuration_form.dart';
import 'package:skarbonka/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';

final _invalidDateRangeText = "Data końca musi następować po dacie startu";
final _spareGoalOutOfRangeText = "Wartośc zbyt duża dla podanego przychodu i zakresu dat";
final _fieldRequiredText = "Pole jest wymagane";



Function(String) dateRangeValidator(
    {@required TextEditingController dateFromController}) {
  return (String dateTo) {
    DateTime parsedDateFrom = toDateTime(dateFromController.text);
    DateTime parsedDateTo = toDateTime(dateTo);
    
    int monthDiff = getDatesMonthDiff(parsedDateFrom, parsedDateTo);

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

   int monthsDiff = getDatesMonthDiff(dateFrom, dateTo);
    
    if (monthsDiff * double.parse(monthlyIncome) < double.parse(spareGoal)) {
      return _spareGoalOutOfRangeText;
    }
    
    return null;
  };
}


