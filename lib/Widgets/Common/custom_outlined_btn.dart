import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nowly/Configs/configs.dart';

class CustomOutLinedButton extends StatelessWidget {
  const CustomOutLinedButton({
    Key? key,
    this.iconPath,
    required this.title,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final String? iconPath;
  final String title;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(width: 2.0, color: color ?? Colors.white),
          onSurface: color ?? Colors.white),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null)
            SvgPicture.asset(
              iconPath!,
              width: 25,
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              title,
              style: k18BoldTS.copyWith(color: color ?? Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
