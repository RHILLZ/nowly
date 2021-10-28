import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

class FutureSessionSearchIndicator extends StatelessWidget {
  const FutureSessionSearchIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: .65,
        builder: (context, _) => Container(
              decoration: BoxDecoration(
                  gradient: infoCardGradient(context),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: const EdgeInsets.all(kScreenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Searching for trainer..'.toUpperCase(),
                    style: k16BoldTS,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  JumpingDotsProgressIndicator(fontSize: 30),
                  SizedBox(
                    height: 5.h,
                  ),
                  HeartbeatProgressIndicator(
                      child: SvgPicture.asset(
                    'assets/icons/logo.svg',
                    height: 6.h,
                  )),
                  SizedBox(height: 5.h),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        size: 40,
                      ))
                ],
              ),
            ));
  }
}
