import 'package:flutter/material.dart';

import '../navigation.dart';

class HomePage extends StatefulWidget {
  final String title = "Skarbonka";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () => navigateTo(context, AppRoute.SETTINGS)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () => navigateTo(context, AppRoute.PLAN_CONFIGURATION),
                textTheme: ButtonTextTheme.primary,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Zacznij oszczędzać!',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}