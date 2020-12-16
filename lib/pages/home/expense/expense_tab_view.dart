import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/model/plan_config.dart';
import 'package:skarbonka/pages/home/expense/expense_tab_bottom_bar.dart';
import 'package:skarbonka/providers/notifiers/expenses_provider.dart';
import 'package:skarbonka/providers/notifiers/plan_config_provider.dart';
import 'package:skarbonka/utils/app_date_time.dart';
import 'package:skarbonka/utils/date_utils.dart';
import 'package:skarbonka/utils/navigation.dart';
import 'package:skarbonka/utils/number_utils.dart';

class ExpenseTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PlanConfigProvider, ExpensesProvider>(builder:
        (BuildContext context, planConfigProvider, expensesProvider,
            Widget child) {
      var planDateRange = planConfigProvider.getPlanDateRange();
      var planConfig = planConfigProvider.planConfig;
      var expenseDataMap = expensesProvider.getExpenseDataDividedByDateRange(
          planDateRange, planConfig);
      var planStarted = planConfig.dateFrom.isBefore(AppDateTime.now());
      return Scaffold(
        body: planStarted
            ? expensesProvider.isNotEmpty
                ? ExpenseTabBody(
                    categoryMap: planConfigProvider.categoryMap,
                    planConfig: planConfig,
                    dateRange: planDateRange,
                    expenseDataMap: expenseDataMap,
                  )
                : EmptyExpenseBody()
            : NotStartedBody(planConfig.dateFrom),
        bottomNavigationBar: Visibility(
          visible: planStarted,
          child: ExpenseTabBottomBar(
            monthlyBalance: expensesProvider.isNotEmpty &&
                    getDatesMonthDiff(AppDateTime.now(), planConfig.dateTo) >= 0
                ? _getMonthlyBalance(
                    expenseDataMap[planDateRange.last], planConfig)
                : 0.0,
            totalSpareAmount: expensesProvider.isNotEmpty
                ? _getTotalSpareAmount(expenseDataMap, planDateRange)
                : 0.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: planStarted,
          child: FloatingActionButton(
            onPressed: () => navigateTo(context, AppRoute.EXPENSE),
            child: Icon(Icons.add),
          ),
        ),
      );
    });
  }

  _getMonthlyBalance(GroupedExpenseData expenseData, PlanConfig planConfig) {
    return planConfig.monthlyIncome -
        expenseData.spent -
        expenseData.monthlySpareGoal;
  }

  _getTotalSpareAmount(Map<DateTime, GroupedExpenseData> expenseDataMap,
      List<DateTime> planDateRange) {
    double result = 0;
    for (int i = planDateRange.length - 2; i >= 0; --i) {
      result += expenseDataMap[planDateRange[i]].spared;
    }

    if (getDatesMonthDiff(AppDateTime.now(), planDateRange.last) < 0) {
      result += expenseDataMap[planDateRange.last].spared;
    }
    return result;
  }
}

class ExpenseTabBody extends StatefulWidget {
  final Map<int, ExpenseCategory> categoryMap;
  final PlanConfig planConfig;
  final Map<DateTime, GroupedExpenseData> expenseDataMap;
  final List<DateTime> dateRange;

  ExpenseTabBody(
      {this.categoryMap, this.planConfig, this.expenseDataMap, this.dateRange});

  @override
  _ExpenseTabBodyState createState() => _ExpenseTabBodyState();
}

class _ExpenseTabBodyState extends State<ExpenseTabBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.transparent, Colors.black],
            stops: [0.0, 0.9, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: ListView(
          children: _buildListTiles(),
        ),
      ),
    );
  }

  _buildListTiles() {
    bool rangeInSingleYear =
        isSameYear(widget.dateRange.first, widget.dateRange.last);
    bool rangeInSingleMonth = widget.dateRange.length == 1;

    List<Widget> listTiles = [];

    for (int i = widget.dateRange.length - 1; i >= 0; --i) {
      DateTime date = widget.dateRange[i];
      GroupedExpenseData groupedExpenseData = widget.expenseDataMap[date];

      if (!rangeInSingleMonth) {
        if (!rangeInSingleYear && date.month == 12) {
          _addYearTile(date, listTiles);
        }

        _addMonthTile(listTiles, date, groupedExpenseData);
      } else {
        listTiles.add(CustomDivider(
          first: true,
        ));
      }

      _addExpensesToList(groupedExpenseData.expenses, listTiles);
    }

    listTiles.removeLast();
    listTiles.addAll([
      CustomDivider(last: true),
      Container(
        child: SizedBox(height: 40.0),
        color: Theme.of(context).canvasColor,
      )
    ]);

    return listTiles;
  }

  void _addMonthTile(List<Widget> listTiles, DateTime date,
      GroupedExpenseData groupedExpenseData) {
    listTiles.add(MonthTile(
      month: toMonth(date),
      spared: groupedExpenseData.spared,
      first:
          listTiles.isEmpty && getDatesMonthDiff(date, AppDateTime.now()) == 0,
      onAnalyticsTap: () => navigateTo(
        context,
        AppRoute.MONTH_ANALYTICS,
        arguments: groupedExpenseData,
      ),
    ));
    listTiles.add(CustomDivider(first: true));
  }

  void _addYearTile(DateTime date, List<Widget> listTiles) {
    listTiles.add(YearTile(year: toYear(date)));
    listTiles.add(CustomDivider(
      isYearDivider: true,
    ));
  }

  _addExpensesToList(List<IndexedExpense> expenses, List list) {
    if (expenses != null && expenses.isNotEmpty) {
      var expenseTiles = List.generate(
          expenses.length * 2,
          (index) => index.isEven
              ? ExpenseTile(
                  onTap: () => navigateTo(context, AppRoute.VIEW_EXPENSE,
                      arguments: expenses[index ~/ 2].index.toString()),
                  name: expenses[index ~/ 2].name,
                  value: expenses[index ~/ 2].value,
                  date: expenses[index ~/ 2].date,
                  category:
                      widget.categoryMap[expenses[index ~/ 2].categoryId].name)
              : CustomDivider(last: index == expenses.length * 2 - 1));

      list.addAll(expenseTiles);
    } else {
      list.addAll(<Widget>[
        NoDataTile(),
        CustomDivider(last: true),
      ]);
    }
  }
}

