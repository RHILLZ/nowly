import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.onSelecte,
      required this.child,
      this.borderRadius = 6,
      this.isSelected = false,
      this.decoration,
      this.padding})
      : super(key: key);

  final VoidCallback onSelecte;
  final Widget child;
  final double borderRadius;
  final bool isSelected;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onSelecte,
      child: Ink(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: child,
        decoration: decoration ??
            BoxDecoration(
                color: isSelected
                    ? getWidgetSelectedColor(context)
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      ),
    );
  }
}
