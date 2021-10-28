import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:sizer/sizer.dart';

import 'custom_card.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        onSelecte: onTap,
        isSelected: isSelected,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style:
                k16RegularTS.copyWith(color: isSelected ? Colors.white : null),
          ),
        ));
  }
}

class SmallTextCard extends StatelessWidget {
  const SmallTextCard({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.textStyle,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (textStyle != null) {
      textStyle!.copyWith(color: isSelected ? Colors.white : null);
    }
    return CustomCard(
        onSelecte: onTap,
        isSelected: isSelected,
        child: SizedBox(
          width: 35.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: textStyle ??
                    k10RegularTS.copyWith(
                        color: isSelected ? Colors.white : null, fontSize: 12),
              ),
            ),
          ),
        ));
  }
}
