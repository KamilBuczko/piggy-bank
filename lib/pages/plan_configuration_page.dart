import 'package:Skarbonka/form/form_fields.dart';
import 'package:Skarbonka/model/plan_configuration_form.dart';
import 'package:Skarbonka/utils/forms_validation.dart';
import 'package:flutter/material.dart';

class PlanConfigurationPage extends StatelessWidget {
  final String _title = "Utwórz plan";
  final planControllers = PlanFormControllers();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: PlanForm(
        formKey: _formKey,
        controllers: planControllers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // If the form is valid, display a Snackbar.
            print("GIT");
          }
        },
        label: Text('Zapisz'),
        icon: Icon(Icons.create),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}

class PlanForm extends StatefulWidget {
  final formKey;
  final PlanFormControllers controllers;

  PlanForm({this.formKey, this.controllers});

  @override
  _PlanFormState createState() => _PlanFormState();
}

class _PlanFormState extends State<PlanForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        children: <Widget>[
          BasicDataSection(controllers: widget.controllers.basicData),
          CyclicExpensesSection(controllers: widget.controllers),
          SectionTitle("Kategorie wydatków", onTap: () {})
        ],
      ),
    );
  }
}

class BasicDataSection extends StatefulWidget {
  final BasicDataFormControllers controllers;

  BasicDataSection({this.controllers});

  @override
  _BasicDataSectionState createState() => _BasicDataSectionState();
}

class _BasicDataSectionState extends State<BasicDataSection> {
  bool _minimized = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle("Podstawowe dane", onTap: _toggleMinimization),
        Offstage(
          offstage: _minimized,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppNumberFormField(
                  controller: widget.controllers.monthlyIncome,
                  label: "Miesięczny przychód (zł)",
                  validator:
                      basicValidator(required: true, positiveValue: true),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                        width: 150.0,
                        child: DateFromField(
                          controller: widget.controllers.dateFrom,
                        )),
                    SizedBox(
                        width: 150.0,
                        child: DateToField(
                          controller: widget.controllers.dateTo,
                        )),
                  ],
                ),
                SizedBox(height: 20.0),
                AppNumberFormField(
                  label: "Kwota do oszczędzenia",
                  validator:
                      basicValidator(required: true, positiveValue: true),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _toggleMinimization() {
    setState(() {
      _minimized = !_minimized;
    });
  }
}

class CyclicExpensesSection extends StatefulWidget {
  final PlanFormControllers controllers;

  CyclicExpensesSection({this.controllers});

  @override
  _CyclicExpensesSectionState createState() => _CyclicExpensesSectionState();
}

class _CyclicExpensesSectionState extends State<CyclicExpensesSection> {
  bool _minimized = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle("Stałe miesięczne wydatki", onTap: _toggleMinimization),
        Offstage(
            offstage: _minimized,
            child: CyclicExpensesList(controllers: widget.controllers))
      ],
    );
  }

  void _toggleMinimization() {
    setState(() {
      _minimized = !_minimized;
    });
  }
}

class CyclicExpensesList extends StatefulWidget {
  final PlanFormControllers controllers;

  CyclicExpensesList({this.controllers});

  @override
  _CyclicExpensesListState createState() => _CyclicExpensesListState();
}

class _CyclicExpensesListState extends State<CyclicExpensesList> {
  int _itemsCount = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = List.generate(
        _itemsCount * 2,
        (index) => index.isEven
            ? Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: CyclicExpenseTile(
                    controllers: widget.controllers.cyclicExpenses[index~/2],
                    onRemove: () => _removeItem(index~/2)))
            : Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Divider(
                    thickness: 2, color: Theme.of(context).primaryColor),
              ));

    list.add(Offstage(
        offstage: false, child: AddCyclicExpenseTile(onPressed: _addItem)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  void _addItem() {
    widget.controllers.cyclicExpenses.forEach((element) {print(element.dateTo.text); });

    setState(() {
      _itemsCount += 1;
      widget.controllers.cyclicExpenses.add(CyclicExpensesFormControllers());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _itemsCount -= 1;
      widget.controllers.cyclicExpenses.removeAt(index.toInt());
    });
  }
}

class AddCyclicExpenseTile extends StatelessWidget {
  final VoidCallback onPressed;

  AddCyclicExpenseTile({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
        child: Container(
          decoration: ShapeDecoration(
            color: Theme.of(context).accentColor,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () => onPressed.call(),
          ),
        ),
      ),
    );
  }
}

class CyclicExpenseTile extends StatefulWidget {
  final VoidCallback onRemove;
  final CyclicExpensesFormControllers controllers;

  CyclicExpenseTile({this.controllers, this.onRemove});

  @override
  _CyclicExpenseTileState createState() => _CyclicExpenseTileState();
}

class _CyclicExpenseTileState extends State<CyclicExpenseTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 250.0,
              child: AppTextFormField(
                controller: widget.controllers.name,
                label: "Nazwa",
                validator: basicValidator(required: true),
              ),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                icon: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(Icons.delete,
                        color: Theme.of(context).errorColor, size: 30)),
                onPressed: () => widget.onRemove.call())
          ],
        ),
        SizedBox(height: 20.0),
        AppNumberFormField(
          controller: widget.controllers.value,
          label: "Kwota",
          validator: basicValidator(required: true, positiveValue: true),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
                width: 150.0,
                child: DateFromField(
                  controller: widget.controllers.dateFrom,
                )),
            SizedBox(
                width: 150.0,
                child: DateToField(
                  controller: widget.controllers.dateTo,
                )),
          ],
        ),
      ],
    );
  }
}

class SectionTitle extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  SectionTitle(this.title, {this.onTap});

  @override
  _SectionTitleState createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  bool _minimized = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap.call();
        setState(() {
          _minimized = !_minimized;
        });
      },
      child: Container(
        height: 40,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
              ),
              Icon(_minimized ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}

class DateFromField extends StatelessWidget {
  final TextEditingController controller;

  DateFromField({this.controller});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    return AppDateFormField(
      controller: controller,
      label: "Data startu",
      lastDate: currentDate.add(Duration(days: 366 * 10)),
      firstDate: currentDate,
      initialDate: currentDate,
    );
  }
}

class DateToField extends StatelessWidget {
  final TextEditingController controller;

  DateToField({this.controller});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    return AppDateFormField(
      controller: controller,
      label: "Data końca",
      lastDate: currentDate.add(Duration(days: 366 * 10)),
      initialDate:
          DateTime(currentDate.year, currentDate.month + 1, currentDate.day),
      firstDate: currentDate,
    );
  }
}
