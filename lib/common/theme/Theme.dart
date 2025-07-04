import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoftNeumorphicTheme {
  static final ColorScheme _lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFE0E5EC),
    onPrimary: Colors.black,
    primaryContainer: Color(0xFFBEC8D2),
    onPrimaryContainer: Colors.black87,
    secondary: Color(0xFFFEC89A),
    onSecondary: Colors.black,
    secondaryContainer: Color(0xFFF9DCC4),
    onSecondaryContainer: Colors.black,
    background: Color(0xFFF8F8F8),
    onBackground: Colors.black87,
    surface: Color(0xFFF0F0F3),
    onSurface: Colors.black87,
    error: Color(0xFFB00020),
    onError: Colors.white,
  );

  static final ColorScheme _darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF3C3C3C),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFF2E2E2E),
    onPrimaryContainer: Colors.white70,
    secondary: Color(0xFFF9DCC4),
    onSecondary: Colors.black,
    secondaryContainer: Color(0xFF4A4A4A),
    onSecondaryContainer: Colors.white,
    background: Color(0xFF1E1E1E),
    onBackground: Colors.white70,
    surface: Color(0xFF2C2C2C),
    onSurface: Colors.white,
    error: Color(0xFFCF6679),
    onError: Colors.black,
  );

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: _lightColorScheme.background,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: _lightColorScheme.onBackground,
        displayColor: _lightColorScheme.onBackground,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _lightColorScheme.background,
        foregroundColor: _lightColorScheme.onBackground,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightColorScheme.primary,
          foregroundColor: _lightColorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: _lightColorScheme.primaryContainer,
        ),
      ),
      cardColor: _lightColorScheme.surface,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:
              Colors.blue, // or Theme.of(context).colorScheme.primary
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: _lightColorScheme.onSurface.withOpacity(0.6),
        backgroundColor: _lightColorScheme.background,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedIconTheme: IconThemeData(size: 24),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: _lightColorScheme.onBackground,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      scaffoldBackgroundColor: _darkColorScheme.background,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: _darkColorScheme.onBackground,
        displayColor: _darkColorScheme.onBackground,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: _darkColorScheme.onBackground,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _darkColorScheme.background,
        foregroundColor: _darkColorScheme.onBackground,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkColorScheme.primary,
          foregroundColor: _darkColorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          shadowColor: _darkColorScheme.primaryContainer,
        ),
      ),
      cardColor: _darkColorScheme.surface,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:
              Colors.blue, // or Theme.of(context).colorScheme.primary
        ),
      ),
    );
  }
}
