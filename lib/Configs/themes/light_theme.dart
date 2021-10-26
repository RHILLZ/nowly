import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'sub_theme_data_mixin.dart';

const Color appBarIconColorLT = Colors.black;
const Color mainTextColor = Color.fromARGB(255, 1, 14, 60);
const Color iconColorLT = Color.fromARGB(255, 1, 14, 60);
const Color shadowColorLT = Color.fromARGB(90, 172, 172, 172);
const Color cardColorLT = Color.fromARGB(255, 242, 242, 242);
const Color scaffoldBackgroundColor = Color.fromARGB(255, 252, 252, 252);

class LightTheme with SubThemeData {
  ThemeData buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        primaryColor: mainTextColor,
        textTheme: getTextThemes()
            .copyWith(
              subtitle1: const TextStyle(color: mainTextColor),
            )
            .apply(bodyColor: mainTextColor, displayColor: mainTextColor),
        primaryColorDark: Colors
            .white30, //effects few widgets eg : circular avatar background color
        appBarTheme: getAppBarTheme().copyWith(
          iconTheme: const IconThemeData(color: appBarIconColorLT),
          backgroundColor: scaffoldBackgroundColor,
          elevation: 0,
           titleTextStyle: const TextStyle(
              color: mainTextColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        colorScheme: ColorScheme.fromSwatch(
                // for date picker , scroll glow
                accentColor: kPrimaryColor,
                brightness: Brightness.light)
            .copyWith(
          primary: kPrimaryColor,
        ),
        iconTheme: const IconThemeData(color: iconColorLT),
        inputDecorationTheme: getInputDecoration(),
        textSelectionTheme: getTextSelectionTheme(),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: mainTextColor)),
        bottomAppBarTheme: getBottomAppBarTheme(),
        cardTheme: getCardTheme()
            .copyWith(shadowColor: shadowColorLT, color: cardColorLT),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: getElevatedButtonThemeStyle().merge(ElevatedButton.styleFrom(
          shadowColor: shadowColorLT,
        ))),
        cardColor: cardColorLT,
        tabBarTheme: getTabBarTheme().copyWith(labelColor: mainTextColor),
        radioTheme: getRadioThemeData(),
        splashColor: kGray.withOpacity(0.2),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: getOutLinedTheme()
                .merge(OutlinedButton.styleFrom(primary: mainTextColor))),
        // highlightColor: kMediumGrayColor.withOpacity(0.1),
        bottomNavigationBarTheme: getBottomNavigationBarTheme()
            .copyWith(backgroundColor: Colors.white),
        shadowColor: shadowColorLT);
  }
}
