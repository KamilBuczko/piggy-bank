import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:skarbonka/utils/number_utils.dart';
import 'package:skarbonka/widgets/indicator.dart';

class BalancePieChart extends StatefulWidget {
  final double spared;
  final double spent;

  BalancePieChart({this.spared, this.spent});

  @override
  State<StatefulWidget> createState() => _BalancePieChartState();
}

class _BalancePieChartState extends State<BalancePieChart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Bilans miesiąca',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  height: 180,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Indicator(
                      color: Colors.red[700],
                      text: 'Wydano',
                      textColor: Colors.white,
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Indicator(
                      color: Colors.green[700],
                      textColor: Colors.white,
                      text: 'Osczędzono',
                      isSquare: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 90 : 80;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red[700],
            value: widget.spent > 0 ? widget.spent : 0,
            title: widget.spent > 0 ? format(widget.spent) : "",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green[700],
            value: widget.spared > 0 ? widget.spared : 0,
            title: widget.spared > 0 ? format(widget.spared) : "",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        default:
          return null;
      }
    });
  }
}