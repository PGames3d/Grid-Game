import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
  static Color lightPrimaryColor = const Color(0xff383641);
  static Color lightSecondaryColor = const Color(0xff383641);
  static Color lightAccentColor = const Color(0xff383641);
  static Color lightParticlesColor = const Color(0x44948282);
  static Color lightTextColor = Colors.black54;
  static Color primaryDark = const Color(0xffE32D91);

  const AppTheme._();

  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: "poppins_semibold",
      secondaryHeaderColor: lightPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.white,
      primaryColorLight: lightPrimaryColor,
      primaryColor: lightPrimaryColor,
      backgroundColor: lightBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(backgroundColor: lightPrimaryColor),
      colorScheme: ColorScheme.light(secondary: lightSecondaryColor),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(backgroundColor: lightBackgroundColor)));

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: lightPrimaryColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: lightBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
