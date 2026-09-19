import "package:flutter/material.dart";

const Color kPrimaryColor = Color(0xFF6200EE);
const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kSurfaceColor = Color(0xFFF5F5F5);

ThemeData buildKataTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: kPrimaryColor,
    brightness: Brightness.light,
    surface: kSurfaceColor,
    background: kBackgroundColor,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: kSurfaceColor,
      elevation: 2,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
    ),
  );
}