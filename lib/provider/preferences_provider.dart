import 'package:dicoding_news_app/cummon/styles.dart';
import 'package:dicoding_news_app/data/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  bool _isDailyNewsActive = false;
  bool get isDailyNewsActive => _isDailyNewsActive;

  // tambahkan Helper
  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyNewsPreferences();
  }

  //
  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  //
  void _getDailyNewsPreferences() async {
    _isDailyNewsActive = await preferencesHelper.isDailyNewsActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  //
  void enableDailyNews(bool value) {
    preferencesHelper.setDailyNews(value);
    _getDailyNewsPreferences();
  }
}
