import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';

import '../widget_exporter.dart';


class Avalability extends StatelessWidget {
  const Avalability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilterController _sessionFilterController =
        Get.put(FilterController());
    final SessionController _sessionController = Get.find();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 25, bottom: 10),
              child: Text(
                'AVAILABILITY',
              ),
            ),
          ),
          FixedWidthContainer(
            child: Obx(
              () => SeperatedRow(
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        width: kContentGap,
                      ),
                  children: _sessionFilterController.avalability
                      .map((availability) => Expanded(
                            child: Obx(
                              () => TextCard(
                                isSelected: _sessionFilterController
                                        .selectedAvailability.value ==
                                    availability,
                                label: availability.label,
                                onTap: () {
                                  _sessionFilterController.selectedAvailability
                                      .value = availability;
                                  _sessionController.sessionAvailability =
                                      availability.label;
                                  if (availability.label == 'BOOK LATER') {
                                    _sessionController.sessionMode =
                                        SessionModeModel(
                                            id: '', mode: 'IN PERSON');
                                  }
                                  // print(_sessionFilterController.selectedAvailability.value.label == '2',);
                                },
                              ),
                            ),
                          ))
                      .toList()),
            ),
          ),
          Obx(
            () => Visibility(
              visible:
                  _sessionFilterController.selectedAvailability.value.id == '2',
              child: ScheduleCalendar(
                islnInFilters: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
