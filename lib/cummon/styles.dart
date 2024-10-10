import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFF6B38FB);
const Color darkPrimaryColor = Color(0xFF000000);
const Color darkSecondaryColor = Color(0xff64ffda);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.merriweather(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.merriweather(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.merriweather(fontSize: 46, fontWeight: FontWeight.w400),
  headlineLarge: GoogleFonts.merriweather(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineMedium: GoogleFonts.merriweather(
      fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  headlineSmall:
      GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.merriweather(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.merriweather(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.merriweather(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  bodySmall: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelLarge: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  labelMedium: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.25),
  labelSmall: GoogleFonts.libreFranklin(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: primaryColor,
        onPrimary: Colors.black,
        secondary: secondaryColor,
      ),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: const AppBarTheme(elevation: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);

// untuk dark Theme
ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: darkPrimaryColor,
        onPrimary: Colors.black,
        secondary: darkSecondaryColor,
      ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: const AppBarTheme(elevation: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);
