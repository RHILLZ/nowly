import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.title = 'LET’S GO!',
    required this.onTap,
    this.enabled = true,
    this.cornerRadius = 4,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool enabled;
  final double cornerRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: InkWell(
        onTap: enabled == false ? null : onTap,
        child: Ink(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child:
                  Text(title, style: k16BoldTS.copyWith(color: Colors.white)),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cornerRadius),
              color: enabled == false ? kGray.withOpacity(0.3) : null,
              gradient: enabled == false ? null : kMainButtonGradient(context)),
        ),
      ),
    );
  }
}
