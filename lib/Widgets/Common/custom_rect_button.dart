import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nowly/Configs/configs.dart';

class RectButton extends StatelessWidget {
  const RectButton({
    Key? key,
    this.iconPath,
    this.title,
    required this.onPressed,
    this.textStyle,
    this.showOutline = false,
    this.isSelected = false,
    this.child = const SizedBox(),
    this.fillColor,
  }) : super(key: key);

  final String? iconPath;
  final String? title;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final bool showOutline;
  final bool isSelected;
  final Color? fillColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: fillColor ??
              (isSelected
                  ? getWidgetSelectedColor(context)
                  : Theme.of(context).disabledColor.withOpacity(0.2)),
          side: showOutline
              ? null
              : isSelected
                  ? const BorderSide(width: 0.5, color: Colors.white)
                  : BorderSide(
                      width: 0.5, color: Colors.white.withOpacity(0.1)),
          onSurface: Colors.white),
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
            padding: EdgeInsets.all(title == null ? 15.0 : 18),
            child: title == null
                ? child
                : Text(
                    title!,
                    style: isSelected
                        ? k16BoldTS
                            .copyWith(color: Colors.white)
                            .merge(textStyle)
                        : k16BoldTS.merge(textStyle),
                  ),
          )
        ],
      ),
    );
  }
}

