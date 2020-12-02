import 'package:intl/intl.dart';

DateFormat _dateFormat = new DateFormat('MMM yyyy', "pl");

DateTime toDateTime(String s) {
  return _dateFormat.parse(s);
}