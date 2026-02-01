import 'package:flutter/material.dart';

class AppColor {
  static const lightMode = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.black,
    tertiaryContainer: Color.fromARGB(
      153,
      199,
      221,
      250,
    ), // HomePage Command Center,
    onPrimary: Color.fromRGBO(31, 55, 174, 1),
    secondary: Colors.black, // Text Color
    onSecondary: Colors.blueGrey, // Gray text Color
    error: Colors.red,
    // shadow: ,
    onError: Color.fromARGB(255, 205, 81, 81),
    surface: Colors.white, // Button
    tertiary: Colors.white, // AppBar or Bottom Navigation
    onSurface: Colors.black,
  );
  static const darkMode = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.red,
    onPrimary: Color.fromRGBO(31, 55, 174, 1),
    secondary: Colors.white, // Text Color
    onSecondary: Colors.grey, // Gray text Color
    error: Colors.red,
    onError: Color.fromARGB(255, 205, 81, 81),
    tertiaryContainer: Color(0xFF0F172A), // HomePage Command Center
    surface: Color(0xFF0F172A), // Button
    tertiary: Colors.black, // AppBar or Bottom Navigation
    onSurface: Colors.white,
  );
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    iconTheme: IconThemeData(color: Colors.greenAccent),
    colorScheme: lightMode,
    appBarTheme: AppBarTheme(
      backgroundColor: lightMode.tertiary,
      surfaceTintColor: lightMode.tertiary,
      foregroundColor: Colors.black,
    ),
    scaffoldBackgroundColor: Color.fromRGBO(231, 232, 233, 1),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkMode,
    iconTheme: IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: Color.fromRGBO(16, 19, 34, 1),
    appBarTheme: AppBarTheme(
      backgroundColor: darkMode.tertiary,
      surfaceTintColor: darkMode.tertiary,
      foregroundColor: Colors.white,
    ),
  );
}
