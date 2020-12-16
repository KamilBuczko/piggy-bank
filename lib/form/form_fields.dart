import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:skarbonka/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var selectionIndex = newValue.selection.end;

    return TextEditingValue(
      text:  newValue.text.replaceAll(",", "."),
      selection: TextSelection.collapsed(offset: selectionIndex)
    );
  }

}

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
      inputFormatters: [_NumberTextInputFormatter(), FilteringTextInputFormatter.allow(RegExp(r'^\d{1,6}(\.\d{0,2})?'))],
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
  final int maxLength;

  AppTextFormField({this.label, this.controller, this.validator, this.maxLength = 50});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(fontSize: 17.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(1.0),
        isDense: true,
        labelText: label,
        errorMaxLines: 2,
      ),
      keyboardType: TextInputType.name,
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
  final DateFormat dateFormat;

  AppDateFormField({
    this.dateFormat,
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
      dateFormat: dateFormat,
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

class AppSelect extends StatelessWidget {
  final String Function(String value) validator;
  final String label;
  final TextEditingController controller;
  final List<Map<String, dynamic>> items;

  AppSelect({
    this.label,
    this.controller,
    this.validator,
    this.items
  });

  @override
  Widget build(BuildContext context) {
    return SelectFormField(
      controller: controller,
      style: TextStyle(fontSize: 17.0),
      decoration: InputDecoration(
          errorMaxLines: 1,
          isDense: true,
          contentPadding: EdgeInsets.all(1.0),
          suffixIcon: Container(
              height: 48,
              width: 48,
              child: Padding(
                  padding: EdgeInsets.only(top: 11.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_drop_down)))
          ),
          labelText: label
      ),
      items: items,
    );
  }
}
