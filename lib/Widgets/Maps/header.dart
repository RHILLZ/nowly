import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Map/search_dialog.dart';

class MapHeader extends StatelessWidget {
  const MapHeader({
    Key? key,
  }) : super(key: key);

  double get headerHeight => 55.0;
  double get dialogHeight => 400.0;

  @override
  Widget build(BuildContext context) {
    final MapController _mapController = Get.put(MapController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: headerHeight,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).cardColor,
                  boxShadow:
                      UIParameters.getShadow(spreadRadius: 2, blurRadius: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _mapController.focusMe();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(Icons.my_location_rounded),
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                barrierDismissible: true,
                                barrierColor: Colors.black54,
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    PlaceSearchScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Obx(
                              () => Row(
                                children: [
                                  _mapController.isLoadingPlaceDetails.value
                                      ? const Center(
                                          child: SpinKitFadingFour(
                                            color: kPrimaryColor,
                                            size: 25.0,
                                          ),
                                        )
                                      : const Icon(Icons.search),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    _mapController.lastSearchedPlace.value ==
                                            null
                                        ? 'Find Online Trainers for In Person Workout'
                                        : _mapController.lastSearchedPlace
                                            .value!.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Material(
                      //   type: MaterialType.transparency,
                      //   child: RoundedCornerButton(
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //       radius: 50,
                      //       onTap: () {
                      //         showCalenderDialog();
                      //       },
                      //       child: Obx(
                      //         () => Padding(
                      //           padding: const EdgeInsets.only(
                      //               top: 10, bottom: 10, left: 4),
                      //           child: Row(
                      //             children: [
                      //               if (_dateDetails.value.selectedDate == null)
                      //                 const Text('Now')
                      //               else
                      //                 Text(
                      //                     '${_dateDetails.value.selectedDate!.day} / ${_dateDetails.value.selectedDate!.month}'),
                      //               const Icon(
                      //                 Icons.keyboard_arrow_down,
                      //                 size: 15,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       )),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
