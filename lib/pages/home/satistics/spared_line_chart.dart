import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/utils/date_utils.dart';
import 'package:skarbonka/utils/number_utils.dart';

class SparedLineChart extends StatefulWidget {
  final Map<DateTime, GroupedExpenseData> expenseMap;
  final List<DateTime> dateRange;

  SparedLineChart(this.expenseMap, this.dateRange);

  @override
  _SparedLineChartState createState() => _SparedLineChartState();
}

class _SparedLineChartState extends State<SparedLineChart> {
  List<Color> gradientColors = [const Color(0xFFB37CDB)];
  List<FlSpot> spots;
  double maxY = 0.0;

  @override
  void initState() {
    super.initState();
    spots = _getSpots();

    if (maxY <= 0.0) {
      maxY = 1000.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.40,
      child: Padding(
        padding:
            const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: maxY/4,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).primaryColorLight,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Theme.of(context).primaryColorLight,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          rotateAngle: 270,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            if (value > 0 && value % 1.0 == 0) {
              return toSparedLine(widget.dateRange[(value.toInt() - 1)]);
            }

            if (value == 0) {
              DateTime date = widget.dateRange[0];
              DateTime resultDate;
              if (date.month != 1) {
                resultDate = DateTime(
                    date.year, date.month - 1, date.day);
              } else {
                resultDate = DateTime(
                    date.year-1, 12, date.day);
              }

              return toSparedLine(resultDate);
            }

            return "";
          },
          margin: 15,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          interval: maxY/4,
          getTitles: (value) {
            bool displayInK = maxY >= 1000.0;
            if (value == 0 ) {
              return "0";
            } else if (value == maxY/4) {
              return displayInK ? formatForChartInK(maxY/4000) +"K" : formatForChart(maxY/4);
            } else if (value == maxY/2) {
              return displayInK ? formatForChartInK(maxY/2000) +"K" : formatForChart(maxY/2);
            } else if (value == 3*maxY/4) {
              return displayInK ? formatForChartInK(3*maxY/4000) +"K" : formatForChart(3*maxY/4);
            } else if (value == maxY) {
              return displayInK ? formatForChartInK(maxY/1000) +"K" : formatForChart(maxY);
            } else {
              return '';
            }
          },
          reservedSize: 45,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border:
              Border.all(color: Theme.of(context).primaryColorLight, width: 1)),
      minX: 0,
      maxX: widget.dateRange.length.toDouble(),
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _getSpots() {
    List<FlSpot> result = [FlSpot(0.0, 0.0)];
    double spared = 0.0;

    for (int i=0; i < widget.dateRange.length; ++i) {
      spared += widget.expenseMap[widget.dateRange[i]].spared;
      maxY = spared > maxY ? spared : maxY;

      double positiveSpared = spared >= 0 ? spared : 0;
      result.add(FlSpot((i+1).toDouble(), double.parse(positiveSpared.toStringAsFixed(2))));
    }

    return result;
  }
}
