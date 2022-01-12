import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:sizer/sizer.dart';

class VideoCallView extends StatefulWidget {
  const VideoCallView({Key? key, required AgoraController agoraController})
      : _agoraController = agoraController,
        super(key: key);
  final AgoraController _agoraController;

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

class _VideoCallViewState extends State<VideoCallView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._agoraController.initAgora();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
              body: Stack(
            children: [
              Center(
                child: _remoteVideo(),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 10.h,
                  height: 18.h,
                  child: Center(
                    child: widget._agoraController.localUserJoined
                        ? RtcLocalView.SurfaceView()
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: widget._agoraController.infoWindowHidden
                    ? SizedBox(
                        width: 40.w,
                        child: IconButton(
                            onPressed: () =>
                                widget._agoraController.toggleInfoWindow(),
                            icon: widget._agoraController.buildTimer()),
                      )
                    : buildInfoWindow(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: callButtons(),
              ),
            ],
          )),
        ));
  }

  Widget _remoteVideo() {
    if (widget._agoraController.remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: widget._agoraController.remoteUid);
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  buildInfoWindow() => Container(
        width: 75.w,
        height: 20.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(.8)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //NOWLY LOGO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo.textLogoW(context, 3.h),
                  widget._agoraController.buildTimer()
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Trainer Name: '),
                  Text(
                      '${widget._agoraController.currentVirtualSession.trainerName}')
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Workout Type:  '),
                  Text(
                      '${widget._agoraController.currentVirtualSession.sessionWorkoutType}')
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () => widget._agoraController.toggleInfoWindow(),
                    icon: Icon(
                      Icons.visibility_off,
                      size: 2.h,
                    )),
              )
            ],
          ),
        ),
      );

  callButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                  onTap: () {
                    widget._agoraController.toggleAudio();
                  },
                  borderRadius: BorderRadius.circular(100),
                  radius: 5.h,
                  child: Icon(
                    widget._agoraController.isMuted ? Icons.mic_off : Icons.mic,
                    color: kGray,
                    size: 6.h,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                  onTap: () {
                    //SHOW DIALOG TO CONFIRM EARLY CANCELLATION
                    // ON APPROVAL GO TO SESSION COMPLETE SCREEN
                    //KILL CHANNEL
                    widget._agoraController.kill();
                  },
                  borderRadius: BorderRadius.circular(100),
                  radius: 5.h,
                  child: Icon(
                    Icons.call_end,
                    color: kPrimaryColor,
                    size: 8.h,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                  onTap: () {
                    widget._agoraController.toggleVideo();
                  },
                  borderRadius: BorderRadius.circular(100),
                  radius: 5.h,
                  child: Icon(
                    widget._agoraController.cameraOff
                        ? Icons.videocam_off
                        : Icons.videocam,
                    color: kGray,
                    size: 6.h,
                  )),
            ),
          ),
        ],
      );
}
