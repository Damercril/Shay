import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  Locale _locale;

  LocaleProvider(this._prefs) : _locale = Locale(_prefs.getString('languageCode') ?? 'fr') {
    _loadLocale();
  }

  Locale get locale => _locale;

  void _loadLocale() {
    final languageCode = _prefs.getString('languageCode');
    if (languageCode != null) {
      _locale = Locale(languageCode);
    }
  }

  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await _prefs.setString('languageCode', languageCode);
    notifyListeners();
  }

  String getLanguageName(String code) {
    switch (code) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'ar':
        return 'العربية';
      default:
        return 'Français';
    }
  }

  List<Map<String, String>> get supportedLocales => [
    {'code': 'fr', 'name': 'Français'},
    {'code': 'en', 'name': 'English'},
    {'code': 'es', 'name': 'Español'},
    {'code': 'ar', 'name': 'العربية'},
  ];
}
