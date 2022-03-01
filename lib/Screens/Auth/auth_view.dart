import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
          decoration: BoxDecoration(gradient: onBoardingGradient(context)),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "We’ve been missing \nyou dearly. 😭",
                      style: k20RegularTS.copyWith(
                          color: Get.isDarkMode ? null : kSecondaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    margin: EdgeInsets.only(left: 3.w),
                    child: Column(children: [Logo.squareLogoLD(context, 30.h)]),
                  ),
                  // Text(
                  //   'By creating an account, you agree to our \nTerms and Conditions',
                  //   style: kRegularTS.copyWith(
                  //     color: Get.isDarkMode ? Colors.white : kSecondaryColor,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              )),
              SizedBox(height: 2.h),
              AuthButton(
                color: Get.isDarkMode ? Colors.white : kSecondaryColor,
                onPressed: () {
                  // Get.toNamed(BaseScreen.routeName);
                  authController.emailOption(context);
                },
                title: 'Continue with Email',
                iconPath: 'assets/icons/email.svg',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AuthButton(
                  color: Get.isDarkMode ? Colors.white : kSecondaryColor,
                  onPressed: () {
                    onboardSelection != "newAccount" || controller.agreedToTerms
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
                  color: Get.isDarkMode ? Colors.white : kSecondaryColor,
                  onPressed: () {
                    onboardSelection != "newAccount" || controller.agreedToTerms
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
                                  fontSize: 10.sp,
                                  height: 1.4,
                                  color: Get.isDarkMode ? null : kGray),
                              children: [
                                const TextSpan(
                                    text:
                                        'By checking this box, I hearby agree to nowly '),
                                TextSpan(
                                    text: 'Terms of Services ',
                                    style: k10BoldTS.copyWith(
                                        fontSize: 10.sp,
                                        color: UIParameters.isDarkMode(context)
                                            ? kPrimaryColor
                                            : kActiveButtonColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          controller.loadDoc('nowlyTOS.pdf')),
                                const TextSpan(text: 'and '),
                                TextSpan(
                                    text: 'Privacy Agreement',
                                    style: k10BoldTS.copyWith(
                                        fontSize: 10.sp,
                                        color: UIParameters.isDarkMode(context)
                                            ? kPrimaryColor
                                            : kActiveButtonColor),
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
