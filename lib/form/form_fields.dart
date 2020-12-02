import 'package:Skarbonka/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNumberFormField extends StatelessWidget {
  final String Function(String value) validator;
  final String label;
  final TextEditingController controller;
  final String helperText;

  AppNumberFormField(
      {this.label, this.controller, this.validator, this.helperText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 17.0),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(1.0),
        isDense: true,
        labelText: label,
        helperText: helperText,
        errorMaxLines: 2,
      ),
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }
}

class AppTextFormField extends StatelessWidget {
  final String Function(String value) validator;
  final String label;
  final TextEditingController controller;

  AppTextFormField({this.label, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 17.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(1.0),
        isDense: true,
        labelText: label,
        errorMaxLines: 2,
      ),
      keyboardType: TextInputType.text,
      validator: validator,
    );
  }
}

class AppDateFormField extends StatelessWidget {
  final String Function(String value) validator;
  final String label;
  final TextEditingController controller;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  AppDateFormField({
    this.label,
    this.controller,
    this.validator,
    this.initialDate,
    @required this.lastDate,
    @required this.firstDate,
  });

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      controller: controller,
      labelText: label,
      suffixIcon: Icon(Icons.arrow_drop_down, size: 20),
      lastDate: lastDate,
      initialDate: initialDate,
      firstDate: firstDate,
      validator: validator,
    );
  }
}
