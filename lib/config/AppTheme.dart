import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/config/AppColors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primaryColorLight: Colors.black45,
    primaryColor: primary,
    scaffoldBackgroundColor: Color(0xfff7f8fa),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.grey,
      onPrimary: Colors.black,
      primaryVariant: Colors.black54,
      surface: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    primaryTextTheme: TextTheme(
      headline1: TextStyle(color: Colors.red, fontSize: 12),
      headline3: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
        color: Colors.black87,
      ),
      headline5: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
        color: primary,
      ),
    ),
    textTheme: TextTheme(
      //  bodyText1: TextStyle(color: Colors.white54, height: 1.5, fontSize: 12),
      headline1: TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
      ),
      subtitle2: TextStyle(color: Colors.black, height: 1.5, fontSize: 12),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Color(0xff131722),
    primaryColor: primary,
    appBarTheme: AppBarTheme(
      color: surface,
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.grey,
      onPrimary: Colors.white,
      primaryVariant: Colors.white54,
      surface: surface,
    ),
    cardColor: surface,
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    primaryTextTheme: TextTheme(
      headline1: TextStyle(color: Colors.red, fontSize: 12),
      headline3: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline5: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
        color: primary,
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Colors.white70,
        fontSize: 14.0,
      ),
      subtitle2: TextStyle(color: Colors.white54, height: 1.5, fontSize: 12),
    ),
  );
}
