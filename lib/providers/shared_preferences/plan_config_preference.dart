import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skarbonka/model/plan_config.dart';

class PlanConfigPreference {
  static const PLAN_CONFIG = "PLAN_CONFIG";

  setPlanConfig(PlanConfig value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PLAN_CONFIG, jsonEncode(value));
  }

  Future<PlanConfig> getPlanConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var planConfigString = prefs.getString(PLAN_CONFIG) ?? null;

    if (planConfigString == null) {
      return null;
    }

    return PlanConfig.fromJson(jsonDecode(planConfigString));
  }

  void deletePlanConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PLAN_CONFIG);
  }
}