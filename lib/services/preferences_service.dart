import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier {
  final SharedPreferences _prefs;

  PreferencesService(this._prefs) {
    _languageCode = _prefs.getString('language') ?? 'en';
    _fontSize = _prefs.getDouble('fontSize') ?? 1.0;
  }

  // Local state
  String _languageCode = 'en';
  double _fontSize = 1.0;

  String get languageCode => _languageCode;
  double get fontSize => _fontSize;

  Future<void> setLanguage(String code) async {
    _languageCode = code;
    await _prefs.setString('language', code);
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    _fontSize = size;
    await _prefs.setDouble('fontSize', size);
    notifyListeners();
  }
}
