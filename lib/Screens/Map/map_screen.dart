import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Controllers/shared_preferences/preferences_controller.dart';
import 'package:nowly/Utils/app_logger.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  // ignore: unused_field
  final MapController _mapController = Get.put(MapController());
  final PreferencesController _preferences = Get.put(PreferencesController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (_preferences.prefs?.getBool('showMapDialog') ?? true) {
        final showAgain = Get.find<UserController>().showMapDialogAgain;
        final dontShowAgain = Get.find<UserController>().dontShowMapDialogAgain;

        Dialogs().mapInfo(context, showAgain, dontShowAgain);
      }
    });

    AppLogger.info('Map Screen');
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: GoogleMapWidget()),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                  ])),
            ),
          ),
          SafeArea(
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, kScreenPadding, 0, 0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text('TRAINERS AVAILABLE NEAR YOU', style: k16BoldTS),
                          SizedBox(height: 10),
                          MapHeader(),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
