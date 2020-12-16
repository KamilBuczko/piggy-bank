import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/form/form_fields.dart';
import 'package:skarbonka/model/expense.dart';
import 'package:skarbonka/model/expense_form.dart';
import 'package:skarbonka/model/plan_config.dart';
import 'package:skarbonka/providers/notifiers/expenses_provider.dart';
import 'package:skarbonka/providers/notifiers/plan_config_provider.dart';
import 'package:skarbonka/utils/app_date_time.dart';
import 'package:skarbonka/utils/date_utils.dart';
import 'package:skarbonka/utils/mapper/expense_mapper.dart';
import 'package:skarbonka/utils/navigation.dart';
import 'package:skarbonka/utils/validation/generic_form_validation.dart';
import 'package:skarbonka/widgets/floating_form_save_button.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _createTitle = "Dodaj wydatek";
  final _editTitle = "Edytuj wydatek";
  final _expenseFormControllers = ExpenseFormControllers();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String args = ModalRoute.of(context).settings.arguments;
    int expenseIdx;
    if (args != null) {
      expenseIdx = int.parse(args);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? _editTitle : _createTitle),
        actions: [
          Visibility(
            visible: expenseIdx != null,
            child: TextButton(
                onPressed: () => _deleteExpense(expenseIdx),
                child: Text(
                  "USUŃ",
                  style: TextStyle(
                      color: Theme.of(context).errorColor, fontSize: 15.0),
                )),
          )
        ],
      ),
      body: ExpenseForm(
        expenseIdx: expenseIdx,
        formKey: _formKey,
        controllers: _expenseFormControllers,
      ),
      floatingActionButton: FloatingSaveButton(
          formKey: _formKey, onSave: () => _saveExpense(expenseIdx)),
    );
  }

  _saveExpense(int expenseIdx) {
    var expensesProvider =
        Provider.of<ExpensesProvider>(context, listen: false);

    Expense expense = ExpenseMapper.toExpense(_expenseFormControllers);

    expenseIdx == null
        ? expensesProvider.addExpense(expense)
        : expensesProvider.setExpense(expenseIdx, expense);
    navigateBack(context);
  }

  _deleteExpense(int expenseIdx) {
    var expensesProvider =
        Provider.of<ExpensesProvider>(context, listen: false);

    expensesProvider.deleteExpense(expenseIdx);
    navigateBack(context, count: 2);
  }
}

class ExpenseForm extends StatefulWidget {
  final formKey;
  final ExpenseFormControllers controllers;
  final expenseIdx;

  ExpenseForm({this.formKey, this.controllers, this.expenseIdx});

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  @override
  void initState() {
    super.initState();
    if (widget.expenseIdx != null) {
      updateControllers();
    }
  }

  void updateControllers() {
    final planConfigProvider =
        Provider.of<ExpensesProvider>(context, listen: false);

    Expense expense = planConfigProvider.getExpense(widget.expenseIdx);
    widget.controllers.update(expense);
  }

  @override
  Widget build(BuildContext context) {
    final planConfigProvider =
        Provider.of<PlanConfigProvider>(context, listen: false);

    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppTextFormField(
              controller: widget.controllers.name,
              label: "Nazwa",
              validator: basicValidator(required: true),
            ),
            AppDateFormField(
              controller: widget.controllers.date,
              label: "Data",
              dateFormat: DateFormat('MMM dd, yyyy', "pl"),
              lastDate: AppDateTime.now()
                      .isAfter(planConfigProvider.planConfig.dateTo)
                  ? planConfigProvider.planConfig.dateTo
                  : AppDateTime.now(),
              initialDate: widget.expenseIdx == null
                  ? AppDateTime.now()
                          .isAfter(planConfigProvider.planConfig.dateTo)
                      ? planConfigProvider.planConfig.dateTo
                      : AppDateTime.now()
                  : toExpenseDateTime(widget.controllers.date.text),
              firstDate: planConfigProvider.planConfig.dateFrom,
            ),
            SizedBox(height: 20.0),
            AppNumberFormField(
              controller: widget.controllers.value,
              label: "Kwota (zł)",
              validator: basicValidator(required: true, positiveValue: true),
            ),
            SizedBox(height: 20.0),
            AppSelect(
              controller: widget.controllers.category,
              items: _getCategoryItems(
                  planConfigProvider.planConfig.expenseCategories),
              label: "Kategoria",
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getCategoryItems(
      List<ExpenseCategory> expenseCategories) {
    return List.generate(
        expenseCategories.length - 1,
        (index) => {
              'value': expenseCategories[index + 1].id.toString(),
              'label': expenseCategories[index + 1].name
            });
  }
}
