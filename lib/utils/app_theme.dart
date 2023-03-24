import 'package:flutter/material.dart';

ThemeData getDefaultTheme() {
  final ThemeData theme = ThemeData.light();
  return theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(
      primary: const Color(0xFF3A86FF),
      onPrimary: Colors.white,
      secondary: const Color(0xFFE0E0E0),
      onSecondary: Colors.white,
      background: Colors.white,
    ),
    textTheme: theme.textTheme.copyWith(
      displayLarge: theme.textTheme.displayLarge!.copyWith(
          fontFamily: "OpenSans",
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      displayMedium: theme.textTheme.displayMedium!.copyWith(
        fontFamily: "OpenSans",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyMedium: theme.textTheme.bodyMedium!.copyWith(
        fontFamily: "OpenSans",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF3A86FF)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFF3A86FF),
          style: BorderStyle.solid,
        ),
      ),
    ),
  );
}
