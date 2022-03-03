import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:sizer/sizer.dart';

import '../widget_exporter.dart';

class TrainerPreference extends StatelessWidget {
  const TrainerPreference({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilterController _sessionController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Text('TRAINER PREFERENCE'),
          ),
        ),
        FixedWidthContainer(
          child: Obx(
            () => SeperatedRow(
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      width: kContentGap,
                    ),
                children: _sessionController.trainerTypes
                    .map((trainerTypes) => Expanded(
                          child: Obx(
                            () => FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                width: 30.w,
                                child: TextCard(
                                  isSelected: _sessionController.genderPref ==
                                      trainerTypes,
                                  label: trainerTypes.type,
                                  onTap: () {
                                    _sessionController.genderPref =
                                        trainerTypes;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList()),
          ),
        )
      ],
    );
  }
}
