import 'package:flutter/material.dart';

enum AppLanguage { en, id }

class LanguageProvider extends ChangeNotifier {
  AppLanguage _language = AppLanguage.id;

  AppLanguage get language => _language;

  void toggleLanguage() {
    _language = _language == AppLanguage.en ? AppLanguage.id : AppLanguage.en;
    notifyListeners();
  }

  void setLanguage(AppLanguage lang) {
    _language = lang;
    notifyListeners();
  }

  bool get isEnglish => _language == AppLanguage.en;
}
