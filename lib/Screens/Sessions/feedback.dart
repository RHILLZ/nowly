import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:nowly/root.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController _controller = Get.find();
    return Scaffold(
        bottomSheet: MainButton(
            onTap: () async {
              Phoenix.rebirth(context);
              await _controller.feedBack.isEmpty
                  ? Get.offAll(() => const Root())
                  : _controller.submitFeedback();
            },
            title: _controller.feedBack.isEmpty ? 'Close' : 'Submit'),
        body: Obx(
          () => Padding(
            padding: UIParameters.screenPadding,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Visibility(
                    visible:
                        !_controller.submitted && !_controller.isSubmitting,
                    child: TextFormField(
                      style: k16BoldTS,
                      maxLines: 5,
                      maxLength: 300,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(18),
                          hintText: 'Please Type Suggestions Here...',
                          border: OutlineInputBorder()),
                      onChanged: (v) => _controller.feedBack = v,
                    ),
                  ),
                  Logo.textLogoLD(context, 12.h),
                  SizedBox(height: 3.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Thank you for your Feedback.',
                        style: k20BoldTS.copyWith(color: kPrimaryColor),
                        children: [
                          TextSpan(
                              text:
                                  ' \n\nWe value your opinion. Please share any suggestions or feedback about your NOWLY experience.',
                              style: k16BoldTS.copyWith(fontSize: 12.sp))
                        ]),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Visibility(
                      visible: _controller.isSubmitting,
                      child: JumpingDotsProgressIndicator(
                        fontSize: 30,
                      )),
                  Visibility(
                      visible: _controller.submitted,
                      child: const Text(
                        'Much Appreciated.',
                        style: k20BoldTS,
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                    child: SizedBox(
                      height: 3.h,
                    ),
                  ),
                ]),
          ),
        ));
  }
}
