import 'package:flutter/material.dart';

class ThemeModel {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSeed(
      background: const Color.fromRGBO(255, 255, 255, 1),
      seedColor: const Color.fromRGBO(26, 26, 26, 1),
      primary: const Color.fromRGBO(26, 26, 26, 1),
      onPrimary: const Color.fromRGBO(255, 255, 255, 1),
      error: Colors.red,
      secondary: const Color.fromRGBO(195, 195, 195, 1),
      onSecondary: const Color.fromRGBO(215, 215, 215, 1),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      titleTextStyle: textTheme.bodyLarge!.copyWith(
        fontSize: 26,
        color: const Color.fromRGBO(26, 26, 26, 1),
      ),
      actionsIconTheme: const IconThemeData(
        color: Color.fromRGBO(26, 26, 26, 1),
      ),
    ),
  );
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSeed(
      background: const Color.fromRGBO(26, 26, 26, 1),
      seedColor: const Color.fromRGBO(255, 255, 255, 1),
      primary: const Color.fromRGBO(255, 255, 255, 1),
      onPrimary: const Color.fromRGBO(26, 26, 26, 1),
      error: Colors.red,
      secondary: const Color.fromRGBO(95, 95, 95, 1),
      onSecondary: const Color.fromRGBO(66, 66, 66, 1),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(26, 26, 26, 1),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
      titleTextStyle: textTheme.bodyLarge!.copyWith(
        fontSize: 26,
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      actionsIconTheme: const IconThemeData(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
    ),
  );

  static Color firstColor = Colors.cyan;

  static TextTheme textTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "PoppinsBold",
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: "PoppinsSemiBold",
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      fontFamily: "PoppinsRegular",
      fontSize: 16,
    ),
  );
}
