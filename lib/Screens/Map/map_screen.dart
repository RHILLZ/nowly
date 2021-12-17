import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLogger.i('Map Screen');
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: GoogleMapWidget()),
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
                          // Visibility(visible: true, child: ScheduleCalendar())
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
