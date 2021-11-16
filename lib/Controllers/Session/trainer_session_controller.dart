import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Map/session_details.dart';
import 'package:sizer/sizer.dart';
import '../controller_exporter.dart';

class TrainerInPersonSessionController extends GetxController {
  Timer? _timer;
  final RxInt _sessionTime = 900.obs;
  // TrainerSessionController({required TrainerSessionModel trainerSessionModel}) {
  //   trainerSession = trainerSessionModel;
  // }
  set sessionTime(value) => _sessionTime.value = value;
  get sessionTime => _sessionTime.value;

  void startSessionTimer() {
    const sec = Duration(seconds: 1);
    _timer = Timer.periodic(sec, (timer) => _sessionTime.value++);
  }

  buildTimer() {
    final String minutes = _formatNumber(_sessionTime.value ~/ 60);
    final String seconds = _formatNumber(_sessionTime.value % 60);
    return Text('$minutes : $seconds',
        style: TextStyle(fontSize: 60.sp, color: kPrimaryColor));
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }

  final selectedLength = SessionDurationAndCostModel(duration: '', cost: 0).obs;
  late TrainerInPersonSessionModel trainerSession;
  final showTimes = false.obs;

  final sessionDistandeDuratiom = Rxn<Leg>();
  final distanceAndDuraionText = Rxn<String>();
  final distanceText = ''.obs;

  void changeDistanceAndDuraion(Leg details) {
    sessionDistandeDuratiom.value = details;
    final text = '${details.duration.text} and ${details.distance.text} Away';
    distanceAndDuraionText.value = text;
    distanceText.value = details.distance.text;
  }

  void setTrainerDetails(TrainerInPersonSessionModel trainer) {
    trainerSession = trainer;
    selectedLength.value = trainer.sessionLengths[0];
  }

  void openSessionDetailsBottomSheet() {
    Get.bottomSheet(
      Wrap(
        children: [
          SessionDetails(controller: this),
        ],
      ),
      isScrollControlled: true,
    );
  }

  void addOriginMarkerAndDrawPolyLinePath() {
    MapController mapController = Get.find();
    // ignore: unnecessary_null_comparison
    if (trainerSession == null) return;
    final LocationDetailsModel? locationDetails =
        trainerSession.locationDetailsModel;
    if (locationDetails == null) {
      mapController.clearPolyLinePath();
      return;
    }
    final location =
        LatLng(locationDetails.latitude, locationDetails.longitude);
    mapController.addOriginMarkers(location, tsController: this);
  }

  void changeTravelMode(TravelMode mode) {
    MapController mapController = Get.find();
    final LocationDetailsModel? locationDetails =
        trainerSession.locationDetailsModel;

    if (locationDetails != null) {
      final location =
          LatLng(locationDetails.latitude, locationDetails.longitude);
      mapController.changeTravelMode(mode,
          destination: location, tsController: this);
    }
  }

  @override
  void onClose() {
    super.onClose();
    _timer!.cancel();
  }
}
