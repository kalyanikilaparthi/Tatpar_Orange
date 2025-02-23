import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatpar_orange/l10n/l10n.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale;
  LanguageProvider(this._locale);

  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentLanguage', locale.languageCode);
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }

  static Future<Locale> getSavedLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('currentLanguage');
    if (languageCode != null && L10n.all.contains(Locale(languageCode))) {
      return Locale(languageCode);
    } else {
      return const Locale('en');
    }
  }
  // LanguageProvider._initialise();

  // static final LanguageProvider _instance = LanguageProvider._initialise();

  // factory LanguageProvider() {
  //   return _instance;
  // }

  // String _currentLanguage = 'en';

  // String get currentLanguage => _currentLanguage;

  // set language(String value) {
  //   final Future<SharedPreferences> preferences =
  //       SharedPreferences.getInstance();

  //   _currentLanguage = value;
  //   Locale.fromSubtags(languageCode: value);
  //   preferences.then((SharedPreferences prefs) {
  //     return prefs.setString('currentLanguage', value);
  //   });
  //   notifyListeners();
  // }
}
