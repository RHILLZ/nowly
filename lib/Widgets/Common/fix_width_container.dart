import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';


class FixedWidthContainer extends StatelessWidget {
  const FixedWidthContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
      child: child,
    );
  }
}
