import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/model/plan_config.dart';
import 'package:skarbonka/providers/notifiers/expenses_provider.dart';
import 'package:skarbonka/providers/notifiers/plan_config_provider.dart';

import 'category_limit_bar_chart.dart';
import 'spared_line_chart.dart';

class StatisticsTabView extends StatefulWidget {
  @override
  _StatisticsTabViewState createState() => _StatisticsTabViewState();
}

class _StatisticsTabViewState extends State<StatisticsTabView> {
  PlanConfig _planConfig;
  List<DateTime> _dateRange;
  Map<DateTime, GroupedExpenseData> _groupedExpenseMap;
  Map<int, ExpenseCategory> _categoryMap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Oszczędzona kwota',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SparedLineChart(_groupedExpenseMap, _dateRange),
        SizedBox(
          height: 30,
        ),
        CategoryLimitBarChart(_groupedExpenseMap, _categoryMap)
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    var expenseProvider = Provider.of<ExpensesProvider>(context, listen: false);
    var planConfigProvider =
        Provider.of<PlanConfigProvider>(context, listen: false);

    _planConfig = planConfigProvider.planConfig;
    _categoryMap = planConfigProvider.categoryMap;
    _dateRange = planConfigProvider.getPlanDateRange();
    _groupedExpenseMap = expenseProvider.getExpenseDataDividedByDateRange(
        _dateRange, _planConfig);
  }
}
