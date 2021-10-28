import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';

class RoundedCornerButton extends StatelessWidget {
  const RoundedCornerButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.isSelected = false,
    this.radius = 10,
    this.color,
    this.enableShadows = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;
  final bool isSelected;
  final double radius;
  final Color? color;
  final bool enableShadows;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: Ink(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              boxShadow: enableShadows
                  ? UIParameters.getShadow(spreadRadius: 5, blurRadius: 5)
                  : null,
              color: isSelected
                  ? getWidgetSelectedColor(context)
                  : color ?? Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(radius)),
          child: child),
    );
  }
}
