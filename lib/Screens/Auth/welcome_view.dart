import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/Auth/preferences_controller.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'auth_view.dart';

class OnBoardingView extends StatelessWidget{
  OnBoardingView({Key? key}) : super(key: key);
  // final _controller = Get.find<PreferencesController>();
  final PreferencesController _preferences = Get.put(PreferencesController());
  // SharedPreferences _prefs = Get.find<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    // _prefs.value = _preferences.prefs;
    // SharedPreferences _prefs = _controller.prefs;
    SharedPreferences? _prefs = _preferences.prefs;
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Container(
          padding: UIParameters.screenPadding,
          decoration: BoxDecoration(gradient: onBoardingGradient(context)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Logo.textLogoLD(context, 18.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Nowly trainers coming your way!",
                      style: k20RegularTS.copyWith(
                          color: Get.isDarkMode ? null : kSecondaryColor),
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
                            color: Get.isDarkMode ? null : kSecondaryColor,
                            height: 10.h,
                          ),
                          SvgPicture.asset(
                            'assets/images/trainer/jumpingManIcon.svg',
                            color: Get.isDarkMode ? null : kSecondaryColor,
                          ),
                          SvgPicture.asset(
                            'assets/images/trainer/darkTrainerIcon.svg',
                            color: Get.isDarkMode ? null : kSecondaryColor,
                          ),
                          SvgPicture.asset(
                            'assets/images/trainer/darkManHeart.svg',
                            color: Get.isDarkMode ? null : kSecondaryColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // Text(
                    //     'By creating an account, you agree to our \nTerms and Conditions',
                    //     style: kRegularTS.copyWith(
                    //       color: Get.isDarkMode ? null : kSecondaryColor,
                    //     ),
                    //     textAlign: TextAlign.center),
                  ],
                ),
                Expanded(child: SizedBox(height: 2.h)),
                RectButton(
                  showOutline: true,
                  title: 'Create Account',
                  onPressed: () {
                    _prefs?.setString('onboardSelection', 'newAccount');
                    // GetStorage().write('onboardSelection', 'newAccount');
                    Get.to(() => AuthView());
                  },
                  textStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                ),
                const SizedBox(height: 10),
                RectButton(
                  fillColor: Get.isDarkMode ? null : kSecondaryColor,
                  onPressed: () async{
                    // Get.toNamed(SignUpScreen.routeName);
                    _prefs?.setString('onboardSelection', 'signin');
                    // GetStorage().write('onboardSelection', 'signin');
                    Get.to(() => AuthView());
                  },
                  title: '                 Sign In                 ',
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: TextButton(
                //     onPressed: () {},
                //     child: const Text(
                //       'Trouble Signing In?',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold, color: Colors.white),
                //     ),
                //   ),
                // )
                Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 0),
                  child: const Text(
                      '© 2021-2022 Xone Digital Incorporated. All Rights Reserved.',
                      style: k10RegularTS,
                      textAlign: TextAlign.center),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
