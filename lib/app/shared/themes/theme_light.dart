import 'package:flutter/material.dart';

class ThemeLight {
  ThemeData getTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.deepOrange,
      fontFamily: 'Lato',
      brightness: Brightness.light,
    );
  }
}
