import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:shimmer/shimmer.dart';

class UserNavigatorIndicatorDetailedBanner
    extends GetView<MapNavigatorController> {
  const UserNavigatorIndicatorDetailedBanner(
      {Key? key, required this.sessionController})
      : super(key: key);
  final TrainerInPersonSessionController sessionController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.curruntSessionController.value == null
          ? const SizedBox()
          : GestureDetector(
              onTap: () {
                controller.navigateToCurrentSessionDetailsScreen();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (controller.hasThisOnGoingNavigation(sessionController) ==
                      NavigationStatus.thisIsnt)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                          'Cancel actived navigation before continue with this',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kerroreColor)),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DefaultTextStyle(
                      style: k16RegularTS,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                const Icon(Icons.navigate_next,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RectButton(
                            fillColor: kerroreColor,
                            title: 'Cancel',
                            onPressed: () {
                              controller.endNavigations();
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RectButton(
                            fillColor: getWidgetSelectedColor(context),
                            title: 'View',
                            onPressed: () {
                              controller
                                  .navigateToCurrentSessionDetailsScreen();
                            }),
                      ),
                    ],
                  )
                ],
              )),
    );
  }
}
