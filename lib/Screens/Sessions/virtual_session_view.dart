import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Logo/logos.dart';
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
                  floatingLayoutMainViewPadding: const EdgeInsets.all(0),
                  floatingLayoutSubViewPadding: const EdgeInsets.all(0),
                ),
              ),
              Positioned(
                bottom: 5.h,
                child: AgoraVideoButtons(
                  client: _agoraController.client,
                  autoHideButtons: true,
                  // disconnectButtonChild: _disconnectBtn(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Logo.textLogoW(context, 3.h),
                            Align(
                              alignment: Alignment.topRight,
                              child: _agoraController.buildTimer(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Trainer Name: ',
                              style: kRegularTS,
                            ),
                            Text(
                              _agoraController.currentSession.trainerName ??
                                  '...',
                              style: k10BoldTS.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.max,
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       _isUser ? '' : 'Primary Goal: ',
                        //       style: k10RegularTS,
                        //     ),
                        //     // Text(
                        //     //     _isUser
                        //     //         ? _agoraController.trainer?.skillSet[0] ??
                        //     //             '...'
                        //     //         : _agoraController.user.primaryGoal,
                        //     //     style: k10BoldTS)
                        //   ],
                        // ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Workout Type: ',
                              style: k10RegularTS,
                            ),
                            Text(
                                _agoraController
                                    .currentSession.sessionWorkoutType!,
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

  // ignore: unused_element
  Widget _disconnectBtn() => InkWell(
        onTap: () => _agoraController.kill(),
        child: CircleAvatar(
          radius: 5.h,
          child: Text(
            'End Session',
            style: k10BoldTS.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
}
