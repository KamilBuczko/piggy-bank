import 'package:intl/intl.dart';

NumberFormat _numberFormat =  NumberFormat("###,###,##0.00", "pl_PL");
NumberFormat _chartNumberFormat =  NumberFormat("###0", "pl_PL");
NumberFormat _chartNumberInKFormat =  NumberFormat("##0.#", "pl_PL");

String format(double d) {
  return _numberFormat.format(d);
}

String formatForChart(double d) {
  return _chartNumberFormat.format(d);
}

String formatForChartInK(double d) {
  return _chartNumberInKFormat.format(d);
}
