import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Nav/base_screen.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController _controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
        ),
        body: Obx(
          () => Padding(
            padding: UIParameters.screenPadding,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Logo.textLogoLD(context, 12.h),
                    SizedBox(height: 3.h),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Thank you for your Feedback.',
                          style: k30BoldTS.copyWith(color: kPrimaryColor),
                          children: const [
                            TextSpan(
                                text:
                                    ' \n\nWe value your opinion. Please share any suggestions or feedback about your NOWLY experience.',
                                style: k16BoldTS)
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
                      visible:
                          !_controller.submitted && !_controller.isSubmitting,
                      child: TextFormField(
                        style: k16BoldTS,
                        maxLines: 10,
                        maxLength: 300,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(18),
                            hintText: 'Please Type Suggestions Here...',
                            border: OutlineInputBorder()),
                        onChanged: (v) => _controller.feedBack = v,
                      ),
                    ),
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
                    MainButton(
                        onTap: () {
                          _controller.feedBack.isEmpty
                              ? Get.off(BaseScreen())
                              : _controller.submitFeedback();
                          // _controller.submitted = false;
                        },
                        title:
                            _controller.feedBack.isEmpty ? 'Close' : 'Submit')
                  ]),
            ),
          ),
        ));
  }
}
