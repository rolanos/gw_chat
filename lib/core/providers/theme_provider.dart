import 'package:flutter/material.dart';
import 'package:gw_chat/core/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData theme;

  ThemeProvider(this.theme);

  Future<void> setCachedTheme() async {
    final pref = await SharedPreferences.getInstance();
    final theme = pref.getBool('themeDark');
    if (theme == null || !theme) {
      this.theme = AppTheme.lightTheme;
    } else {
      this.theme = AppTheme.darkTheme;
    }
    notifyListeners();
  }

  Future<void> setTheme(ThemeData theme) async {
    this.theme = theme;
    final pref = await SharedPreferences.getInstance();
    if (theme == AppTheme.darkTheme) {
      pref.setBool('themeDark', true);
    }
    if (theme == AppTheme.lightTheme) {
      pref.setBool('themeDark', false);
    }
    notifyListeners();
  }
}
