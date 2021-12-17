import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/Common/main_button.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as img;
import 'package:sizer/sizer.dart';

class LiveSessionView extends StatelessWidget {
  const LiveSessionView({Key? key, required SessionController controller})
      : _controller = controller,
        super(key: key);

  final SessionController _controller;
  @override
  Widget build(BuildContext context) {
    final _session = _controller.currentSession;
    _controller.loadQr();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Logo.mark(3.h),
        ),
        title: const Text('ACTIVE SESSION'),
        centerTitle: true,
      ),
      bottomSheet: MainButton(
        title: 'End Session'.toUpperCase(),
        onTap: () {
          _controller.endSession(context);
        },
      ),
      body: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ProfileImage(
                  imageURL: _session.trainerProfilePicURL,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  _session.trainerName,
                  style: k16BoldTS,
                ),
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                    'Please allow trainer to scan QR code to enable session',
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                    height: 25.h,
                    width: 25.h,
                    child: Obx(
                      () => _controller.qrLoaded.value == false
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            )
                          : PrettyQr(
                              data: Get.find<AuthController>().firebaseUser.uid,
                              image: const img.Svg(
                                'assets/logo/mark.svg',
                              ),
                              roundEdges: true,
                              elementColor: kPrimaryColor),
                    )),
                SizedBox(
                  height: 6.h,
                ),
                Text('Session Duration'.toUpperCase(),
                    textAlign: TextAlign.center, style: k20BoldTS),
                SizedBox(
                  height: 2.h,
                ),
                const Text(
                  'timer will start when QR is scanned',
                  style: kRegularTS,
                ),
                Obx(() => _controller.buildTimer()),
                SizedBox(
                  height: 6.h,
                ),
              ])),
    );
  }
}
