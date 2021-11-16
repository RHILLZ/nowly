import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/Common/main_button.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as img;
import 'package:sizer/sizer.dart';

class LiveSessionView extends StatelessWidget {
  const LiveSessionView(
      {Key? key, required TrainerInPersonSessionController controller})
      : _controller = controller,
        super(key: key);

  final TrainerInPersonSessionController _controller;
  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset('assets/icons/logo_outlined.svg');
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTIVE SESSION'),
        centerTitle: true,
      ),
      bottomSheet: MainButton(
        title: 'End Session'.toUpperCase(),
        onTap: () {},
      ),
      body: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                    'Please allow trainer to scan QR code to enable session',
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 25.h,
                  width: 25.h,
                  child: PrettyQr(
                      data: 'abcdefg',
                      image: const img.Svg(
                        'assets/icons/logo_outlined.svg',
                      ),
                      roundEdges: true,
                      elementColor: kPrimaryColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text('Session Duration'.toUpperCase(),
                    textAlign: TextAlign.center, style: k20BoldTS),
                Obx(() => _controller.buildTimer()),
                SizedBox(
                  height: 6.h,
                ),
                // const Text('Trainer Name'),
                // const Text('Trainer Rating'),
                // const Text('Skills'),
                // const Text('Workout Type'),
              ])),
    );
  }
}
