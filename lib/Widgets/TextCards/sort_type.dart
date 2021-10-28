import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';

import '../widget_exporter.dart';


class SortTypes extends StatelessWidget {
  const SortTypes({Key? key}) : super(key: key);

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
            child: Text(
              'SORT',
            ),
          ),
        ),
        FixedWidthContainer(
          child: Obx(
            () => SeperatedRow(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      width: kContentGap,
                    ),
                children: _sessionController.sortTypes
                    .map((sortTypes) => Obx(() {
                         
                          return Expanded(
                            child: TextCard(
                              isSelected:
                                  _sessionController.selectedSortType.value ==
                                      sortTypes,
                              label: sortTypes.label,
                              onTap: () {
                                _sessionController.selectedSortType.value =
                                    sortTypes;
                              },
                            ),
                          );
                        }))
                    .toList()),
          ),
        )
      ],
    );
  }
}
