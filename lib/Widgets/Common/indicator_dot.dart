import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';

class IndicatorDot extends StatelessWidget {
  const IndicatorDot({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: selected ? 1 : 0.7,
      child: Container(
        width: 12.0,
        height: 12.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (Theme.of(context).brightness == Brightness.dark
                    ? kGray.withOpacity(0.5)
                    : kGray)
                .withOpacity(selected ? 0.9 : 0.4)),
      ),
    );
  }
}
