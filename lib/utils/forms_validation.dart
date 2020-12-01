final _fieldRequiredText = "Pole jest wymagane";


String fieldRequiredValidator(value) {
  if (value.isEmpty) {
    return _fieldRequiredText;
  }
  return null;
}