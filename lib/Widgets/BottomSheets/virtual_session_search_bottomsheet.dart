import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

class VirtualSessionInitSearch extends StatelessWidget {
  const VirtualSessionInitSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: kMainButtonGradient(context),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeartbeatProgressIndicator(
                  child: SvgPicture.asset(
                'assets/icons/logo_outlined.svg',
                height: 8.h,
              )),
              SizedBox(
                height: 4.h,
              ),
              const Center(
                  child: Text(
                'Searching for trainer...',
                style: k16BoldTS,
              )),
              SizedBox(
                height: 2.h,
              ),
              JumpingDotsProgressIndicator(
                numberOfDots: 4,
                fontSize: 20,
                color: kPrimaryColor,
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                      label: const Text('cancel')))
            ]));
  }
}
