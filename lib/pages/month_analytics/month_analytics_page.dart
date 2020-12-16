import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/providers/notifiers/plan_config_provider.dart';
import 'package:skarbonka/utils/date_utils.dart';

import 'balance_pie_chart.dart';
import 'category_bar_chart.dart';

class MonthAnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GroupedExpenseData monthData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            toMonth(monthData.date).toUpperCase() +
                " " +
                toYear(monthData.date),
          ),
        ),
        body: MonthAnalyticsBody(monthData: monthData));
  }
}

class MonthAnalyticsBody extends StatelessWidget {
  final GroupedExpenseData monthData;

  MonthAnalyticsBody({this.monthData});

  @override
  Widget build(BuildContext context) {
    var planConfigProvider = Provider.of<PlanConfigProvider>(context, listen: false);

    return ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        BalancePieChart(
          spared: monthData.spared,
          spent: monthData.spent,
        ),
        SizedBox(
          height: 20,
        ),
        Visibility(
          visible: monthData.expenses.isNotEmpty,
          child: CategoryBarChart(
            monthData: monthData,
              categoryMap: planConfigProvider.categoryMap
          ),
        ),
      ],
    );
  }
}
