import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateFormat dateFormat;
  final FocusNode focusNode;
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;

  DatePicker({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.dateFormat,
    this.initialDate,
    this.onDateChanged,
    @required this.lastDate,
    @required this.firstDate,
  })  : assert(firstDate != null),
        assert(lastDate != null),
        super(key: key) {
    assert(!this.lastDate.isBefore(this.firstDate),
        'lastDate ${this.lastDate} must be on or after firstDate ${this.firstDate}.');
    assert(
        initialDate == null ||
            (initialDate != null && !this.initialDate.isBefore(this.firstDate)),
        'initialDate ${this.initialDate} must be on or after firstDate ${this.firstDate}.');
    assert(
        initialDate == null ||
            (initialDate != null && !this.initialDate.isAfter(this.lastDate)),
        'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.');
  }

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController _controllerDate;
  DateFormat _dateFormat;
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat;
    } else {
      _dateFormat = new DateFormat('dd/MM/yyyy');
    }

    _selectedDate = widget.initialDate;

    _controllerDate = TextEditingController();
    _controllerDate.text =
        _selectedDate != null ? _dateFormat.format(_selectedDate) : null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: _controllerDate,
      style: TextStyle(fontSize: 17.0),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(1.0),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsets.only(top: 11.0),
                child: widget.prefixIcon,
              )
            : widget.prefixIcon,
        suffixIcon: widget.suffixIcon != null
            ? Padding(
                padding: EdgeInsets.only(top: 11.0),
                  child: widget.suffixIcon
                )
            : widget.suffixIcon,
        labelText: widget.labelText,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controllerDate.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _controllerDate.text = _dateFormat.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }

    if (widget.focusNode != null) {
      widget.focusNode.nextFocus();
    }
  }
}
