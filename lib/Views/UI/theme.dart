import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xff1A1B22),
      surfaceTintColor: Color(0xff1A1B22),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    colorScheme: const ColorScheme(
        primary: Color(0xffFF4D67),
        secondary: Color(0xff2A2B39),
        surface: Colors.white,
        background: Colors.white,
        error: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Color(0xff2A2B39),
        onSurface: Color(0xff1A1B22),
        onBackground: Color(0xff342833),
        onError: Color(0xff1A1B22),
        brightness: Brightness.dark,
        shadow: Colors.black,
        tertiary: Color(0xff9E9E9E)),
    scaffoldBackgroundColor: Color(0xff1A1B22),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.palanquin(
        fontSize: 30,
        height: 1.2,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        height: 1.2,
        fontWeight: FontWeight.w500,
        color: Color(0xffA9AAAC),
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 13,
        height: 1.2,
        fontWeight: FontWeight.w500,
        color: Color(0xffA9AAAC),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      surfaceTintColor: Color(0xff1A1B22),
      iconTheme: IconThemeData(color: Colors.white, size: 30),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffFF4D67),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    
    
    
  );
}
