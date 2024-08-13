import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3190B7)),
      useMaterial3: true,
      // Konfigurasi font default
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontFamily: 'Poppins'),
        bodyLarge: TextStyle(fontFamily: 'Poppins'),
        bodyMedium: TextStyle(fontFamily: 'Poppins'),
      ),
    );
  }
}

const double tinySize = 10;
const double smallSize = 12;
const double regularSize = 14;
const double mediumSize = 16;
const double largeSize = 18;

const primaryColor = Color(0xFF3190B7);
const secondaryColor = Color(0xFF4FCEEA);
const blackColor = Color(0xFF1E1E1E);
const whiteBlueColor = Color(0xFFF1F1F4);
const whiteBackground1Color = Color(0xFFF5F6FA);
const whiteBackground2Color = Color(0xFFF6F6F6);
const abuMedColor = Color(0xFF6B7280);
const abuLightColor = Color(0xFFD1D5DB);
const abuDarkColor = Color(0xFF374151);

TextStyle regular = GoogleFonts.poppins(fontWeight: FontWeight.w400);
TextStyle medium = GoogleFonts.poppins(fontWeight: FontWeight.w500);
TextStyle semiBold = GoogleFonts.poppins(fontWeight: FontWeight.w600);
TextStyle bold = GoogleFonts.poppins(fontWeight: FontWeight.w700);
