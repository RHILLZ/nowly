import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/Firebase/firebase_futures.dart';
import 'package:nowly/Services/Sessions/sessions_services.dart';
import 'package:nowly/Widgets/BottomSheets/future_session_search.dart';

import '../controller_exporter.dart';

class SessionController extends GetxController {
  final _user = UserModel().obs;
  final _trainer = TrainerModel().obs;
  final _sessionLocationCoords = const LatLng(0, 0).obs;
  final _sessionLocationName = 'Virtual'.obs;
  final _isProccessing = false.obs;
  final _sessionIssueContext = ''.obs;

  // SCHEDULED PARAMS
  final _sessionTimeCheckerValue = 0.0.obs;
  final _sessionDay = ''.obs;

  set sessionTimeCheckerValue(value) => _sessionTimeCheckerValue.value = value;
  set sessionDay(value) => _sessionDay.value = value;
  set sessionIssueContext(value) => _sessionIssueContext.value = value;

  get sessionTimeCheckerValue => _sessionTimeCheckerValue.value;
  get sessionDay => _sessionDay.value;
  get isProccessing => _isProccessing.value;

  @override
  void onInit() {
    _fetchWorkOutData();
    _fetchSessionDurationAndCosts();
    _fethSessionTypes();
    super.onInit();
    ever(
        _sessionMode,
        (callback) => _sessionMode.value.mode == 'Virtual'.toUpperCase()
            ? clearLocationName()
            : null);
  }

  clearLocationName() {
    _sessionLocationName.value = 'Virtual';
  }

  final _sessionMode = SessionModeModel(id: '', mode: '').obs;
  final _sessionDurationAndCost =
      SessionDurationAndCostModel(duration: '', cost: 0).obs;
  final _sessionWorkOutType =
      WorkoutType(imagePath: '', type: '', headerData: []).obs;
  final _sessionTimeScheduled = ''.obs;
  final _sessionDateScheduled = ''.obs;
  final _genderPref = ''.obs;
  final _sessionAvailability = ''.obs;

  formatTimeScheduled() {
    if (_sessionTimeScheduled.value.split(' ')[0].endsWith(':0')) {
      return '${_sessionTimeScheduled.value.split(' ')[0]}0 ${_sessionTimeScheduled.value.split(' ')[1]}';
    } else {
      return _sessionTimeScheduled.value;
    }
  }

  get user => _user.value;
  get trainer => _trainer.value;
  get sessionMode => _sessionMode.value;
  get sessionDurationAndCost => _sessionDurationAndCost.value;
  get sessionWorkOutType => _sessionWorkOutType.value;
  get sessionLocationCoords => _sessionLocationCoords.value;
  get sessionLocationName => _sessionLocationName.value;
  get sessionTimeScheduled => formatTimeScheduled();
  get sessionDateScheduled => _sessionDateScheduled.value;
  get genderPref => _genderPref.value;
  get sessionAvailability => _sessionAvailability.value;

  set trainer(value) => _trainer.value = value;
  set user(value) => _user.value = value;
  set sessionMode(value) => _sessionMode.value = value;
  set sessionDurationAndCost(value) => _sessionDurationAndCost.value = value;
  set sessionWorkOutType(value) => _sessionWorkOutType.value = value;
  set sessionLocationCoords(value) => _sessionLocationCoords.value = value;
  set sessionLocationName(value) => _sessionLocationName.value = value;
  set sessionTimeScheduled(value) => _sessionTimeScheduled.value = value;
  set sessionDateScheduled(value) => _sessionDateScheduled.value = value;
  set genderPref(value) => _genderPref.value = value;
  set sessionAvailability(value) => _sessionAvailability.value = value;

  var isSessionTypeLoaded = false.obs;
  var isSessionLengthsLoaded = false.obs;
  var isWorkoutsLoaded = false.obs;
  var homeExpanded = false.obs;

  var allWorkoutTypes = <WorkoutType>[].obs;
  var showingWorkoutTypes = <WorkoutType>[].obs;
  var sessionDurAndCosts = <SessionDurationAndCostModel>[].obs;
  var sessionModes = <SessionModeModel>[].obs;

  final showTimes = false.obs;

