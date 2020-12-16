import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/providers/notifiers/expenses_provider.dart';
import 'package:skarbonka/providers/notifiers/plan_config_provider.dart';
import 'package:skarbonka/utils/date_utils.dart';
import 'package:skarbonka/utils/navigation.dart';
import 'package:skarbonka/utils/number_utils.dart';

class ViewExpensePage extends StatelessWidget {
  final String _title = "Wydatek";

  @override
  Widget build(BuildContext context) {
    String expenseIdxString = ModalRoute.of(context).settings.arguments;
    int expenseIdx = int.parse(expenseIdxString);
    var expensesProvider =
        Provider.of<ExpensesProvider>(context, listen: false);
    var planConfigProvider =
    Provider.of<PlanConfigProvider>(context, listen: false);
    Expense expense = expensesProvider.getExpense(expenseIdx);
    var categoryMap = planConfigProvider.categoryMap;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldName("Nazwa"),
            InterFieldDivider(),
            FieldValue(expense.name),
            Divider(color: Colors.grey[300],),
            FieldDivider(),
            FieldName("Data"),
            InterFieldDivider(),
            FieldValue(toExpenseDateTimeString(expense.date)),
            Divider(color: Colors.grey[300],),
            FieldDivider(),
            FieldName("Kwota (zł)"),
            InterFieldDivider(),
            FieldValue(format(expense.value)),
            Divider(color: Colors.grey[300],),
            FieldDivider(),
            FieldName("Kategoria"),
            InterFieldDivider(),
            FieldValue(categoryMap[expense.categoryId].name),
            Divider(color: Colors.grey[300],),
          ],
        ),
      ),
      floatingActionButton: expense.categoryId != 0
          ? FloatingActionButton.extended(
              onPressed: () => navigateTo(context, AppRoute.EXPENSE,
                  arguments: expenseIdxString),
              label: Text('Edytuj'),
              icon: Icon(Icons.edit),
              backgroundColor: Theme.of(context).accentColor,
            )
          : Container(),
    );
  }
}

class FieldName extends StatelessWidget {
  final String name;

  FieldName(this.name);

  @override
  Widget build(BuildContext context) {
    return Text(name, style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 13.0));
  }
}

class FieldValue extends StatelessWidget {
  final String value;

  FieldValue(this.value);

  @override
  Widget build(BuildContext context) {
    return Text(value, style: TextStyle(fontSize: 17.0));
  }
}

class FieldDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 15,);
  }
}

class InterFieldDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 2,);
  }
}



