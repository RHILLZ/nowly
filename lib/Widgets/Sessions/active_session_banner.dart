import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Messaging/messaging_screen.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ActiveSessionBanner extends StatelessWidget {
  ActiveSessionBanner({Key? key, required SessionController controller})
      : _controller = controller,
        super(key: key);

  final SessionController _controller;

  final MessagingController _mController = Get.put(MessagingController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.currentSession == null
          ? const SizedBox()
          : GestureDetector(
              onTap: () {
                // _controller.navigateToCurrentSessionDetailsScreen();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (_controller.hasThisOnGoingNavigation(_controller) ==
                  //     NavigationStatus.thisIsnt)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                        'May message to trainer to coordinate meeting area',
                        textAlign: TextAlign.center,
                        style: k10BoldTS.copyWith(fontSize: 14)),
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
                                height: 20.h,
                                color: Colors.blue,
                              ),
                              baseColor: kPrimaryColor,
                              highlightColor: kerroreColor,
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    child: RichText(
                                      text: TextSpan(
                                          style: kRegularTS,
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'You should be on your way to meet ',
                                            ),
                                            TextSpan(
                                                text:
                                                    '${_controller.currentSession.trainerName.split(' ')[0]}',
                                                style: k16BoldTS),
                                            TextSpan(
                                              text:
                                                  ' and should arrive in ${_controller.currentSession.eta}.',
                                            ),
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
                      SizedBox(
                        width: 40.w,
                        child: RectButton(
                            fillColor: kLightGray,
                            title: 'Cancel',
                            onPressed: () {
                              _controller.cancel(context);
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(() => Badge(
                            showBadge: _mController.showBadge,
                            badgeColor: kPrimaryColor,
                            badgeContent: const Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                            ),
                            child: RectButton(
                                fillColor: getWidgetSelectedColor(context),
                                title: 'Message',
                                onPressed: () {
                                  final session = _controller.currentSession;
                                  _mController.showBadge = false;
                                  Get.to(
                                      () => MessagingScreen(session: session));
                                }),
                          )),
                    ],
                  )
                ],
              )),
    );
  }
}
