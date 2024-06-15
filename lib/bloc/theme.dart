// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _isDarkTheme = false; 

  bool get isDarkMode => _isDarkTheme;
  set isDarkMode(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }


}
