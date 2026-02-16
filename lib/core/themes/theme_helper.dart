import 'package:flutter/material.dart';
import 'package:codefest_travel_app/core/themes/custom_color_extension.dart';

class MyAppThemeHelper {
  // Define Satoshi TextTheme
  static TextTheme _satoshiTextTheme(Color textColor, Color displayColor) {
    return TextTheme(
      displayLarge: TextStyle(fontFamily: 'Satoshi', color: displayColor, fontSize: 57, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(fontFamily: 'Satoshi', color: displayColor, fontSize: 45, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(fontFamily: 'Satoshi', color: displayColor, fontSize: 36, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 32, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 28, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 24, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
        fontFamily: 'Satoshi',
        color: const Color(0xFF999999),
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ), // #999999 for subtext
      labelLarge: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontFamily: 'Satoshi', color: textColor, fontSize: 11, fontWeight: FontWeight.w500),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: const Color(0xFF000000), // Fully Black
        onPrimary: const Color(0xFFFFFFFF),
        primaryContainer: const Color(0xFF222222),
        secondary: const Color(0xFFF5F5F5),
        onSecondary: const Color(0xFF000000),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF000000),
        error: const Color(0xFFFF0000),
        onError: const Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
      fontFamily: 'Satoshi',
      textTheme: _satoshiTextTheme(const Color(0xFF000000), const Color(0xFF000000)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF000000)),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF000000),
        ),
      ),
      // appBarTheme: const AppBarTheme(
      //   backgroundColor: Colors.white,
      //   surfaceTintColor: Colors.white,
      //   titleTextStyle: TextStyle(
      //     fontFamily: 'Satoshi',
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.black,
      //   ),
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF000000),
          foregroundColor: const Color(0xFFFFFFFF),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          textStyle: const TextStyle(fontFamily: 'Satoshi', fontSize: 16, fontWeight: FontWeight.bold),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF000000), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      extensions: const [CustomColors.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: const Color(0xFF000000), // Black buttons in B&W theme
        onPrimary: const Color(0xFFFFFFFF),
        surface: const Color(0xFFFFFFFF), // White background
        onSurface: const Color(0xFF000000),
        error: const Color(0xFFFF0000),
        onError: const Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
      fontFamily: 'Satoshi',
      textTheme: _satoshiTextTheme(const Color(0xFF000000), const Color(0xFF000000)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        surfaceTintColor: Color(0xFFFFFFFF),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF000000)),
        titleTextStyle: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF000000),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF000000),
          foregroundColor: const Color(0xFFFFFFFF),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          textStyle: const TextStyle(fontFamily: 'Satoshi', fontSize: 16, fontWeight: FontWeight.bold),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF000000), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      extensions: const [CustomColors.dark],
    );
  }
}
