import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF24786D);
  static const Color primaryColorLight = Color(0xFF81CBC2);
  static const Color secondaryColor = Color(0xFFF2F7FB);
  static const Color secondaryDarkColor = Color(0xFF353535);
  static const Color secondaryContainerDarkColor = Color(0xFF4C525A);
  static const Color secondaryContainerColor = Color(0x884C525A);
  static const Color errorColor = Color(0xFFFF2D1B);
  static const Color outLineColor = Color(0xFF363F3B);
  static const Color disabledColor = Color(0xFF7F7F7F);
  static const Color onlineColor = Color(0xFF0FE16D);
  static const Color callingColor = Color(0xFF1CB536);
  static const Color offlineColor = Color(0xFF9A9E9C);
  static const String fontFamily = "Caros";

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      disabledColor: disabledColor,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: fontFamily,
          fontSize: 20,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: const TextTheme(
         displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 52,
          color: Colors.black,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 30,
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          height: 2,
          color: Colors.black,
        ),
      ),
      
     iconTheme: const IconThemeData(
        color: primaryColor,
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        inverseSurface: secondaryDarkColor,
         error: errorColor,
         outline: outLineColor, 
          secondaryContainer: secondaryContainerColor
      ),
          canvasColor: Colors.black,
      
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      disabledColor: disabledColor,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: fontFamily,
          fontSize: 20,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: const TextTheme(
         displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 52,
          color: Colors.white,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 30,
          color: Colors.white,
        ),
         headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          color: Colors.white,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          color: Colors.white,
        ),
       bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          height: 2,
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(
        color: secondaryColor,
      ),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryDarkColor,
        inverseSurface: secondaryColor,
        error: errorColor,
        outline: outLineColor,
        onSurface: Colors.white,
        secondaryContainer: secondaryContainerDarkColor
      ),
      canvasColor: Colors.white,
     
    );
  }
}
