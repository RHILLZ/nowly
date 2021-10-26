import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double kScreenPadding = 20.0;
const double kScreenPadding2 = 10.0;
const double kButtonInnerPadding = 25.0;
const double kIconMainButtonInnerPadding = 20.0;

const double kCardCornerRadius = 5.0;
const double kTesxtFieldCornerRadius = 5.0;
const double kButtonCornerRadius = 5.0;
const double kCardPadding = 10.0;
const double kBottomSheetPadding = 10.0;

const double kTitleBottomPadding = 15;
const double kListInnerPadding = 10;
const double kSoldOutItemsOpacity = 0.4;

const double kMaxContentWidth = 700.0;
const double kWorkOutCardBreakWidth = 375;

const double kContentGap = 10.0; // for product view screen

const double kChatBubblesBorderRadius = 15.0;

// ignore: avoid_classes_with_only_static_members
class UIParameters {
  static EdgeInsets get screenPadding => const EdgeInsets.all(kScreenPadding);
  static EdgeInsets get screenPaddingHorizontal =>
      const EdgeInsets.symmetric(horizontal: kScreenPadding);
  static EdgeInsets get screenPaddingVertical =>
      const EdgeInsets.symmetric(vertical: kScreenPadding);
  static EdgeInsets get buttonInnerPadding =>
      const EdgeInsets.all(kButtonInnerPadding);
  static EdgeInsets get iconMainButtonInnerPadding =>
      const EdgeInsets.all(kIconMainButtonInnerPadding);
  static EdgeInsets get cardPadding => const EdgeInsets.all(kCardPadding);
  static EdgeInsets get bottomSheetPadding =>
      const EdgeInsets.all(kBottomSheetPadding);
  static BorderRadius get cardCornerRadius =>
      BorderRadius.circular(kCardCornerRadius);
  static EdgeInsets get screenPadding2 => const EdgeInsets.all(kScreenPadding2);
  static BorderRadius get buttonBorderRadius =>
      BorderRadius.circular(kTesxtFieldCornerRadius);
  static BorderRadius get textFieldCornerRadius =>
      BorderRadius.circular(kTesxtFieldCornerRadius);

  static List<BoxShadow> getShadow(
          {Color? shadowColor,
          double spreadRadius = 3,
          double blurRadius = 12}) =>
      [
        BoxShadow(
          color: shadowColor ?? Get.theme.shadowColor,
          spreadRadius: spreadRadius,
          blurRadius: blurRadius,
          offset: const Offset(0, 3),
        ),
      ];

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static double getResponsizeCardWidth(BuildContext context, int count){
    final screenPadding = MediaQuery.of(context).viewPadding;
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth - (count * 20) - (screenPadding.left + screenPadding.right)) / count;
  }
}
