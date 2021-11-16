import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nowly/Configs/configs.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    this.iconPath,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String? iconPath;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 2.0, color: Colors.white),
          onSurface: Colors.white),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null)
            SvgPicture.asset(
              iconPath!,
              width: 25,
              color: Colors.white,
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              title,
              style: k18BoldTS.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
