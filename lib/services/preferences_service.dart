import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier {
  // Local state
  String _languageCode = 'en';
  double _fontSize = 1.0;

  String get languageCode => _languageCode;
  double get fontSize => _fontSize;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('language') ?? 'en';
    _fontSize = prefs.getDouble('fontSize') ?? 1.0;
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _languageCode = code;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', code);
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', size);
    notifyListeners();
  }
}
