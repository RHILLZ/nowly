import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nowly/Configs/configs.dart';

class StaticsWidget extends StatelessWidget {
  const StaticsWidget({
    Key? key,
    required this.imagePath,
    required this.lable1,
    required this.lable2,
  }) : super(key: key);
  final String imagePath;
  final String lable1;
  final String lable2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            color: Theme.of(context).iconTheme.color,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              lable1,
              style: k10RegularTS,
            ),
          ),
          Text(lable2)
        ],
      ),
    );
  }
}
