import 'package:flutter/material.dart';

class GaadiLiveTheme {
  static const Color primaryBlue = Color(0xFF1D4ED8);
  static const Color primaryCyan = Color(0xFF57E5F7);
  static const Color deepNight = Color(0xFF030F1B);
  static const Color deepPanel = Color(0xFF091D2B);
  static const Color lightPanel = Color(0xFFF4F9FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color blackSurface = Color(0xFF000000);

  GaadiLiveTheme._();

  static ThemeData get lightTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      colorScheme: scheme.copyWith(
        primary: primaryBlue,
        secondary: primaryCyan,
        surface: lightSurface,
        onSurface: const Color(0xFF102033),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF102033),
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: Typography.blackMountainView.apply(
        bodyColor: const Color(0xFF102033),
        displayColor: const Color(0xFF102033),
      ),
    );
  }

  static ThemeData get darkTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryCyan,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: deepNight,
      colorScheme: scheme.copyWith(
        primary: primaryCyan,
        secondary: const Color(0xFF2FE7F5),
        surface: deepPanel,
        onSurface: const Color(0xFFEAF9FF),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFEAF9FF),
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: deepPanel,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: Typography.whiteMountainView.apply(
        bodyColor: const Color(0xFFEAF9FF),
        displayColor: const Color(0xFFEAF9FF),
      ),
    );
  }

  static ThemeData get blackTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: primaryCyan,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: blackSurface,
      colorScheme: scheme.copyWith(
        primary: primaryCyan,
        secondary: const Color(0xFF2FE7F5),
        surface: const Color(0xFF05070A),
        onSurface: const Color(0xFFEAF9FF),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFEAF9FF),
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF05070A),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: Typography.whiteMountainView.apply(
        bodyColor: const Color(0xFFEAF9FF),
        displayColor: const Color(0xFFEAF9FF),
      ),
    );
  }
}
