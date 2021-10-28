import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Services/Apple/apple_auth.dart';
import 'package:nowly/Services/Google/google_auth.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());
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
                    child: Column(children: [
                      SvgPicture.asset(
                        'assets/icons/logo_outlined.svg',
                        height: 10.h,
                      ),
                      SvgPicture.asset(
                        'assets/icons/nowly.svg',
                        height: 8.h,
                        color: kPrimaryColor,
                      ),
                    ]),
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
                    // Get.toNamed(BaseScreen.routeName);
                    GoogleAuth().signInWithGoogle();
                  },
                  title: 'Continue with Google',
                  iconPath: 'assets/icons/g_plus.svg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AuthButton(
                  onPressed: () {
                    // Get.toNamed(BaseScreen.routeName);
                    AppleAuth().signInWithApple();
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
                    )
            ],
          ),
        ),
      ),
    );
  }
}
