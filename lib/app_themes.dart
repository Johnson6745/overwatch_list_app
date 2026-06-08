import 'package:flutter/material.dart';

enum AppTheme { dark, light, overwatch }

class AppThemes {
  static ThemeData getTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.dark:
        return _darkTheme;
      case AppTheme.light:
        return _lightTheme;
      case AppTheme.overwatch:
        return _overwatchTheme;
    }
  }

  static String getName(AppTheme theme) {
    switch (theme) {
      case AppTheme.dark:
        return 'Ciemny';
      case AppTheme.light:
        return 'Jasny';
      case AppTheme.overwatch:
        return 'Overwatch';
    }
  }

  static IconData getIcon(AppTheme theme) {
    switch (theme) {
      case AppTheme.dark:
        return Icons.nights_stay_outlined;
      case AppTheme.light:
        return Icons.wb_sunny_outlined;
      case AppTheme.overwatch:
        return Icons.local_fire_department_outlined;
    }
  }


  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0A0A0A),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6A329F),
      secondary: Color(0xFF6A329F),
      surface: Color(0xFF111111),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF111111),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600,
        letterSpacing: 1.5, color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Color(0xFF6A329F)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF111111),
      selectedItemColor: Color(0xFF6A329F),
      unselectedItemColor: Color(0xFF555555),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6A329F),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF666666),
        side: const BorderSide(color: Color(0xFF222222)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF141414),
      labelStyle: const TextStyle(color: Color(0xFF888888)),
      hintStyle: const TextStyle(color: Color(0xFF444444)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF222222)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF222222)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF6A329F)),
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF141414),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF222222)),
      ),
      elevation: 0,
    ),
    dividerColor: const Color(0xFF1A1A1A),
  );


  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF5B4FCF),
      secondary: Color(0xFF5B4FCF),
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1A1A1A),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600,
        letterSpacing: 1.5, color: Color(0xFF1A1A1A),
      ),
      iconTheme: IconThemeData(color: Color(0xFF5B4FCF)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF5B4FCF),
      unselectedItemColor: Color(0xFFAAAAAA),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5B4FCF),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF888888),
        side: const BorderSide(color: Color(0xFFDDDDDD)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Color(0xFF888888)),
      hintStyle: const TextStyle(color: Color(0xFFBBBBBB)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF5B4FCF)),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFEEEEEE)),
      ),
      elevation: 0,
    ),
    dividerColor: const Color(0xFFEEEEEE),
  );


  static final _overwatchTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0D0800),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFF6B00),
      secondary: Color(0xFFFF6B00),
      surface: Color(0xFF1A0F00),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A0F00),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600,
        letterSpacing: 1.5, color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Color(0xFFFF6B00)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1A0F00),
      selectedItemColor: Color(0xFFFF6B00),
      unselectedItemColor: Color(0xFF554433),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF6B00),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF664422),
        side: const BorderSide(color: Color(0xFF332211)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A0F00),
      labelStyle: const TextStyle(color: Color(0xFF886644)),
      hintStyle: const TextStyle(color: Color(0xFF443322)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF332211)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF332211)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFFF6B00)),
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1A0F00),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF332211)),
      ),
      elevation: 0,
    ),
    dividerColor: const Color(0xFF221100),
  );
}