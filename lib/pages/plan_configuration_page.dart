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
  final _fieldRequiredText = "Pole jest wymagane";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _monthlyIncomeField(),
            SizedBox(height: 20),
            _spareGoalField(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 150.0, child: _dateFromField()),
                SizedBox(width: 150.0, child: _dateToField()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _monthlyIncomeField() {
    return TextFormField(
      style: TextStyle(fontSize: 17.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1.0),
          isDense: true,
          labelText: 'Miesięczny przychód'),
      keyboardType: TextInputType.number,
      validator: _fieldRequiredValidator,
    );
  }

  TextFormField _spareGoalField() {
    return TextFormField(
      style: TextStyle(fontSize: 17.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1.0),
          isDense: true,
          labelText: 'Kwota do oszczędzenia'),
      keyboardType: TextInputType.number,
      validator: _fieldRequiredValidator,
    );
  }

  DatePicker _dateFromField() {
    DateTime currentDate = DateTime.now();
    return DatePicker(
      labelText: "Data startu",
      suffixIcon: Icon(Icons.arrow_drop_down, size: 20),
      lastDate: currentDate.add(Duration(days: 366 * 10)),
      firstDate: currentDate,
      initialDate: currentDate
    );
  }

  DatePicker _dateToField() {
    DateTime currentDate = DateTime.now();
    return DatePicker(
      labelText: "Data końca",
      suffixIcon: Icon(Icons.arrow_drop_down, size: 20),
      lastDate: currentDate.add(Duration(days: 366 * 10)),
      initialDate: DateTime(currentDate.year, currentDate.month + 1, currentDate.day),
      firstDate: currentDate,
    );
  }

  String _fieldRequiredValidator(value) {
    if (value.isEmpty) {
      return _fieldRequiredText;
    }
    return null;
  }
}
