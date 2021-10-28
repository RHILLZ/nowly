import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:sizer/sizer.dart';

class CustomStripeButton extends StatelessWidget {
  const CustomStripeButton(
      {Key? key,
      required String label,
      required Function action,
      Color? btnColor})
      : _label = label,
        _action = action,
        _btnColor = btnColor,
        super(key: key);

  final String _label;
  final Function _action;
  final Color? _btnColor;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: ElevatedButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(90.w, 6.h)),
              backgroundColor: MaterialStateProperty.all(_btnColor),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
          onPressed: _action(),
          child: Text(
            _label.toUpperCase(),
            style: k16BoldTS,
            textAlign: TextAlign.center,
          )),
    );
  }
}
