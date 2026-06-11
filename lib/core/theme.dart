// lib/core/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors based on your UI image
  static const Color darkBackground = Color(0xFF0B0E14); // Deep Navy/Black
  static const Color cardColor = Color(0xFF151A25);      // Lighter Navy
  static const Color primaryAccent = Color(0xFF4169E1);  // Royal Blue
  static const Color greenColor = Color(0xFF00C853);     // Neon Green
  static const Color redColor = Color(0xFFFF3D00);       // Neon Red
  static const Color textWhite = Colors.white;
  static const Color textGrey = Colors.grey;

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryAccent,
      cardColor: cardColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    );
  }
}