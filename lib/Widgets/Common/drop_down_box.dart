import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';

class DropDownBox extends StatelessWidget {
  const DropDownBox({
    Key? key,
    required this.onTap,
    required this.title,
    required this.value,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardCornerRadius,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Ink(
        padding: UIParameters.cardPadding,
        decoration: BoxDecoration(
            border: Border.all(color: kGray),
            borderRadius: UIParameters.cardCornerRadius,
            color: kGray.withOpacity(0.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(value, style: k20BoldTS),
                const Icon(Icons.keyboard_arrow_down)
              ],
            )
          ],
        ),
      ),
    );
  }
}
