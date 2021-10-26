import 'package:flutter/material.dart';

import '../configs.dart';

const Color kPrimaryColor = Color.fromARGB(255, 240, 107, 52);
const Color kButtonTextGrayColor = Color.fromARGB(255, 150, 150, 150);
const Color kGray = Color.fromARGB(255, 102, 102, 102);
const Color kDisabledGray = Color.fromARGB(255, 200, 200, 200);
const Color kLightGray = Color.fromARGB(120, 100, 100, 100);
const Color kActiveButtonColor = Color.fromARGB(255, 1, 15, 60);
const Color kActiveColor = Color.fromARGB(255, 45, 168, 0);
const Color kerroreColor = Colors.red;
const Color kuserNavigationIndicatorCOlor = Colors.blue;

const Color cardSelectedColorLighMode = Color.fromARGB(255, 1, 14, 62);
const Color cardSelectedColorDarkMode = Color.fromARGB(255, 64, 69, 79);

LinearGradient kMainButtonGradient(BuildContext context) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: UIParameters.isDarkMode(context)
        ? const [
            Color.fromARGB(255, 56, 83, 122),
            Color.fromARGB(255, 60, 86, 130),
          ]
        : const [
            Color.fromARGB(255, 247, 108, 63),
            Color.fromARGB(255, 247, 180, 0),
          ]);

LinearGradient homeCoverGradient(BuildContext context) {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      colors: UIParameters.isDarkMode(context)
          ? const [
              Color.fromARGB(255, 20, 20, 30),
              Color.fromARGB(255, 25, 25, 40),
            ]
          : const [
              Color.fromARGB(255, 26, 37, 81),
              Color.fromARGB(225, 55, 70, 130),
            ]);
}

LinearGradient scaffoldGradient(BuildContext context) {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: UIParameters.isDarkMode(context)
          ? [
              const Color.fromARGB(255, 40, 55, 80),
              //const Color.fromARGB(255, 20, 35, 60),
              const Color.fromARGB(255, 15, 15, 15),
            ]
          : [
              const Color.fromARGB(255, 254, 254, 254),
              const Color.fromARGB(255, 250, 250, 250),
            ]);
}

LinearGradient onBoardingGradient(BuildContext context) {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: UIParameters.isDarkMode(context)
          ? [
              const Color.fromARGB(255, 40, 55, 80),
              const Color.fromARGB(255, 15, 15, 15),
            ]
          : [
              const Color.fromARGB(255, 253, 172, 115),
              const Color.fromARGB(255, 235, 120, 75),
            ]);
}

LinearGradient authPagesGradient(BuildContext context) {
  return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [
        0.4,
        0.95,
      ],
      colors: UIParameters.isDarkMode(context)
          ? [
              const Color.fromARGB(255, 40, 55, 80),
              const Color.fromARGB(255, 15, 15, 15),
            ]
          : [
              const Color.fromARGB(255, 240, 107, 52),
              const Color.fromARGB(255, 240, 145, 50),
            ]);
}

RadialGradient trainingConfirmationCardGradient(BuildContext context) {
  return RadialGradient(
      radius: 0.85,
      colors: UIParameters.isDarkMode(context)
          ? const [
              Color.fromARGB(255, 40, 55, 80),
              Color.fromARGB(255, 20, 20, 40),
            ]
          : const [
              Color.fromARGB(225, 55, 70, 130),
              Color.fromARGB(255, 26, 37, 81),
            ]);
}

Color geDisabledColor(BuildContext context) => UIParameters.isDarkMode(context)
    ? cardSelectedColorDarkMode
    : kDisabledGray;

Color getWidgetSelectedColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? cardSelectedColorDarkMode
        : cardSelectedColorLighMode;

Color? getSelectedTxtColor(BuildContext context) =>
    UIParameters.isDarkMode(context) ? null : Colors.white;

Color getExpandedCardBodyColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? const Color.fromARGB(255, 50, 50, 50)
        : Theme.of(context).scaffoldBackgroundColor;

Color geMessageColor(BuildContext context) => UIParameters.isDarkMode(context)
    ? const Color.fromARGB(255, 64, 69, 79)
    : Colors.white;

Color myChatBubbleColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? const Color.fromARGB(255, 56, 83, 122)
        : kPrimaryColor;

Color chatBubbleColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? const Color.fromARGB(255, 64, 69, 78)  //rgba(64, 69, 78, 1)
        : const Color.fromARGB(255, 237, 237, 237);
