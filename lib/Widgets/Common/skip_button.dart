import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Screens/Nav/base_screen.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            minimumSize: const Size(50, 30),
            backgroundColor: UIParameters.isDarkMode(context)
                ? Colors.white.withOpacity(0.4)
                : Colors.white.withOpacity(0.8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: () {
          Get.to(BaseScreen());
        },
        child: Text(
          'Skip',
          style: UIParameters.isDarkMode(context)
              ? k16LightdGrayTS.copyWith(color: Colors.grey[400])
              : k16LightdGrayTS,
        ));
  }
}
