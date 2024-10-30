import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF24786D);
  static const Color secondaryColor = Color(0xFFF1F6FA);
  static const Color errorColor = Color(0xFFFF2D1B);
  static const Color outLineColor = Color(0xFF363F3B);
  static const Color disabledColor = Color(0xFF797C7B);
  static const Color onlineColor = Color(0xFF0FE16D);
  static const Color offlineColor = Color(0xFF9A9E9C);

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
          fontFamily: "Caros",
          fontSize: 20,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: "Caros",
          fontSize: 52,
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontFamily: "Caros",
          fontSize: 20,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          fontFamily: "Caros",
          fontSize: 18,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontFamily: "Caros",
          fontSize: 16,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontFamily: "Caros",
          fontSize: 14,
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          fontFamily: "Caros",
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
         error: errorColor,
         outline: outLineColor, 
      ),
          canvasColor: Colors.black,
      
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      disabledColor: disabledColor,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: "Caros",
          fontSize: 20,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: "Caros",
          fontSize: 52,
          color: Colors.white,
        ),
         headlineMedium: TextStyle(
          fontFamily: "Caros",
          fontSize: 20,
          color: Colors.white,
        ),
        headlineSmall: TextStyle(
          fontFamily: "Caros",
          fontSize: 18,
          color: Colors.white,
        ),
       bodyLarge: TextStyle(
          fontFamily: "Caros",
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontFamily: "Caros",
          fontSize: 14,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontFamily: "Caros",
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
        secondary: secondaryColor,
        error: errorColor,
        outline: outLineColor,
      ),
      canvasColor: Colors.white,
     
    );
  }
}
