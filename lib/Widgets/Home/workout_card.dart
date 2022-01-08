import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:sizer/sizer.dart';

import '../widget_exporter.dart';

enum WorkOutCardType { seeMore, normal }

class WorkOutCard extends StatelessWidget {
  const WorkOutCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.isSelected,
    required this.onSelecte,
    this.child,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final bool isSelected;
  final VoidCallback onSelecte;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 20.h,
      child: CustomCard(
        borderRadius: 10,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
        child: child ??
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: SvgPicture.asset(
                    imagePath,
                    // fit: BoxFit.scaleDown,
                    height: 5.h,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: k10BoldTS.copyWith(
                        fontSize: 12, color: isSelected ? Colors.white : null),
                  ),
                )
              ],
            ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                  color: Theme.of(context).shadowColor)
            ],
            color: isSelected
                ? getWidgetSelectedColor(context)
                : Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(15.0))),
        onSelecte: onSelecte,
      ),
    );
  }
}

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('See more', textAlign: TextAlign.center),
        Icon(
          Icons.keyboard_arrow_down,
          size: 10.sp,
        )
      ],
    );
  }
}

class SeeLessButton extends StatelessWidget {
  const SeeLessButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('See less', textAlign: TextAlign.center),
        Icon(
          Icons.keyboard_arrow_up,
          size: 10.sp,
        )
      ],
    );
  }
}
