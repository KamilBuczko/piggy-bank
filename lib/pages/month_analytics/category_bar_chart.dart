import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/model/plan_config.dart';
import 'package:skarbonka/utils/number_utils.dart';
import 'package:skarbonka/widgets/indicator.dart';

class CategoryBarChart extends StatefulWidget {
  final GroupedExpenseData monthData;
  final Map<int, ExpenseCategory> categoryMap;

  CategoryBarChart({this.monthData, this.categoryMap});

  @override
  State<StatefulWidget> createState() => _CategoryBarChartState();
}

class _CategoryBarChartState extends State<CategoryBarChart> {
  final Color leftBarColor = Colors.red[700];
  final Color rightBarColor = Color(0xFFB37CDB);
  final double width = 7;

  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;
  double maxValue;
  double grossSpace;

  @override
  void initState() {
    super.initState();
    showingBarGroups = _groupExpensesByCategory();
    grossSpace = showingBarGroups.length >= 6 ? 120/showingBarGroups.length : 20;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'Wydatki względem kategorii',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Indicator(
                  color: Colors.red[700],
                  text: "Limit",
                  isSquare: true,
                  textColor: Colors.white,
                ),
                SizedBox(width: 20,),
                Indicator(
                  color: Theme.of(context).accentColor,
                  text: "Wydano",
                  isSquare: true,
                  textColor: Colors.white,
                )
              ],
            ),
            SizedBox(
              height: 15,
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
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                  format(rod.y),
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
                            color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                        margin: 32,
                        reservedSize: 14,
                        interval: maxValue/4,
                        getTitles: (value) {
                          bool displayInK = maxValue >= 1000.0;
                          if (value == 0 ) {
                            return "0";
                          } else if (value == maxValue/4) {
                            return displayInK ? formatForChartInK(maxValue/4000) +"K" : formatForChart(maxValue/4);
                          } else if (value == maxValue/2) {
                            return displayInK ? formatForChartInK(maxValue/2000) +"K" : formatForChart(maxValue/2);
                          } else if (value == 3*maxValue/4) {
                            return displayInK ? formatForChartInK(3*maxValue/4000) +"K" : formatForChart(3*maxValue/4);
                          } else if (value == maxValue) {
                            return displayInK ? formatForChartInK(maxValue/1000) +"K" : formatForChart(maxValue);
                          } else {
                            return '';
                          }
                        },
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      horizontalInterval: maxValue/4,
                      getDrawingHorizontalLine: (value)  {
                        var primaryColorLight = Theme.of(context).primaryColorLight;

                        if (value == maxValue/4) {
                          return FlLine(color: primaryColorLight, strokeWidth: 1);
                        } else if (value == maxValue/2) {
                          return FlLine(color: primaryColorLight, strokeWidth: 1);
                        } else if (value == 3*maxValue/4) {
                          return FlLine(color: primaryColorLight, strokeWidth: 1);
                        } else {
                          return FlLine(color: Colors.transparent);
                        }
                      },
                    ),
                    borderData: FlBorderData(
                        show: true,
                        border:
                        Border.symmetric(horizontal: BorderSide(color: Theme.of(context).primaryColorLight, width: 1))),
                    barGroups: showingBarGroups,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 2, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  List<BarChartGroupData> _groupExpensesByCategory() {
    Map<int, double> categoryValuesMap = Map<int, double>();
    maxValue = 0;

    widget.categoryMap.keys.forEach((e) => categoryValuesMap[e] = 0.0);

    widget.monthData.expenses.forEach((e) =>
        categoryValuesMap.update(e.categoryId, (value) => value + e.value));

    categoryValuesMap.entries.forEach((e) {
      maxValue = e.value > maxValue ? e.value : maxValue;
    });

    categoryValuesMap.removeWhere((key, value) => value == 0.0);

    return categoryValuesMap.entries.map((e) {
        return makeGroupData(
            e.key, widget.categoryMap[e.key].limit ?? 0, e.value);
    }).toList();
  }
}
