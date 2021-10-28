import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Messaging/messaging_screen.dart';
import 'package:nowly/Screens/QR/qr_scan_screen.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class CurrentSessionDetailsScreen extends StatelessWidget {
  const CurrentSessionDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/currentSession';

  @override
  Widget build(BuildContext context) {
    final SessionController _controller = Get.find();
    final TrainerSessionController _trainerSessionC =
        Get.arguments as TrainerSessionController;
    final MapNavigatorController _mapNavController = Get.find();
    final _sessionDetails = _trainerSessionC.trainerSession;
    _controller.sessionDurAndCosts.value =
        _trainerSessionC.trainerSession.sessionLengths;
    // _controller.sessionDurationAndCosts = _trainerSessionC.selectedLength;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CURRENT SESSION DETAILS'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
          child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Padding(
          padding: UIParameters.cardPadding,
          child: SeperatedColumn(
            // mainAxisSize: MainAxisSize.min,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            children: [
              RectButton(
                fillColor: kActiveColor,
                child: Row(
                  children: const [
                    Icon(Icons.map),
                    SizedBox(
                      width: 10,
                    ),
                    Text('OPEN MAP')
                  ],
                ),
                onPressed: () {
                  _mapNavController.openAvialableMaps(
                      sessionController: _trainerSessionC);
                },
              ),
              RectButton(
                fillColor: Colors.blue,
                child: Row(
                  children: const [
                    Icon(Icons.message),
                    SizedBox(
                      width: 10,
                    ),
                    Text('CONTACT')
                  ],
                ),
                onPressed: () {
                  Get.toNamed(MessagingScreen.routeName);
                },
              ),
              RectButton(
                fillColor: kLightGray,
                child: Row(
                  children: const [
                    Icon(Icons.close),
                    SizedBox(
                      width: 10,
                    ),
                    Text('CANCEL')
                  ],
                ),
                onPressed: () {
                  _mapNavController.endNavigations();
                  Get.back();
                },
              ),
              MainButton(
                cornerRadius: 5,
                onTap: () {
                  Get.toNamed(QRScanScreen.routeName);
                },
                title: 'I’M HERE',
              ),
            ],
          ),
        ),
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: UIParameters.screenPaddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(vertical: kScreenPadding2),
                padding: UIParameters.screenPadding,
                height: Get.height * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'YOU HAVE CHOSEN',
                      style: k20BoldTS.copyWith(color: Colors.white),
                    ),
                    // Expanded(
                    //     child: Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: ProfileImageWithStatus(
                    //       imagePath: _sessionDetails.trainer.profilePicURL),
                    // )),
                    Text(
                      _sessionDetails.trainer.firstName!,
                      style: k20BoldTS.copyWith(color: Colors.white),
                    ),
                    // Text(_sessionDetails.trainer.address ?? '',
                    //     style: kRegularTS.copyWith(color: Colors.white))
                  ],
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
              ListTile(
                title: Obx(
                  () => Text(
                      '${_controller.sessionDurationAndCost.duration} SESSION',
                      style: k16BoldTS),
                ),
                // subtitle: Text(_trainerSessionC.trainerSession.type.type,
                //     style: kRegularTS),
                trailing: Obx(
                  () => Text(
                      _trainerSessionC.selectedLength.value.charges ?? '',
                      style: k20BoldTS),
                ),
              ),
              const Divider(height: 20, thickness: 3),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StaticsWidget(
                        imagePath: 'assets/icons/map.svg',
                        lable1: 'DISTANCE',
                        lable2:
                            _trainerSessionC.sessionDistandeDuratiom.value ==
                                    null
                                ? 'N/A'
                                : _trainerSessionC.sessionDistandeDuratiom
                                    .value!.distance.text),
                    Obx(() => StaticsWidget(
                        imagePath: 'assets/icons/clock1.svg',
                        lable1: 'DURATION',
                        lable2:
                            _trainerSessionC.selectedLength.value.duration)),
                    StaticsWidget(
                      imagePath: 'assets/icons/clock2.svg',
                      lable1: 'ETA',
                      lable2:
                          _trainerSessionC.sessionDistandeDuratiom.value == null
                              ? 'N/A'
                              : _trainerSessionC
                                  .sessionDistandeDuratiom.value!.duration.text,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
