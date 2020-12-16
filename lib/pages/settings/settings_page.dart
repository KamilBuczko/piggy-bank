import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/providers/notifiers/dark_theme_provider.dart';

class SettingsPage extends StatefulWidget {
  final String title = "Ustawienia";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SettingsBody(),
    );
  }
}

class SettingsBody extends StatefulWidget {
  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Tryb ciemny",
                style: TextStyle(fontSize: 17.0),
              ),
              Switch(
                  value: themeProvider.darkTheme,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (value) => themeProvider.darkTheme = value)
            ],
          ),
        ],
      ),
    );
  }
}
