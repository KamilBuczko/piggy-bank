import 'package:intl/intl.dart';

DateFormat _dateFormat = new DateFormat('MMM yyyy', "pl");
DateFormat _sparedLineFormat = new DateFormat('MM-yyyy', "pl");
DateFormat _dayMonthFormat = new DateFormat('dd MMM', "pl");
DateFormat _monthFormat = new DateFormat('MMMM', "pl");
DateFormat _yearFormat = new DateFormat('yyyy', "pl");
DateFormat _dayFormat = new DateFormat('dd', "pl");
DateFormat _expenseFormat = new DateFormat('MMM dd, yyyy', "pl");

DateTime toDateTime(String s) {
  return _dateFormat.parse(s);
}

String toDateString(DateTime date) {
  return _dateFormat.format(date);
}

DateTime toExpenseDateTime(String s) {
  return _expenseFormat.parse(s);
}

String toExpenseDateTimeString(DateTime date) {
  return _expenseFormat.format(date);
}

String toDayMonth(DateTime date) {
  return _dayMonthFormat.format(date);
}

String toDay(DateTime date) {
  return _dayFormat.format(date);
}

String toMonth(DateTime date) {
  return _monthFormat.format(date);
}

String toYear(DateTime date) {
  return _yearFormat.format(date);
}

String toSparedLine(DateTime date) {
  return _sparedLineFormat.format(date);
}

List<DateTime> generateRangeInMonths(DateTime from, DateTime to) {
    int fromMonth = from.month;
    int fromYear = from.year;

    List<DateTime> result = [];

    while (fromMonth != to.month || fromYear != to.year) {
      result.add(DateTime(fromYear, fromMonth, 1));

      if (fromMonth == 12) {
        fromYear += 1;
        fromMonth = 1;
      } else {
        fromMonth += 1;
      }
    }

    result.add(to);
    return result;
}

bool monthInRange(DateTime current, DateTime from, DateTime to) {
  var fromToMonthDiff = getDatesMonthDiff(from, to);
  var currentFromMonthDiff = getDatesMonthDiff(from, current);

  if (currentFromMonthDiff < 0 || currentFromMonthDiff > fromToMonthDiff) {
    return false;
  } else {
    return true;
  }
}

int getDatesMonthDiff(DateTime dateFrom, DateTime dateTo) {
  int yearDiff = dateTo.year - dateFrom.year;
  int monthDiff = dateTo.month - dateFrom.month + yearDiff * 12;

  return monthDiff;
}

bool isSameYear(DateTime d1, DateTime d2) {
  return d1.year == d2.year;
}

DateTime setDayAsLast(DateTime date) {
  DateTime result;
  if (date.month == 12) {
    result = DateTime(date.year + 1, 1, 1).subtract(Duration(days: 1));
  } else {
    result = DateTime(date.year, date.month + 1, 1).subtract(Duration(days: 1));
  }

  return result;
}