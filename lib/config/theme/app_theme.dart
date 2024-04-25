import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hakawati/core/utils/constants.dart';

abstract class AppTheme {
// Dark Theme
  static ThemeData darkTheme = ThemeData(
    //fontFamily: 'ChrustyRock',
    primarySwatch: kPrimaryColor,
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
      fontSize: 15.0,
      color: Colors.white,
    )),
    scaffoldBackgroundColor: const Color(0XFF333739),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0XFF333739),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Color(0XFF333739),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 25.0,
      ),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0XFF333739),
    ),
  );

// Light Theme
  static ThemeData lightTheme = ThemeData(
    // fontFamily: 'ChrustyRock',
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
      fontSize: 15.0,
      color: Colors.black,
    )),
    primarySwatch: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 25.0,
      ),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
    ),
  );
}
