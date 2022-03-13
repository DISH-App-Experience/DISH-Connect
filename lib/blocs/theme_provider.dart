import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'system';
  ThemeMode get themeMode {
    return ThemeMode.system;
  }

  changeTheme(String theme) {
    currentTheme = theme;
    notifyListeners();
  }
}
