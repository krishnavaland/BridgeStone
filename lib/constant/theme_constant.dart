import 'package:flutter/material.dart';

const primaryColor = Color(0xff08357C);
const secondaryColor = Color(0xffFFDC01);
const textButtonColor = Color(0xff005BEB);
const textColor = Color(0xff4B4B4B);

ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      // titleTextStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 24,fontFamily: 'Bariol'),
      backgroundColor: primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red.shade700))),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.black,
    ),
    fontFamily: 'Bariol',
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(textButtonColor),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ))),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16.0),
      bodySmall: TextStyle(fontSize: 12.0),
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor; // Color when checkbox is checked
        } else {
          return Colors.white; // Color when checkbox is unchecked
        }
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor,
    ));
