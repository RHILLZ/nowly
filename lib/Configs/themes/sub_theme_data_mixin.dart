import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../configs.dart';

mixin SubThemeData {
  AppBarTheme getAppBarTheme() {
    return const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
  }

  BottomAppBarTheme getBottomAppBarTheme() {
    return const BottomAppBarTheme(color: Colors.transparent, elevation: 0);
  }

  TextTheme getTextThemes() {
    // return const TextTheme(
    //     bodyText1: TextStyle(fontWeight: FontWeight.bold),
    //     bodyText2: TextStyle(fontWeight: FontWeight.bold));
    return GoogleFonts.latoTextTheme(const TextTheme(
        bodyText1: TextStyle(fontWeight: FontWeight.bold),
        bodyText2: TextStyle(fontWeight: FontWeight.bold)));
  }

  InputDecorationTheme getInputDecoration() {
    return InputDecorationTheme(
      fillColor: kGray.withOpacity(0.05),
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kGray),
          borderRadius: UIParameters.textFieldCornerRadius),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kerroreColor),
          borderRadius: UIParameters.textFieldCornerRadius),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kerroreColor),
          borderRadius: UIParameters.textFieldCornerRadius),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: UIParameters.textFieldCornerRadius),
    );

    ///Input decorations sample 2
    // return InputDecorationTheme(
    //   fillColor: kGray.withOpacity(0.05),
    //   filled: true,
    // );
  }

  TextSelectionThemeData getTextSelectionTheme() {
    return const TextSelectionThemeData();
  }

  ButtonStyle getTextButtomTheme() {
    return TextButton.styleFrom(primary: Colors.white);
  }

  ButtonStyle getOutLinedTheme() {
    return OutlinedButton.styleFrom();
  }

  ButtonStyle getElevatedButtonThemeStyle() {
    return ElevatedButton.styleFrom();
  }

  CardTheme getCardTheme() {
    return const CardTheme();
  }

  BottomSheetThemeData getBottomSheetTheme() {
    return const BottomSheetThemeData();
  }

  BottomNavigationBarThemeData getBottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false);
  }

  TabBarTheme getTabBarTheme() {
    return const TabBarTheme();
  }

  RadioThemeData getRadioThemeData() {
    return const RadioThemeData();
  }
}
