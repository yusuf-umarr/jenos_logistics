import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jenos/scr/constant/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);

  /// The app was designed in a light theme mode so, there's no dark theme data
  /// for now
  // static final _darkTheme = ThemeData();

  static _themeData(ColorScheme colorScheme) => ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        textTheme: GoogleFonts.poppinsTextTheme(
          _textTheme(colorScheme),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      );

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: AppColors.primaryColor,
    onBackground: AppColors.dark,
    onSurface: AppColors.greyColor,
  );

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.onBackground,
        ),
        bodySmall: TextStyle(
          color: colorScheme.onBackground,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          // fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
        labelSmall: TextStyle(
          fontSize: 13,
          color: colorScheme.onBackground,
        ),
      );
}
