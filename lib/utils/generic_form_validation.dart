final _fieldRequiredText = "Pole jest wymagane";
final _nonPositiveValueText = "Wartość musi być wieksza niż 0";
final _negativeValueText = "Wartość nie może być ujemna";


Function(String) basicValidator({bool required=false, bool positiveValue=false, bool nonNegativeValue=false}) {
  return (String value) {
    if (required && value.isEmpty) {
      return _fieldRequiredText;
    }

    if (positiveValue && (value.isNotEmpty && int.parse(value) <= 0)) {
      return _nonPositiveValueText;
    }

    if (positiveValue && (value.isNotEmpty && int.parse(value) < 0)) {
      return _negativeValueText;
    }

    return null;
  };
}