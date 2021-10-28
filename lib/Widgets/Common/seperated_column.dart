import 'package:flutter/material.dart';

class SeperatedColumn extends StatelessWidget {
  const SeperatedColumn(
      {Key? key,
      required this.children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      required this.separatorBuilder})
      : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final IndexedWidgetBuilder separatorBuilder;

  @override
  Widget build(BuildContext context) {
    final childrenWithSeperators = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      childrenWithSeperators.add(children[i]);

      if (children.length - 1 != i) {
        childrenWithSeperators.add(separatorBuilder(context, i));
      }
    }

    return Column(
      children: childrenWithSeperators,
    );
  }
}
