import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  // menyimpan key & value Dark Theme
  static const darkTheme = 'DARK_THEME';
  // untuk schadule ing
  static const dailyNews = 'DAILY_NEWS';

  // menyimpan data dan membaca data dari sharedpreference yg darktheme
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  // menyimpan data dan membaca untuk schaduling
  Future<bool> get isDailyNewsActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyNews) ?? false;
  }

  void setDailyNews(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyNews, value);
  }

  PreferencesHelper({required this.sharedPreferences});
}
