import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nowly/Configs/configs.dart';
import '../widget_exporter.dart';

class SessionLengthCard extends StatelessWidget {
  const SessionLengthCard({
    Key? key,
    required this.imagePath,
    required this.length,
    required this.cost,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final String imagePath;
  final String length;
  final String cost;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RoundedCornerButton(
        isSelected: isSelected,
        onTap: onTap,
        child: Padding(
          padding: UIParameters.screenPadding2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                SvgPicture.asset(
                  imagePath,
                  color: isSelected
                      ? getSelectedTxtColor(context) ?? Colors.white
                      : Theme.of(context).iconTheme.color,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  length,
                  style: isSelected
                      ? kRegularTS.copyWith(color: getSelectedTxtColor(context))
                      : kRegularTS,
                ),
                Text(
                  cost,
                  style: isSelected
                      ? kRegularTS.copyWith(color: getSelectedTxtColor(context))
                      : kRegularTS,
                )
              ],
            ),
          ),
        ));
  }
}