class ExpenseTile extends StatelessWidget {
  final String name;
  final String category;
  final double value;
  final DateTime date;
  final VoidCallback onTap;

  final upperRowFontSize = 18.0;
  final lowerRowFontSize = 13.0;

  ExpenseTile({this.name, this.category, this.value, this.date, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap.call(),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: category == "Stały wydatek"
                              ? Color(0xFF726573)
                              : Theme.of(context).accentColor,
                          fontSize: upperRowFontSize),
                    ),
                  ),
                  Text(
                    format(value) + " zł",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: category == "Stały wydatek"
                            ? Color(0xFF726873)
                            : Theme.of(context).accentColor,
                        fontSize: upperRowFontSize),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    category,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: lowerRowFontSize),
                  ),
                  Text(
                    toDayMonth(date),
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: lowerRowFontSize),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final first;
  final last;
  final removeHeight;
  final isYearDivider;

  CustomDivider(
      {this.first = false,
      this.last = false,
      this.removeHeight = false,
      this.isYearDivider = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            last
                ? Container(
                    child: SizedBox(height: 8.0),
                    color: Theme.of(context).primaryColorDark,
                  )
                : Container(),
            Divider(
              thickness: isYearDivider ? 1.0 : 1.25,
              color: isYearDivider
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColorDark,
              height: first || last || removeHeight || isYearDivider ? 0 : 16,
            ),
            first
                ? Container(
                    child: SizedBox(height: 8.0),
                    color: Theme.of(context).primaryColorDark,
                  )
                : Container(),
          ],
        ));
  }
}

class MonthTile extends StatelessWidget {
  final String month;
  final double spared;
  final bool first;
  final VoidCallback onAnalyticsTap;

  MonthTile({this.month, this.spared, this.first = false, this.onAnalyticsTap});

  @override
  Widget build(BuildContext context) {
    String moneyPrefix = spared >= 0 ? "+" : "";
    // Color moneyColor = spared >= 0 ? Color(0xFF8CD867) : Colors.red[400];
    Color moneyColor = spared >= 0 ? Colors.green[400] : Colors.red[400];

    return Container(
      color: Color(0xFF272727),
      child: Padding(
        padding:
            EdgeInsets.only(top: 6.0, bottom: 6.0, left: 10.0, right: 10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: !first,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    moneyPrefix + format(spared),
                    style: TextStyle(fontSize: 13.0, color: moneyColor),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () => onAnalyticsTap.call(),
                    icon: Icon(
                      Icons.analytics_outlined,
                      color: Theme.of(context).indicatorColor,
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Text(
                month.toUpperCase(),
                style: TextStyle(
                    fontSize: 17.0, color: Theme.of(context).primaryColorLight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YearTile extends StatelessWidget {
  final String year;

  YearTile({this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF272727),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            year,
            style: TextStyle(
                fontSize: 25.0, color: Theme.of(context).primaryColorLight),
          ),
        ),
      ),
    );
  }
}

class NoDataTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text(
          "BRAK WYDATKÓW",
          style:
              TextStyle(fontSize: 15.0, color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}

class EmptyExpenseBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(21.5),
      child: Center(
          child: Text(
        "Nie masz jeszcze żadnych wydatków. Wciśnij przycisk \"+\", aby je dodać.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0),
      )),
    );
  }
}

class NotStartedBody extends StatelessWidget {
  final DateTime dateFrom;

  NotStartedBody(this.dateFrom);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(21.5),
      child: Center(
          child: Text(
        "Plan jescze się nie rozpoczął. Miesiąc startowy planu to " + toMonth(dateFrom) +".",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0),
      )),
    );
  }
}
