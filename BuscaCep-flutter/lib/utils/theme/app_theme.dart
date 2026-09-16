import 'package:flutter/material.dart';

class AppTheme{
  static const primaryColor = Color(0xff6366f1);
  static const secondaryColor = Color(0xff8b5cf6);
  static const accentColor = Color(0xff06b6d4);
  static const surfaceColor = Color(0xfff8fafc);
  static const backgroundColor = Color(0xfffffbff);
  static const errorColor = Color(0xffef4444);
  static const successColor = Color(0xff10b981);
  static const warningColor = Color(0xfff59e0b);

  AppTheme._(); //Private Constructor - Blocks instances



  //First time creating light and dark themes :)
  static ThemeData get lightTheme{
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      scaffoldBackgroundColor: backgroundColor
    );
  }

  static ThemeData get darkTheme{
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: const Color(0xff1e293b)
      ),
      scaffoldBackgroundColor: const Color(0xff0f172a)
    );
  }

}