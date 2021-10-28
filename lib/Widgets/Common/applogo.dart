import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    this.width,
    this.isDarkText = false,
  }) : super(key: key);

  final double? width;
  final bool isDarkText;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        isDarkText
            ? 'assets/images/logo_with_text_dark.svg'
            : 'assets/images/logo_with_text_light.svg',
        fit: BoxFit.contain,
        width: width );
  }
}
