import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class MessagingScreen extends GetView<MessagingController> {
  MessagingScreen({Key? key, required SessionModel session})
      : _session = session,
        super(key: key);

  static const routeName = '/messagingScreen';
  final SessionModel _session;
  final MessagingController _mController = Get.find();
  final TextEditingController _messageText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _mController.sessionId = _session.sessionID;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            color: const Color.fromARGB(255, 2, 12, 50),
            child: SafeArea(
              bottom: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileImage(
                    imageURL: _session.trainerProfilePicURL,
                    rad: 3,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: kScreenPadding),
                        child: Text(
                          _session.trainerName!,
                          style: k20BoldTS.copyWith(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: kScreenPadding),
                        child: Text(
                          '${_session.sessionWorkoutType!} Session',
                          style: kRegularTS.copyWith(color: Colors.white),
                        ),
                      ),

                      // const SizedBox(height: 20)
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 1.w,
                    ),
                  ),
                  TextButton(
                      onPressed: () => Get.back(), child: const Text('back'))
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return !_mController.isFinishedLoading.value
                  ? const Center(
                      child: SpinKitFadingFour(
                        color: kPrimaryColor,
                        size: 50.0,
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      padding: UIParameters.screenPadding,
                      itemCount: _mController.chatx.length,
                      itemBuilder: (context, index) => _mController
                                  .chatx[index].senderId ==
                              Get.find<AuthController>().firebaseUser.uid
                          ? myMessage(_mController.chatx[index].message)
                          : otherMessage(_mController.chatx[index].message));
            }),
          ),
          const Divider(
            height: 0,
          ),
          // SingleChildScrollView(
          //   padding: UIParameters.screenPadding,
          //   scrollDirection: Axis.horizontal,
          //   child: SafeArea(
          //     left: false,
          //     top: false,
          //     right: false,
          //     child: ConstrainedBox(
          //       constraints: BoxConstraints(
          //         maxWidth: 150.w,
          //       ),
          //       child: Wrap(
          //         spacing: 7,
          //         runSpacing: 8,
          //         children: List.generate(
          //             QuickResponse.quickResponses.length,
          //             (index) => Message(
          //                 label: QuickResponse.quickResponses[index].message,
          //                 onTap: () {
          //                   // controller.addMessage(
          //                   //     QuickResponse.quickResponses[index].message);
          //                 })),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageText,
                      onChanged: (v) => _mController.message = v,
                      decoration: const InputDecoration(
                          hintText: 'Type message...',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  IconButton(
                      onPressed: () {
                        _messageText.clear();
                        _mController.sendMessage();
                      },
                      icon: const Icon(Icons.send)),
                ],
              )),
        ],
      ),
    );
  }

  myMessage(message) => ScaleTransition(
      scale: kAlwaysCompleteAnimation,
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyChatBubble(
              message: message,
            ),
          ],
        ),
      ));

  otherMessage(message) => ScaleTransition(
      scale: kAlwaysCompleteAnimation,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChatBubble(message: message),
          ],
        ),
      ));
}
