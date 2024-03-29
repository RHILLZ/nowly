import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nowly/Configs/themes/ui_parameters.dart';

class Logo {
  static textLogoW(BuildContext context, double size) {
    return Image.asset(
      'assets/logo/logo-w.png',
      height: size,
    );
  }

  static textLogoLD(BuildContext context, double size) {
    return UIParameters.isDarkMode(context)
        ? Image.asset(
            'assets/logo/logo-w.png',
            height: size,
          )
        : Image.asset(
            'assets/logo/logo-b.png',
            height: size,
          );
  }

  static squareLogoLD(BuildContext context, double size) {
    return UIParameters.isDarkMode(context)
        ? Image.asset(
            'assets/logo/logo-bgSW.png',
            height: size,
          )
        : Image.asset(
            'assets/logo/logo-bgSB.png',
            height: size,
          );
  }

  static rectangleLogoLD(BuildContext context, double size) {
    return UIParameters.isDarkMode(context)
        ? Image.asset(
            'assets/logo/logo-bgRW.png',
            height: size,
          )
        : Image.asset(
            'assets/logo/logo-bgRO.png',
            height: size,
          );
  }

  static mark(double size) {
    return SvgPicture.asset(
      'assets/logo/mark.svg',
      height: size,
    );
  }
}