  void _fetchWorkOutData() {
    allWorkoutTypes.addAll(WorkoutType.types);
    _sessionWorkOutType.value = allWorkoutTypes[0];
    showingWorkoutTypes.addAll(allWorkoutTypes.getRange(0, 7));
    isWorkoutsLoaded.value = true;
  }

  void toogleShowingWorkouts() {
    isSessionTypeLoaded.value = false;
    homeExpanded.value = !homeExpanded.value;
    if (homeExpanded.isTrue) {
      showingWorkoutTypes.value = allWorkoutTypes;
    } else {
      showingWorkoutTypes.value = allWorkoutTypes.getRange(0, 7).toList();
    }
    isSessionTypeLoaded.toggle();
  }

  void _fetchSessionDurationAndCosts() {
    sessionDurAndCosts.addAll(SessionDurationAndCostModel.sessionOptions);
    _sessionDurationAndCost.value = sessionDurAndCosts[1];
    isSessionLengthsLoaded.value = true;
  }

  void _fethSessionTypes() {
    sessionModes.addAll(SessionModeModel.types);
    _sessionMode.value = sessionModes[0];
    isSessionTypeLoaded.value = true;
  }

  findTrainerForScheduledSession() async {
    Get.bottomSheet(const FutureSessionSearchIndicator(),
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(.5),
        enableDrag: true,
        isDismissible: false,
        isScrollControlled: true);
    List<double> latLng = [
      sessionLocationCoords.latitude,
      sessionLocationCoords.longitude
    ];
    final userName = '${_user.value.firstName} ${_user.value.lastName}';
    final _sessionModel = SessionModel(
      userID: _user.value.id,
      userName: userName,
      userProfilePicURL: _user.value.profilePicURL,
      userStripeID: _user.value.stripeCustomerId,
      userPaymentMethodID: _user.value.activePaymentMethodId,
      sessionCoordinates: latLng,
      sessionLocationName: sessionLocationName,
      futureSessionDate: sessionDateScheduled,
      futureSessionDay: sessionDay,
      futureSessionTime: sessionTimeScheduled,
      sessionID: 'NWLY${DateTime.now().millisecondsSinceEpoch}',
      sessionWorkoutType: sessionWorkOutType.type,
      sessionWorkoutTypeImagePath: sessionWorkOutType.imagePath,
      sessionMode: 'IN PERSON',
      sessionChargedAmount: sessionDurationAndCost.amount,
      sessionDuration: sessionDurationAndCost.duration,
      timeRangeReference: sessionTimeCheckerValue,
      isFutureSession: true,
      isAccepted: false,
      trainerGenderPref: genderPref,
    );
    final _session = SessionModel().toMap(_sessionModel);

    final uid = Get.find<UserController>().user.id;
    final result =
        await SessionServices().findTrainerForScheduledSession(uid, _session);
    // Future.delayed(Duration(seconds: 10), () => Get.back());
    if (result == 'unavailable') {
      Get.back();
      Get.snackbar('No Trainers Available For This Session.',
          'Please Try agian at a later time. Thank you',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          isDismissible: true,
          duration: const Duration(seconds: 5));
    } else {
      Get.back();
      Get.snackbar('Session Scheduled Successfully!.',
          'Upcoming session details will appear in your appointments. Thank you',
          // snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kActiveColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
          isDismissible: true);
    }
  }

  // SESSION COMPLETION METHODS
  final rating = 'Perfect'.obs;
  final positiveTrainerReviewOptions = [
    'Professional',
    'Great Instructions',
    'Great Communication',
    'Patient',
    'Friendly',
    'Awesome Comprehension',
    'Easy Going'
  ];
  final negativeTrainerReviewOptions = [
    'Rude',
    'Unprofessional',
    'Poor Communication',
    'Impatient',
    'Too Aggressive',
    'Hard to work with'
  ];
  final positiveUserReviewOptions = [
    'Coachable',
    'Great Communication',
    'Patient',
    'Friendly',
    'Awesome Comprehension',
    'Goes Hard!',
    'Easy Going'
  ];
  final negativeUserReviewOptions = [
    'Rude',
    'Does not follow direction',
    'Poor Communication',
    'Impatient',
    'Difficult',
    'Hard to work with'
  ];
  final quickReviews = <String>[].obs;
  // get quickReviewOptions => _quickReviewOptions;

