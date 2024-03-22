import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socioverse/Views/UI/themeColors.dart';

class MyTheme {
  static ThemeData theme() {
    return ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ThemeColors.bottomSheetBackground,
        surfaceTintColor: ThemeColors.bottomSheetSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      colorScheme: const ColorScheme(
          primary: ThemeColors.primary,
          secondary: ThemeColors.secondary,
          surface: ThemeColors.surface,
          background: ThemeColors.background,
          error: ThemeColors.error,
          onPrimary: ThemeColors.onPrimary,
          onSecondary: ThemeColors.onSecondary,
          onSurface: ThemeColors.onSurface,
          onBackground: ThemeColors.onBackground,
          onError: ThemeColors.onError,
          brightness: Brightness.dark,
          shadow: Colors.black,
          tertiary: ThemeColors.tertiary),
      scaffoldBackgroundColor: ThemeColors.scaffoldBackground,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.palanquin(
          fontSize: 30,
          height: 1.2,
          color: ThemeColors.surface,
        ),
        bodyMedium: GoogleFonts.openSans(
          fontSize: 14,
          height: 1.2,
          fontWeight: FontWeight.w500,
          color: ThemeColors.bodyText,
        ),
        bodySmall: GoogleFonts.openSans(
          fontSize: 13,
          height: 1.2,
          fontWeight: FontWeight.w500,
          color: ThemeColors.bodyText,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: ThemeColors.appBarColor,
        surfaceTintColor: ThemeColors.appBarSurface,
        iconTheme: IconThemeData(color: ThemeColors.surface, size: 30),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.elevatedButtonBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
