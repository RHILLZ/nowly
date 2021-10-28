import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.screenPadding,
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: child,
    );
  }
}
