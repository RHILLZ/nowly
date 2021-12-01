import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:sizer/sizer.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    Key? key,
    required this.workOutType,
  }) : super(key: key);

  final WorkoutType workOutType;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
                bottom: 0,
                right: 5.w,
                top: 0,
                child: SvgPicture.asset(
                  workOutType.headerData[0].imagePath,
                  // alignment: Alignment.bottomRight,
                  height: 20.h,
                  // fit: BoxFit.contain,
                )),
            Positioned(
                top: 10,
                right: 0,
                left: 0,
                child: Image.asset(
                  'assets/logo/logo-w.png',
                  height: 3.h,
                  // color: Colors.white,
                )),
            Positioned(
                top: 8.h,
                left: kScreenPadding,
                child: Text(
                  workOutType.headerData[0].title.toUpperCase(),
                  style: k18BoldTS,
                )),
            Positioned(
                top: 12.h,
                left: kScreenPadding,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: 55.w,
                    child: Text(
                      workOutType.headerData[0].description,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                )),
          ],
        ),
      ),
      decoration: BoxDecoration(gradient: homeCoverGradient(context)),
    );
  }
}
