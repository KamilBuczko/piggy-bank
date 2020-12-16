import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const DARK_MODE_STATUS = "DARK_MODE_STATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(DARK_MODE_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(DARK_MODE_STATUS) ?? true;
  }
}