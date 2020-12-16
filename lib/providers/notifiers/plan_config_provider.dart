import 'package:flutter/material.dart';
import 'package:skarbonka/model/plan_config.dart';
import 'package:skarbonka/providers/shared_preferences/plan_config_preference.dart';
import 'package:skarbonka/utils/app_date_time.dart';
import 'package:skarbonka/utils/date_utils.dart';

class PlanConfigProvider with ChangeNotifier {
  PlanConfigPreference planConfigPreference = PlanConfigPreference();
  PlanConfig _planConfig;
  bool _loaded = false;

  PlanConfig get planConfig => _planConfig;

  bool get isEmpty => _planConfig == null;

  bool get isNotEmpty => !isEmpty;

  bool get loaded => _loaded;

  Map<int, ExpenseCategory> get categoryMap {
    return Map.fromIterable(planConfig.expenseCategories,
        key: (e) => e.id, value: (e) => e);
  }

  set planConfig(PlanConfig value) {
    _planConfig = value;
    planConfigPreference.setPlanConfig(value);
    _loaded = true;
    notifyListeners();
  }

  List<DateTime> getPlanDateRange({tillNow = true}) {
    DateTime dateTo;

    if (tillNow) {
      dateTo = AppDateTime.now().isAfter(_planConfig.dateTo)
          ? _planConfig.dateTo
          : AppDateTime.now();

      if (dateTo.isBefore(_planConfig.dateFrom)) {
        dateTo = _planConfig.dateTo;
      }

    } else {
      dateTo = _planConfig.dateTo;
    }

    return generateRangeInMonths(_planConfig.dateFrom, dateTo);
  }

  deletePlanConfig() {
    _planConfig = null;
    planConfigPreference.deletePlanConfig();
    notifyListeners();
  }
}
