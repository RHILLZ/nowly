import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Sessions/live_session_screen.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
import 'package:nowly/Widgets/Sessions/active_session_banner.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class CurrentSessionDetailsScreen extends StatelessWidget {
  const CurrentSessionDetailsScreen(
      {Key? key,
      required SessionModel session,
      required MapNavigatorController mapNavController,
      required TrainerInPersonSessionController trainerSessionC,
      required SessionController sessionController})
      : _sessionController = sessionController,
        _mapNavController = mapNavController,
        _session = session,
        super(key: key);

  static const routeName = '/currentSession';
  final SessionModel _session;
  final MapNavigatorController _mapNavController;
  final SessionController _sessionController;

  @override
  Widget build(BuildContext context) {
    // final SessionController _controller = Get.find();
    // final _sessionDetails = _trainerSessionC.trainerSession;
    // _controller.sessionDurAndCosts.value =
    //     _trainerSessionC.trainerSession.sessionLengths;
    // // _controller.sessionDurationAndCosts = _trainerSessionC.selectedLength;
    // final MessagingController _mController = Get.put(MessagingController());

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Logo.mark(3.h),
        ),
        title: Text('CURRENT SESSION DETAILS',
            style: k16BoldTS.copyWith(fontSize: 14)),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
          child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Padding(
          padding: UIParameters.cardPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // separatorBuilder: (BuildContext context, int index) {
            //   return SizedBox(
            //     height: 1.h,
            //   );
            // },
            children: [
              RectButton(
                fillColor: getWidgetSelectedColor(context),
                child: Row(
                  children: const [
                    Icon(Icons.navigation_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text('OPEN NAVIGATION')
                  ],
                ),
                onPressed: () {
                  _mapNavController.openAvialableMaps(
                      sessionController: Get.find());
                },
              ),
              SizedBox(
                height: 1.h,
              ),
              // RectButton(
              //   fillColor: Colors.blue,
              //   child: Row(
              //     children: const [
              //       Icon(Icons.message),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text('MESSAGE')
              //     ],
              //   ),
              //   onPressed: () {
              //     Get.to(() => MessagingScreen(
              //           session: _session,
              //         ));
              //   },
              // ),
              // SizedBox(
              //   height: 1.h,
              // ),
              // RectButton(
              //   fillColor: kLightGray,
              //   child: Row(
              //     children: const [
              //       Icon(Icons.close),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text('CANCEL')
              //     ],
              //   ),
              //   onPressed: () {
              //     _mapNavController.endNavigations();
              //     Get.back();
              //   },
              // ),
              // SizedBox(
              //   height: 1.h,
              // ),
              MainButton(
                cornerRadius: 5,
                onTap: () {
                  Get.off(() => LiveSessionView(
                        controller: _sessionController,
                      ));
                },
                title: 'I’M HERE',
              ),
            ],
          ),
        ),
      )),
      body: SingleChildScrollView(
        padding: UIParameters.screenPaddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(vertical: kScreenPadding2),
              padding: UIParameters.screenPadding,
              height: Get.height * 0.25,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'TRAINER AWAITING YOUR ARRIVAL',
                      style: k20BoldTS.copyWith(color: Colors.white),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ProfileImage(
                            imageURL: _session.trainerProfilePicURL)),
                    Text(
                      _session.trainerName!,
                      style: k20BoldTS.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.multiply),
                      image: const AssetImage('assets/images/map/map.png')),
                  borderRadius: BorderRadius.circular(40)),
            ),
            const Divider(height: 20, thickness: 3),
            ActiveSessionBanner(controller: _sessionController),
            const Divider(height: 20, thickness: 3),
            ListTile(
              title: Text('${_session.sessionDuration} SESSION'.toUpperCase(),
                  style: k16BoldTS),
              subtitle: Text(_session.sessionWorkoutType!, style: kRegularTS),
              trailing: Text('\$${_session.sessionChargedAmount! / 100}0',
                  style: k20BoldTS),
            ),
            const Divider(height: 20, thickness: 3),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Obx(() => Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           StaticsWidget(
            //               imagePath: 'assets/icons/map.svg',
            //               lable1: 'DISTANCE',
            //               lable2:
            //                   _trainerSessionC.sessionDistandeDuratiom.value ==
            //                           null
            //                       ? 'N/A'
            //                       : _trainerSessionC.sessionDistandeDuratiom
            //                           .value!.distance.text),
            //           // StaticsWidget(
            //           //     imagePath: 'assets/icons/clock1.svg',
            //           //     lable1: 'DURATION',
            //           //     lable2: _trainerSessionC.selectedLength.value.duration),
            //           StaticsWidget(
            //             imagePath: 'assets/icons/clock2.svg',
            //             lable1: 'ETA',
            //             lable2:
            //                 _trainerSessionC.sessionDistandeDuratiom.value ==
            //                         null
            //                     ? 'N/A'
            //                     : _trainerSessionC.sessionDistandeDuratiom
            //                         .value!.duration.text,
            //           )
            //         ],
            //       )),
            // ),
          ],
        ),
      ),
    );
  }
}
