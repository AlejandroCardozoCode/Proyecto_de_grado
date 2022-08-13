import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeApp {
  static final Color primary = Color.fromARGB(255, 65, 131, 255);
  static final Color appRed = Color.fromARGB(255, 229, 32, 32);
  static final ThemeData light = ThemeData.light().copyWith(
      primaryColor: primary,
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(
          color: primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 10,
        ),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primary),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: primary,
          textStyle: TextStyle(color: Colors.white),
        ),
      ),
      appBarTheme: AppBarTheme(
          color: primary,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.white)));
}
