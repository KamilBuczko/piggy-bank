import 'package:flutter/material.dart';

class FloatingSaveButton extends StatelessWidget {
  final VoidCallback onSave;
  final GlobalKey<FormState> formKey;

  FloatingSaveButton({this.formKey, this.onSave});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (formKey.currentState.validate()) {
          onSave.call();
        } else {
          _displayErrorSnackBar(context);
        }
      },
      label: Text('Zapisz'),
      icon: Icon(Icons.create),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  _displayErrorSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content:
      Text('Niepoprawne dane. Sprawdź i popraw pola zaznaczone na czerwono',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).errorColor,
            fontSize: 15.0,
          )),
      backgroundColor: Theme.of(context).primaryColor,
    );

    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }
}