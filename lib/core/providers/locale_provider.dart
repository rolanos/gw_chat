import 'package:gw_chat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  final List<Locale> supportedLocales = S.delegate.supportedLocales;

  Locale _locale = S.delegate.supportedLocales.last;
  Locale get locale => _locale;

  bool get isRussian => S.delegate.supportedLocales.last == locale;

  Future<void> setCachedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString('locale');
    if (locale == null) {
      S.delegate.supportedLocales.last;
    }
    if (locale == S.delegate.supportedLocales.first.languageCode) {
      _locale = S.delegate.supportedLocales.first;
    }
    if (locale == S.delegate.supportedLocales.last.languageCode) {
      _locale = S.delegate.supportedLocales.last;
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'locale',
      locale.languageCode,
    );
    notifyListeners();
  }
}