  final Rx<double> _starRating = 0.0.obs;
  get starRating => _starRating.value;
  set starRating(value) => _starRating.value = value;

  void calculateRating(double starRating) {
    final stars = starRating;
    if (stars > 4) {
      rating.value = 'Perfect';
    } else if (stars >= 3) {
      rating.value = 'Good';
    } else if (stars >= 2) {
      rating.value = 'Average';
    } else if (stars < 1.9) {
      rating.value = 'Poor';
    }
  }

  submitTrainerRating(String trainerID) async {
    await FirebaseFutures().updateTrainerRating(trainerID, starRating);
  }

  // submitUserRating(String userID) async {
  //   await FirebaseFutures().updateUserRating(userID, starRating);
  // }

  submitTrainerReview(SessionModel session) async {
    _isProccessing.toggle();
    final review = ReviewModel(
        createdAt: Timestamp.now(),
        reviewID: session.sessionID,
        trainerID: session.trainerID,
        trainerName: session.trainerName,
        userID: session.userID,
        userName: session.userName,
        rating: starRating,
        reviewContent: quickReviews);
    await FirebaseFutures().createTrainerReview(review);
    await submitTrainerRating(session.trainerID!);
  }

  // submitUserReview(SessionModel session) async {
  //   _isProccessing.toggle();
  //   final review = ReviewModel(
  //       createdAt: Timestamp.now(),
  //       reviewID: session.sessionID,
  //       trainerID: session.trainerID,
  //       trainerName: session.trainerName,
  //       userID: session.userID,
  //       userName: session.userName,
  //       rating: starRating,
  //       reviewContent: quickReviews);
  //   await FirebaseFutures().createUserReview(review);
  //   await submitUserRating(session.userID!);
  // }

  createSessionReceipt(SessionModel session) async {
    final status = session.reportedIssue! ? 'Complete With ISSUE' : 'Completed';
    final receipt = SessionReceiptModel(
      sessionID: session.sessionID,
      userID: session.userID,
      trainerID: session.trainerID,
      userName: session.userName,
      trainerName: session.trainerName,
      paymentMethod: session.userPaymentMethodID,
      paidTo: session.trainerStripeID,
      sessionTimestamp: Timestamp.now(),
      sessionCharged:
          '\$' + (session.sessionChargedAmount! / 100).toString() + '0',
      sessionMode: session.sessionMode,
      sessionStatus: status,
      sessionDuration: session.sessionDuration,
      // sessionCoordinates: GeoPoint(
      //     session.sessionCoordinates![0], session.sessionCoordinates![1]),
      sessionLocationName: session.sessionLocationName,
      sessionWorkoutType: session.sessionWorkoutType,
    );
    await FirebaseFutures().createSessionReceipt(receipt);
    _isProccessing.toggle();
  }

  // createTrainerSessionReceipt(SessionModel session) async {
  //   final status = session.reportedIssue! ? 'Complete With ISSUE' : 'Completed';
  //   final receipt = SessionReceiptModel(
  //     sessionID: session.sessionID,
  //     userID: session.userID,
  //     trainerID: session.trainerID,
  //     userName: session.userName,
  //     trainerName: session.trainerName,
  //     paymentMethod: session.userPaymentMethodID,
  //     paidTo: session.trainerStripeID,
  //     sessionTimestamp: Timestamp.now(),
  //     sessionCharged:
  //         '\$' + (session.sessionChargedAmount! / 100).toString() + '0',
  //     sessionMode: session.sessionMode,
  //     sessionStatus: status,
  //     sessionDuration: session.sessionDuration,
  //     // sessionCoordinates: GeoPoint(
  //     //     session.sessionCoordinates![0], session.sessionCoordinates![1]),
  //     sessionLocationName: session.sessionLocationName,
  //     sessionWorkoutType: session.sessionWorkoutType,
  //   );
  //   await FirebaseFutures().createTrainerSessionReceipt(receipt);
  //   _isProccessing.toggle();
  // }

  reportIssue(SessionModel session, bool isUSer) async {
    await FirebaseFutures().reportIssueWithSession(session, isUSer);
  }
}
