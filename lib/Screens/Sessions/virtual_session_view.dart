import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:sizer/sizer.dart';

class VideoCallView extends StatelessWidget {
  const VideoCallView({Key? key, required AgoraController agoraController})
      : _agoraController = agoraController,
        super(key: key);
  final AgoraController _agoraController;

  @override
  Widget build(BuildContext context) {
    _agoraController.initVideoCall(context);
    final userID = Get.find<AuthController>().firebaseUser.uid;
    final _isUser = userID == _agoraController.channel;
    return Obx(() => SafeArea(
          child: Scaffold(
              body: Stack(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: AgoraVideoViewer(
                  client: _agoraController.client,
                  layoutType: Layout.floating,
                ),
              ),
              Positioned(
                bottom: 5.h,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: AgoraVideoButtons(
                    client: _agoraController.client,
                    autoHideButtons: true,
                  ),
                ),
              ),
              Positioned(
                  top: 3.h,
                  right: 4.w,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black.withOpacity(.4)),
                    height: 15.h,
                    width: 60.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: _agoraController.buildTimer(),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _isUser ? 'Trainer Name: ' : 'User Name: ',
                              style: k10RegularTS,
                            ),
                            Text(
                              _isUser
                                  ? _agoraController.session.trainerName ??
                                      '...'
                                  : _agoraController.session.userName ?? '...',
                              style: k10BoldTS,
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _isUser ? '' : 'Primary Goal: ',
                              style: k10RegularTS,
                            ),
                            // Text(
                            //     _isUser
                            //         ? _agoraController.trainer?.skillSet[0] ??
                            //             '...'
                            //         : _agoraController.user.primaryGoal,
                            //     style: k10BoldTS)
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Workout Type: ',
                              style: k10RegularTS,
                            ),
                            Text(_agoraController.session.sessionWorkoutType!,
                                style: k10BoldTS)
                          ],
                        ),
                      ],
                    ),
                  )),
              // Positioned(
              //     top: 3.5.h, right: 6.w, child: _agoraController.buildTimer()),
            ],
          )),
        ));
  }
}
