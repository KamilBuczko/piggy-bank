final _fieldRequiredText = "Pole jest wymagane";
final _negativeValueTest = "Wartość musi być wieksza niż 0";


Function(String) basicValidator({bool required=false, bool positiveValue=false}) {
  return (String value) {
    if (required && value.isEmpty) {
      return _fieldRequiredText;
    }

    if (positiveValue && (value.isNotEmpty && int.parse(value) <= 0)) {
      return _negativeValueTest;
    }

    return null;
  };
}