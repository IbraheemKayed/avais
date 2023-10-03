import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants/global_variables.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void updateLanguage(Locale locale) {
    GlobalVariables.isArabic = !GlobalVariables.isArabic;

    _locale = locale;

    notifyListeners();
  }
}
