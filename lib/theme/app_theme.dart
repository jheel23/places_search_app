import 'package:place_search_app/theme/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static final AppTheme instance = AppTheme._();
  ThemeData theme = ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(color: Colors.white),
        bodySmall: GoogleFonts.poppins(color: Colors.white),
        bodyMedium: GoogleFonts.poppins(color: Colors.white),
        displayLarge: GoogleFonts.poppins(color: Colors.white),
        displaySmall: GoogleFonts.poppins(color: Colors.white),
        displayMedium: GoogleFonts.poppins(color: Colors.white),
        headlineLarge: GoogleFonts.poppins(color: Colors.white),
        headlineMedium: GoogleFonts.poppins(color: Colors.white),
        headlineSmall: GoogleFonts.poppins(color: Colors.white),
        labelLarge: GoogleFonts.poppins(color: Colors.white),
        labelMedium: GoogleFonts.poppins(color: Colors.white),
        labelSmall: GoogleFonts.poppins(color: Colors.white),
        titleLarge: GoogleFonts.poppins(color: Colors.white),
        titleMedium: GoogleFonts.poppins(color: Colors.white),
        titleSmall: GoogleFonts.poppins(color: Colors.white)),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 49, 27, 146),
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        brightness: Brightness.dark),
    useMaterial3: true,
  );
}
