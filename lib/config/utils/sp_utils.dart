import 'package:news_app/config/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<bool> setDarkTheme(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(Constants.themeKey, value);
  }

  static Future<bool?> getDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.themeKey);
  }
}