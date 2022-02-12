import 'app_colors.dart';
import 'package:flutter/material.dart';
import 'sub_theme_data_mixin.dart';

const Color scaffoldBackgroundColorDT = Color.fromARGB(255, 14, 14, 18);
const Color cardColorDT = Color.fromARGB(255, 30, 30, 30);
const Color appBarIconColorDT = Colors.white;
const Color shadowColorDT = Color.fromARGB(120, 10, 10, 10);
const Color bottomNavBarBackgroundColor = Color.fromARGB(255, 25, 30, 40);

class DarkTheme with SubThemeData {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
        primaryColor: const Color.fromARGB(255, 26, 37, 81),
        cardColor: cardColorDT,
        textTheme: getTextThemes(),
        primaryColorLight:
            cardColorDT, //effects few widgets eg : circular avatar background color
        colorScheme: ColorScheme.fromSwatch(
          accentColor: kPrimaryColor,
          brightness: Brightness.dark,
        ).copyWith(primary: kPrimaryColor),
        scaffoldBackgroundColor: scaffoldBackgroundColorDT,
        appBarTheme: getAppBarTheme().copyWith(
            backgroundColor: scaffoldBackgroundColorDT,
            iconTheme: const IconThemeData(color: appBarIconColorDT)),
        inputDecorationTheme: getInputDecoration().copyWith(
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: kGray)),
        ),
        textSelectionTheme: getTextSelectionTheme(),
        textButtonTheme: TextButtonThemeData(style: getTextButtomTheme()),
        bottomAppBarTheme: getBottomAppBarTheme(),
        cardTheme: getCardTheme()
            .copyWith(color: cardColorDT, shadowColor: shadowColorDT),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: getElevatedButtonThemeStyle().merge(ElevatedButton.styleFrom(
                shadowColor: kPrimaryColor.withOpacity(0.5)))),
        radioTheme: getRadioThemeData(),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.black.withOpacity(0.2),
        tabBarTheme: getTabBarTheme(),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: getOutLinedTheme()
                .merge(OutlinedButton.styleFrom(primary: kGray))),
        bottomNavigationBarTheme: getBottomNavigationBarTheme().copyWith(
            backgroundColor: bottomNavBarBackgroundColor,
            unselectedItemColor: scaffoldBackgroundColorDT),
        shadowColor: shadowColorDT);
  }
}
