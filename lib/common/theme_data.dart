import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFF8EDEB), // seashell
  primaryColor: Color(0xFFFCB5A7),            // melon
  colorScheme: ColorScheme.light(
    primary: Color(0xFFFCB5A7),               // melon
    secondary: Color(0xFFFEC89A),            // seashell
    surface: Color(0xFFFCD5CE),               // pale-dogwood
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodyMedium: TextStyle(color: Colors.black87),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF2C2C2C),
  primaryColor: Color(0xFFFEC89A),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFFFEC89A),              // peach
    secondary: Color(0xFFF9DCC4),
    surface: Color(0xFF373737),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodyMedium: TextStyle(color: Colors.white70),
  ),
);
