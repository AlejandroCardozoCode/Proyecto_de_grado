import 'package:flutter/material.dart';

class ThemeApp {
  static final Color primary = Color.fromARGB(255, 65, 131, 255);
  static final Color appRed = Color.fromARGB(255, 229, 32, 32);
  static final ThemeData light = ThemeData.light().copyWith(
    primaryColor: primary,
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        shadowColor: const Color.fromARGB(56, 158, 158, 158),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: primary),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(color: Colors.white),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 5,
      shadowColor: const Color.fromARGB(56, 158, 158, 158),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
