import 'package:base/app/shared/themes/theme_dark.dart';
import 'package:base/app/shared/themes/theme_light.dart';
import 'package:flutter/material.dart';

class ThemeFactory {
  getTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      return DarkTheme().getTheme();
    }
    return ThemeLight().getTheme();
  }
}
