import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
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
          const Center(
              child: Text(
            'Locating a trainer...',
            style: k16BoldTS,
          )),
          SizedBox(
            height: 2.h,
          ),
          const CircularProgressIndicator(),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  // kill();
                  Get.isBottomSheetOpen != null ? Get.back() : null;
                },
                child: const Icon(
                  Icons.close,
                  size: 40,
                )),
          )
        ],
      ),
    );
  }
}
