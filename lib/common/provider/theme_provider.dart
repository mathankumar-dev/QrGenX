import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _themekey = 'isDarkTheme';

  bool _isDarkTheme = false;

  bool get isDarktheme => _isDarkTheme;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(_themekey) ?? false;
  }

  void toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themekey, _isDarkTheme);
  }
}
