import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sala_shop_app/shared/styles/colors.dart';

ThemeData darkThemes = ThemeData(
  scaffoldBackgroundColor: Colors.white12,
  fontFamily: 'Jannah',
  primarySwatch: defultColors,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defultColors,
    elevation: 20,
    unselectedItemColor: Colors.black,
    backgroundColor: Colors.black12,
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      height: 1.5,
    ),
  ),
);

ThemeData lightThemes = ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: defultColors,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defultColors,
    elevation: 20,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white12,
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
      fontSize: 18.0,
      height: 1.5,
    ),
  ),
);
