import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class MessagingScreen extends GetView<MessagingController> {
  const MessagingScreen({Key? key}) : super(key: key);
  static const routeName = '/messagingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color.fromARGB(255, 2, 12, 50),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CloseButton(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kScreenPadding),
                    child: Text(
                      'MIKE T.',
                      style: k20BoldTS.copyWith(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kScreenPadding),
                    child: Text(
                      '963 Madyson Drive ',
                      style: kRegularTS.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return !controller.isFinishedLoading.value
                  ? const Center(
                      child: SpinKitFadingFour(
                        color: kPrimaryColor,
                        size: 50.0,
                      ),
                    )
                  : AnimatedList(
                      key: controller.listKey,
                      reverse: true,
                      padding: UIParameters.screenPadding,
                      initialItemCount: controller.chat.length,
                      itemBuilder: (BuildContext context, int index,
                          Animation<double> animation) {
                        if (controller.me.id ==
                            controller.chat[index].user.id) {
                          // my message
                          return ScaleTransition(
                              scale: animation,
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MyChatBubble(
                                      message: controller.chat[index].message,
                                    ),
                                  ],
                                ),
                              ));
                        }
                        return ScaleTransition(
                            scale: animation,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ChatBubble(
                                    message: controller.chat[index].message,
                                    profileImage: controller
                                        .chat[index].user.profileImage,
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
            }),
          ),
          const Divider(
            height: 0,
          ),
          SingleChildScrollView(
            padding: UIParameters.screenPadding,
            scrollDirection: Axis.horizontal,
            child: SafeArea(
              left: false,
              top: false,
              right: false,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Get.width * 1.5,
                ),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                      QuickResponse.quickResponses.length,
                      (index) => Message(
                          label: QuickResponse.quickResponses[index].message,
                          onTap: () {
                            controller.addMessage(
                                QuickResponse.quickResponses[index].message);
                          })),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
