import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Services/Apple/apple_auth.dart';
import 'package:nowly/Services/Google/google_auth.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);
  final AuthController authController = Get.find<AuthController>();
  final onboardSelection = GetStorage().read('onboardSelection');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Container(
          width: 100.w,
          padding: UIParameters.screenPadding,
          decoration: BoxDecoration(gradient: authPagesGradient(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flexible(
                  //   child: AppLogo(),
                  // ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "We’ve been missing \nyou dearly. 😭",
                      style: k20RegularTS,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    margin: EdgeInsets.only(left: 3.w),
                    child: Column(children: [Logo.squareLogoLD(context, 30.h)]),
                  ),
                  const Text(
                    'By creating an account, you agree to our \nTerms and Conditions',
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
              SizedBox(height: 2.h),
              AuthButton(
                onPressed: () {
                  // Get.toNamed(BaseScreen.routeName);
                  authController.emailOption(context);
                },
                title: '    Continue with Email    ',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AuthButton(
                  onPressed: () {
                    controller.agreedToTerms
                        ? GoogleAuth().signInWithGoogle()
                        : controller.termsWarningSnackbar();
                  },
                  title: 'Continue with Google',
                  iconPath: 'assets/icons/g_plus.svg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AuthButton(
                  onPressed: () {
                    controller.agreedToTerms
                        ? AppleAuth().signInWithApple()
                        : controller.termsWarningSnackbar();
                  },
                  title: 'Continue with Apple',
                  iconPath: 'assets/icons/apple.svg',
                ),
              ),
              onboardSelection == 'newAccount'
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Don’t have an account? Sign Up!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
              Visibility(
                  visible: onboardSelection == 'newAccount',
                  child: Obx(() => CheckboxListTile(
                      checkColor: kActiveColor,
                      activeColor: kPrimaryColor,
                      title: RichText(
                          softWrap: true,
                          text: TextSpan(
                              style: kRegularTS.copyWith(
                                  fontSize: 14, height: 1.4),
                              children: [
                                const TextSpan(
                                    text:
                                        'By checking this box, I hearby agree to nowly '),
                                TextSpan(
                                    text: 'Terms of Services ',
                                    style: k10BoldTS.copyWith(
                                        fontSize: 14, color: kPrimaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          controller.loadDoc('nowlyTOS.pdf')),
                                const TextSpan(text: 'and '),
                                TextSpan(
                                    text: 'Privacy Agreement',
                                    style: k10BoldTS.copyWith(
                                        fontSize: 14, color: kPrimaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          controller.loadDoc('nowlyPA.pdf'))
                              ])),
                      value: controller.agreedToTerms,
                      selected: controller.agreedToTerms,
                      onChanged: (v) {
                        controller.agreedToTerms = v;
                        GetStorage().write('agreeToTerms', v);
                      }))),
            ],
          ),
        ),
      ),
    );
  }
}
