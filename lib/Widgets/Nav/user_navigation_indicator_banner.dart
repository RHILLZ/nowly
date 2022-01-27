import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:shimmer/shimmer.dart';

class UserNavigatorIndicatorBanner extends GetView<MapNavigatorController> {
  const UserNavigatorIndicatorBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.curruntSessionController.value == null
          ? const SizedBox()
          : DefaultTextStyle(
              style: k16RegularTS,
              child: GestureDetector(
                onTap: () {
                  controller.navigateToCurrentSessionDetailsScreen();
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Shimmer.fromColors(
                        child: Container(
                          color: Colors.blue,
                        ),
                        baseColor: kuserNavigationIndicatorCOlor,
                        highlightColor: Colors.lightBlueAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.navigation_rounded,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                      text: 'You are on the way to '),
                                  TextSpan(
                                      text: controller
                                          .curruntSessionController
                                          .value!
                                          .trainerSession
                                          .trainer
                                          .firstName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  // const TextSpan(
                                  //   text: " 's session"
                                  // ),
                                ]),
                              ),
                            ),
                          ),
                          const Icon(Icons.navigate_next, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              //  Row(
              //   children: [
              //     Expanded(
              //         child: Text(
              //             'You are on the way to ${controller.curruntSessionController.value!.trainerSession.trainer.name} \'s session'))
              //   ],
              // ),
              ),
    );
  }
}
