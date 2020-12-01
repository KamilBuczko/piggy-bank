import 'package:Skarbonka/utils/forms_validation.dart';
import 'package:Skarbonka/widgets/date_picker.dart';
import 'package:flutter/material.dart';

class PlanConfigurationPage extends StatelessWidget {
  final String _title = "Utwórz plan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: PlanForm());
  }
}

class PlanForm extends StatefulWidget {
  @override
  _PlanFormState createState() => _PlanFormState();
}

class _PlanFormState extends State<PlanForm> {
  final _formKey = GlobalKey<FormState>();
  final _distanceBetweenForms = 20.0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionTitle("Podstawowe dane"),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MonthlyIncomeField(),
                SizedBox(height: _distanceBetweenForms),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: 150.0, child: DateFromField()),
                    SizedBox(width: 150.0, child: DateToField()),
                  ],
                ),
                SizedBox(height: _distanceBetweenForms),
                SpareGoalField(),
              ],
            ),
          ),
          SectionTitle("Stałe miesięczne wydatki"),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               // ListView()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {

  final String title;

  SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          ),
        ),
      ),
    );
  }
}

class MonthlyIncomeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 17.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1.0),
          isDense: true,
          labelText: 'Miesięczny przychód (zł)'),
      keyboardType: TextInputType.number,
      validator: fieldRequiredValidator,
    );
  }
}

class SpareGoalField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 17.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1.0),
          isDense: true,
          labelText: 'Kwota do oszczędzenia (zł)'),
      keyboardType: TextInputType.number,
      validator: fieldRequiredValidator,
    );
  }
}

class DateFromField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    return DatePicker(
      labelText: "Data startu",
      suffixIcon: Icon(Icons.arrow_drop_down, size: 20),
      lastDate: currentDate.add(Duration(days: 366 * 10)),
      firstDate: currentDate,
      initialDate: currentDate,
      onDateChanged: (DateTime value) {},
    );
  }
}

class DateToField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    return DatePicker(
      labelText: "Data końca",
      suffixIcon: Icon(Icons.arrow_drop_down, size: 20),
      lastDate: currentDate.add(Duration(days: 366 * 10)),
      initialDate:
          DateTime(currentDate.year, currentDate.month + 1, currentDate.day),
      firstDate: currentDate,
      onDateChanged: (DateTime value) {},
    );
  }
}
