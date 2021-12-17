import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/Session/workout_type_model.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Map/session_details.dart';
import 'package:nowly/Screens/Sessions/current_session_details_screen.dart';
import 'package:nowly/Services/Firebase/firebase_futures.dart';
import 'package:nowly/Services/Firebase/firebase_streams.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';
import '../controller_exporter.dart';

class TrainerInPersonSessionController extends GetxController {
  Timer? _timer;
  final RxInt _sessionTime = 900.obs;
  final _isProcessing = false.obs;
  final _currentSession = SessionModel().obs;
  // ignore: non_constant_identifier_names
  TrainerSessionController(
      {required TrainerInPersonSessionModel trainerSessionModel}) {
    trainerSession = trainerSessionModel;
  }

  set sessionTime(value) => _sessionTime.value = value;
  get sessionTime => _sessionTime.value;
  get isProcessing => _isProcessing.value;
  get currentSession => _currentSession.value;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
  }

  final selectedLength = SessionDurationAndCostModel(duration: '', cost: 0).obs;
  late TrainerInPersonSessionModel trainerSession;
  final showTimes = false.obs;

  final sessionDistandeDuratiom = Rxn<Leg>();
  final distanceAndDuraionText = Rxn<String>();
  final distanceText = ''.obs;

  final selectedWorkoutType =
      WorkoutType(imagePath: '', type: '', headerData: []).obs;

  set selectedWorkoutType(value) => selectedWorkoutType.value = value;
  final skillTypes = <WorkoutType>[];

  void changeDistanceAndDuraion(Leg details) {
    sessionDistandeDuratiom.value = details;
    final text = '${details.duration.text} and ${details.distance.text} Away';
    distanceAndDuraionText.value = text;
    distanceText.value = details.distance.text;
  }

  void setTrainerDetails(TrainerInPersonSessionModel trainer) {
    trainerSession = trainer;
    selectedLength.value = trainer.sessionLengths[0];
    // selectedWorkoutType.value = skillTypes[0];
  }

  void openSessionDetailsBottomSheet(
      TrainerInPersonSessionController controller) {
    Get.bottomSheet(
      Wrap(
        children: [
          SessionDetails(controller: controller),
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
