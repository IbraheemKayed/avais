import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
  ];

  static String getFlag(String countryCode) {
    switch (countryCode) {
      case 'ar':
        return '🇵🇸';
      default:
        return '🇺🇸';
    }
  }

  static String getCountryName(String countryCode) {
    switch (countryCode) {
      case 'ar':
        return 'Palestine';
      default:
        return 'United States';
    }
  }
}
