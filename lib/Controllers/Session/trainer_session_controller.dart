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
  // TrainerSessionController({required TrainerSessionModel trainerSessionModel}) {
  //   trainerSession = trainerSessionModel;
  // }
  set sessionTime(value) => _sessionTime.value = value;
  get sessionTime => _sessionTime.value;
  get isProcessing => _isProcessing.value;
  get currentSession => _currentSession.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(_currentSession, (callback) => checkAccepted());
  }

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

  engageTrainer(SessionModel sess, String tokenId) async {
    _isProcessing.toggle();
    final session = SessionModel().toMap(sess);
    final sessionCreated = await FirebaseFutures().createNewSession(sess);
    _currentSession
        .bindStream(FirebaseStreams().streamSession(sess.sessionID!));

    if (sessionCreated) {
      OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [tokenId],
          content: 'In Person',
          heading: 'InPerson',
          additionalData: {'session': session, 'signal_Type': 'in person'},
          contentAvailable: true));
    } else {
      _isProcessing.toggle();
      Get.snackbar('Something went wrong.',
          'Unable to engage trainer at this time. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  checkAccepted() {
    if (_currentSession.value.isAccepted == true) {
      _isProcessing.toggle();
      Get.off(() => CurrentSessionDetailsScreen(
            session: _currentSession.value,
          ));
    }
  }
}
