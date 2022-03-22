import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/OnBoarding/injury_history.dart';
import 'package:nowly/Screens/OnBoarding/medical_history.dart';
import 'package:nowly/Screens/OnBoarding/name_and_info.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

/// {@template UserRegistrationView}
/// User inputs their information into this Registration Form screen 
/// {@endtemplate}
class UserRegistrationView extends GetView<RegistrationController> {
  /// {@macro StartScreenView}
  UserRegistrationView({Key? key}) : super(key: key);
  final RegistrationController _controller = Get.put(RegistrationController());
  final headerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account Registration'.toUpperCase(), style: k16BoldTS),
          centerTitle: true,
          leading: Logo.mark(3.h),
        ),
        bottomSheet: Obx(() => MainButton(
              enabled: _controller.profileReady,
              onTap: () async {
                // await _controller.isEveryRequirmentsFilled();
                _controller.createUser();
                // _controller.testit();
              },
              title: 'Create Profile'.toUpperCase(),
            ),),
        body: Obx(
          () => _controller.isProcessing
              ? _proccessingView()
              : SafeArea(
                  child: Padding(
                    padding: UIParameters.screenPadding,
                    child: SingleChildScrollView(
                      child: SeperatedColumn(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: kContentGap,
                          );
                        },
                        children: [
                          Obx(
                            () => Transform.translate(
                              offset: Offset.zero,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  _controller
                                      .selectedQuestionnaire.value.header,
                                  style: k16BoldTS,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          NameAndInfo(
                            controller: _controller,
                          ),
                          InjuryHistory(controller: _controller),
                          MedicalHistory(controller: _controller),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }

  Widget _proccessingView() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeartbeatProgressIndicator(
              child: SvgPicture.asset(
            'assets/icons/logo_outlined.svg',
            height: 10.h,
          ),),
          SizedBox(
            height: 5.h,
          ),
          Text(
            'Creating profile'.toUpperCase(),
            style: k18BoldTS,
          ),
          SizedBox(
            height: 3.h,
          ),
          JumpingDotsProgressIndicator(
            color: kPrimaryColor,
            fontSize: 20,
            numberOfDots: 4,
          )
        ],
      );
}
