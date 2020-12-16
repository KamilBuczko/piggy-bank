import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/model/plan_config.dart';
import 'package:skarbonka/utils/number_utils.dart';

class CategoryLimitBarChart extends StatefulWidget {
  final Map<DateTime, GroupedExpenseData> data;
  final Map<int, ExpenseCategory> categoryMap;

  CategoryLimitBarChart(this.data, this.categoryMap);

  @override
  State<StatefulWidget> createState() => _CategoryLimitBarChartState();
}

class _CategoryLimitBarChartState extends State<CategoryLimitBarChart> {
  final Color barColor = Color(0xFFB37CDB);
  final double width = 7;

  List<BarChartGroupData> showingBarGroups;

  int maxValue;
  double grossSpace;

  @override
  void initState() {
    super.initState();
    showingBarGroups = _groupCategoryLimits();
    grossSpace =
        showingBarGroups.length >= 6 ? 120 / showingBarGroups.length : 20;
  }

  @override
  Widget build(BuildContext context) {
    return maxValue > 0
        ? AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Przekroczenia limitów kategorii',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        BarChartData(
                          groupsSpace: grossSpace,
                          alignment: BarChartAlignment.center,
                          barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.white,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                        formatForChart(rod.y),
                                        TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold));
                                  })),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                                showTitles: true,
                                rotateAngle: 275,
                                margin: 30,
                                getTextStyles: (value) => TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                getTitles: (double value) {
                                  String name =
                                      widget.categoryMap[value.toInt()].name;
                                  return name.length > 15
                                      ? name.substring(0, 14) + "..."
                                      : name;
                                }),
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                  color: Color(0xff7589a2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              margin: 32,
                              reservedSize: 14,
                              interval: maxValue / 4,
                              getTitles: (value) {
                                if (value == 0) {
                                  return "0";
                                } else if (value == maxValue / 4) {
                                  return formatForChartInK(maxValue / 4);
                                } else if (value == maxValue / 2) {
                                  return formatForChartInK(maxValue / 2)
                                      .toString();
                                } else if (value == 3 * maxValue / 4) {
                                  return formatForChartInK(3 * maxValue / 4)
                                      .toString();
                                } else if (value == maxValue) {
                                  return formatForChartInK(maxValue.toDouble());
                                } else {
                                  return '';
                                }
                              },
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            horizontalInterval: maxValue / 4,
                            getDrawingHorizontalLine: (value) {
                              var primaryColorLight =
                                  Theme.of(context).primaryColorLight;
                              if (value == maxValue / 4) {
                                return FlLine(
                                    color: primaryColorLight, strokeWidth: 1);
                              } else if (value == maxValue / 2) {
                                return FlLine(
                                    color: primaryColorLight, strokeWidth: 1);
                              } else if (value == 3 * maxValue / 4) {
                                return FlLine(
                                    color: primaryColorLight, strokeWidth: 1);
                              } else {
                                return FlLine(color: Colors.transparent);
                              }
                            },
                          ),
                          borderData: FlBorderData(
                              show: true,
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      width: 1))),
                          barGroups: showingBarGroups,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(barsSpace: 2, x: x, barRods: [
      BarChartRodData(
        y: y,
        colors: [barColor],
        width: width,
      ),
    ]);
  }

  List<BarChartGroupData> _groupCategoryLimits() {
    Map<int, int> categoryValuesMap = Map<int, int>();
    maxValue = 0;

    widget.categoryMap.keys.forEach((e) => categoryValuesMap[e] = 0);

    widget.data.values.forEach((GroupedExpenseData exp) {
      Map<int, double> monthSummary = _groupExpensesByCategory(exp);
      monthSummary.entries.forEach((e) {
        if (widget.categoryMap[e.key].limit != null &&
            (e.value > widget.categoryMap[e.key].limit)) {
          categoryValuesMap.update(e.key, (value) => value += 1);
        }
      });
    });

    categoryValuesMap.values.forEach((val) {
      maxValue = val > maxValue ? val : maxValue;
    });

    categoryValuesMap.removeWhere((key, value) => value == 0);

    return categoryValuesMap.entries.map((e) {
      return makeGroupData(e.key, e.value.toDouble());
    }).toList();
  }

  Map<int, double> _groupExpensesByCategory(GroupedExpenseData monthData) {
    Map<int, double> categoryValuesMap = Map<int, double>();

    widget.categoryMap.keys.forEach((e) => categoryValuesMap[e] = 0.0);

    monthData.expenses.forEach((e) =>
        categoryValuesMap.update(e.categoryId, (value) => value + e.value));

    categoryValuesMap.removeWhere((key, value) => value == 0.0);

    return categoryValuesMap;
  }
}
