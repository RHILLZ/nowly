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

class CurrentSessionEnRouteDetailsScreen extends StatelessWidget {
  const CurrentSessionEnRouteDetailsScreen(
      {Key? key,
      required SessionModel session,
      required SessionController sessionController})
      : _sessionController = sessionController,
        _session = session,
        super(key: key);

  static const routeName = '/currentSession';
  final SessionModel _session;
  final SessionController _sessionController;

  @override
  Widget build(BuildContext context) {
    final SessionController _controller = Get.find();
    // _controller.sessionDurationAndCosts = _trainerSessionC.selectedLength;
    final MessagingController _mController = Get.put(MessagingController());

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Logo.mark(3.h),
        ),
        title: Text('CURRENT SESSION EN ROUTE',
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
                },
              ),
              SizedBox(
                height: 1.h,
              ),
              MainButton(
                cornerRadius: 5,
                onTap: () {
                  Get.to(() => LiveSessionView(
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
          ],
        ),
      ),
    );
  }
}
