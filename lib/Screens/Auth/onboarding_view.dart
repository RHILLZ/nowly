import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';
import 'auth_view.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Container(
          padding: UIParameters.screenPadding,
          decoration: BoxDecoration(gradient: authPagesGradient(context)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo_outlined.svg',
                  height: 20.h,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Flexible(
                      //   child: AppLogo(),
                      // ),
                      const Text(
                        "Nowly trainers coming your way!",
                        style: k20RegularTS,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/images/trainer/sessionCardCharacter.svg',
                              height: 10.h,
                            ),
                            SvgPicture.asset(
                                'assets/images/trainer/jumpingManIcon.svg'),
                            SvgPicture.asset(
                                'assets/images/trainer/darkTrainerIcon.svg'),
                            SvgPicture.asset(
                                'assets/images/trainer/darkManHeart.svg'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Text(
                          'By creating an account, you agree to our \nTerms and Conditions',
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                RectButton(
                  showOutline: true,
                  title: 'Create Account',
                  onPressed: () {
                    GetStorage().write('onboardSelection', 'newAccount');
                    Get.to(() => AuthView());
                  },
                  textStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                ),
                const SizedBox(height: 10),
                RectButton(
                  onPressed: () {
                    // Get.toNamed(SignUpScreen.routeName);
                    GetStorage().write('onboardSelection', 'signin');
                    Get.to(() => AuthView());
                  },
                  title: '                 Sign In                 ',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Trouble Signing In?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
