import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

import '../widget_exporter.dart';

class SessionLength extends StatelessWidget {
  SessionLength({Key? key}) : super(key: key);

  final SessionController _sessionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Text(
              'SESSION DURATION',
              style: k16BoldTS,
            ),
          ),
        ),
        FixedWidthContainer(
          child: SeperatedRow(
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    width: kContentGap,
                  ),
              children: _sessionController.sessionDurAndCosts
                  .map((sessionLength) => Expanded(
                        child: Obx(
                          () => TextCard(
                            label: sessionLength.duration,
                            isSelected:
                                _sessionController.sessionDurationAndCost ==
                                    sessionLength,
                            onTap: () {
                              _sessionController.sessionDurationAndCost =
                                  sessionLength;
                            },
                          ),
                        ),
                      ))
                  .toList()),
        )
      ],
    );
  }
}
