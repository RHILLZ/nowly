import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Sessions/session_confirmation_screen_2.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class SessionDetails extends StatelessWidget {
  const SessionDetails(
      {Key? key, required TrainerInPersonSessionController controller})
      : _controller = controller,
        super(key: key);

  final TrainerInPersonSessionController _controller;

  @override
  Widget build(BuildContext context) {
    final MapController _mapController = Get.find();
    final _sessionDetails = _controller.trainerSession;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(() {
          if (_controller.distanceAndDuraionText.value == null) {
            return const SizedBox();
          }
          return Positioned(
            height: 80,
            top: -40,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              color: kPrimaryColor.withOpacity(0.5),
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  _controller.distanceAndDuraionText.value!,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          padding: UIParameters.screenPadding,
          child: SafeArea(
            child: Material(
              type: MaterialType.transparency,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            _sessionDetails.trainer.profilePicURL != null
                                ? NetworkImage(
                                    _sessionDetails.trainer.profilePicURL!)
                                : null,
                        child: _sessionDetails.trainer.profilePicURL != null
                            ? null
                            : Icon(
                                Icons.person,
                                size: 40.sp,
                              ),
                        maxRadius: 4.h,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_sessionDetails.trainer.firstName} ${_sessionDetails.trainer.lastName}',
                              style: k18BoldTS,
                            ),
                            // Text(
                            //   _sessionDetails.trainer.address ?? '',
                            //   style: kRegularTS,
                            // )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          StarRatingBar(
                            rating: _sessionDetails.trainer.rating,
                            isRatable: false,
                            onRate: (v) {},
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child:
                                Obx(() => Text(_controller.distanceText.value)),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Divider(
                        height: 25,
                      ),
                      const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'CHOOSE SESSION LENGTH',
                            style: k16BoldTS,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: SeperatedRow(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                              _sessionDetails.sessionLengths.length, (index) {
                            final sessionLength =
                                _sessionDetails.sessionLengths[index];
                            return Obx(
                              () => SessionLengthCard(
                                isSelected: _controller.selectedLength.value ==
                                    sessionLength,
                                cost: '\$${sessionLength.cost / 100}'
                                    .split('.')[0],
                                imagePath: _sessionDetails
                                    .sessionLengths[index].imagepath!,
                                length: sessionLength.duration,
                                onTap: () {
                                  final strDur =
                                      sessionLength.duration.substring(0, 2);
                                  final dur = int.parse(strDur);
                                  _controller.selectedLength.value =
                                      sessionLength;
                                  _controller.sessionTime = dur * 60;
                                },
                              ),
                            );
                          }),
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            width: 3.w,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          _controller.selectedLength.value.motivationText!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: ModeSwitch(
                          isDriving: _mapController.selectedTravelMode ==
                              TravelMode.driving,
                          onChange: (TravelMode mode) {
                            _controller.changeTravelMode(mode);
                          },
                        ),
                      ),
                      MainButton(
                        onTap: () {
                          Get.isBottomSheetOpen == true ? Get.back() : null;

                          Get.to(SessionConfirmationScreen2(
                            trainerInPersonSessionController: _controller,
                          ));
                        },
                        title: "LET'S GO",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
