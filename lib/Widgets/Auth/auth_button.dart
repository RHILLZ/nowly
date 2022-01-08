import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:sizer/sizer.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {Key? key,
      this.iconPath,
      required this.title,
      required this.onPressed,
      Color? color = Colors.white,
      double? imageSize = 5})
      : _imageSize = imageSize,
        _color = color,
        super(key: key);

  final String? iconPath;
  final String title;
  final VoidCallback onPressed;
  final Color? _color;
  final double? _imageSize;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(width: 2.0, color: _color!),
          onSurface: Colors.white),
      onPressed: onPressed,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null)
              SvgPicture.asset(
                iconPath!,
                height: _imageSize!.h,
                color: _color,
              ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                title,
                style: k18BoldTS.copyWith(color: _color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
