import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[500],
      primaryColorBrightness: Brightness.light,
      accentColor: Colors.green[500],
      accentColorBrightness: Brightness.light
  );

  static final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.brown,
      primaryColor: Colors.brown[500],
      primaryColorBrightness: Brightness.dark,
      accentColor: Colors.green[500],
      accentColorBrightness: Brightness.dark
  );
}