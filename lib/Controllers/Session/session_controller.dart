import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Sessions/current_session_details_screen.dart';
import 'package:nowly/Screens/Sessions/session_complete_screen.dart';
import 'package:nowly/Services/Firebase/firebase_futures.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';
import '../controller_exporter.dart';

class SessionController extends GetxController {
  final _user = UserModel().obs;
  final _trainer = TrainerModel().obs;
  final _isProcessing = false.obs;
  final _currentSession = SessionModel().obs;
  Timer? _timer;
  final RxInt _sessionTime = 0.obs;
  BuildContext? _context;

  //SESSION PARMAS
  final _sessionMode = SessionModeModel(id: '', mode: '').obs;
  final _sessionDurationAndCost =
      SessionDurationAndCostModel(duration: '', cost: 0).obs;
  final _sessionWorkOutType =
      WorkoutType(imagePath: '', type: '', headerData: []).obs;
  final _genderPref = ''.obs;
  final _sessionIssueContext = ''.obs;
  final _sessionEta = ''.obs;

  var isSessionTypeLoaded = false.obs;
  var isSessionLengthsLoaded = false.obs;
  var isWorkoutsLoaded = false.obs;
  var homeExpanded = false.obs;

  var allWorkoutTypes = <WorkoutType>[].obs;
  var showingWorkoutTypes = <WorkoutType>[].obs;
  var sessionDurAndCosts = <SessionDurationAndCostModel>[].obs;
  var sessionModes = <SessionModeModel>[].obs;

  final showTimes = false.obs;
//GETTERS AND SETTERS////////////////////////////////////////////////////////
  get isProcessing => _isProcessing.value;
  get currentSession => _currentSession.value;
  get sessionTime => _sessionTime.value;
  get user => _user.value;
  get trainer => _trainer.value;
  get sessionMode => _sessionMode.value;
  get sessionDurationAndCost => _sessionDurationAndCost.value;
  get sessionWorkOutType => _sessionWorkOutType.value;
  get genderPref => _genderPref.value;
  get sessionEta => _sessionEta.value;

  set sessionEta(value) => _sessionEta.value = value;
  set sessionIssueContext(value) => _sessionIssueContext.value = value;
  set trainer(value) => _trainer.value = value;
  set user(value) => _user.value = value;
  set sessionMode(value) => _sessionMode.value = value;
  set sessionDurationAndCost(value) => _sessionDurationAndCost.value = value;
  set sessionWorkOutType(value) => _sessionWorkOutType.value = value;
  set genderPref(value) => _genderPref.value = value;
  set sessionTime(value) => _sessionTime.value = value;
//SESSION CLOCK//////////////////////////////////////////////////////////////
  void startSessionTimer() {
    const sec = Duration(seconds: 1);
    _timer = Timer.periodic(sec, (timer) => _sessionTime.value--);
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }

  buildTimer() {
    final String minutes = _formatNumber(_sessionTime.value ~/ 60);
    final String seconds = _formatNumber(_sessionTime.value % 60);
    return Text('$minutes : $seconds',
        style: TextStyle(fontSize: 60.sp, color: kPrimaryColor));
  }

  @override
  void onInit() {
    super.onInit();
    ever(_currentSession, (callback) => checkAccepted());
    ever(_sessionEta, (callback) => updateEta());
    _fetchWorkOutData();
    _fetchSessionDurationAndCosts();
    _fethSessionTypes();
  }

//INITIAL METHODS AND LOADERS//////////////////////////////////////////////////
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

  submitTrainerRating(String trainerID, double rating) async {
    await FirebaseFutures().updateTrainerRating(trainerID, rating);
  }

  submitTrainerReview(SessionModel session) async {
    _isProcessing.toggle();
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
    await submitTrainerRating(session.trainerID!, starRating);
  }

//CREATE SESSION RECIEPT ON COMPLETE///////////////////////////////////////////
  createSessionReceipt(SessionModel session) async {
    final status = session.reportedIssue! ? 'Complete With ISSUE' : 'Completed';
    final receipt = SessionReceiptModel(
      sessionID: session.sessionID,
      userID: session.userID,
      trainerID: session.trainerID,
      userName: session.userName,
      trainerName: session.trainerName,
      userProfilePicURL: session.userProfilePicURL,
      trainerProfilePicURL: session.trainerProfilePicURL,
      paymentMethod: session.userPaymentMethodID,
      paidTo: session.trainerStripeID,
      sessionTimestamp: Timestamp.now(),
      sessionCharged:
          '\$' + (session.sessionChargedAmount! / 100).toString() + '0',
      sessionMode: session.sessionMode,
      sessionStatus: status,
      sessionDuration: session.sessionDuration,
      sessionWorkoutType: session.sessionWorkoutType,
    );
    await FirebaseFutures().incrementSessionCount(session.userID!);
    await FirebaseFutures().createSessionReceipt(receipt);
    _isProcessing.toggle();
  }

  reportIssue(SessionModel session, bool isUSer) async {
    await FirebaseFutures().reportIssueWithSession(session, isUSer);
  }

  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    super.onClose();
    _timer!.cancel();
  }

  final qrLoaded = false.obs;

  loadQr() async {
    await Future.delayed(
        const Duration(seconds: 3), () => qrLoaded.value = true);
  }

//ENGAGE A TRAINER FOR IN PERSON SESSION////////////////////////////////////////
  engageTrainer(SessionModel sess, String tokenId, BuildContext context) async {
    _isProcessing.toggle();
    _context = context;
    final session = SessionModel().toMap(sess);
    final sessionCreated = await FirebaseFutures().createNewSession(sess);

    if (sessionCreated) {
      _currentSession
          .bindStream(FirebaseStreams().streamSession(sess.sessionID!));
      await Future.delayed(const Duration(seconds: 2), () => null);
      OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [tokenId],
          content: 'In Person',
          heading: 'InPerson',
          additionalData: {'session': session, 'signal_Type': 'in person'},
          contentAvailable: true));
      // trainerUnavailable();
    } else {
      _isProcessing.toggle();
      Get.snackbar('Something went wrong.',
          'Unable to engage trainer at this time. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

//CHECK IF SESSION IS ACCEPTED AFTER ITS CREATED////////////////////////////////
  checkAccepted() {
    if (_currentSession.value.isAccepted == true &&
        !_currentSession.value.isScanned) {
      _isProcessing.toggle();
      Get.to(() => CurrentSessionDetailsScreen(
            session: _currentSession.value,
            mapNavController: Get.find<MapNavigatorController>(),
            trainerSessionC: Get.find<TrainerInPersonSessionController>(),
            sessionController: this,
          ));
      return;
    }

    if (_currentSession.value.isScanned == true) {
      startSessionTimer();
      return;
    }
    trainerUnavailable();
  }

//FIRES WHEN TRAIINER IS UNAVAILABLE///////////////////////////////////////////
  trainerUnavailable() {
    Future.delayed(const Duration(seconds: 15), () {
      if (_currentSession.value.isAccepted == false) {
        _isProcessing.toggle();
        Dialogs().trainerUnavailable(_context);
      }
    });
  }

//UPDATE ETA WHILE EN ROUTE/////////////////////////////////////////////////////
  updateEta() async {
    final eta = _sessionEta.value;
    AppLogger.i('ETA: $eta');

    if (_currentSession.value.sessionID != null) {
      await FirebaseFutures().updateETA(_currentSession.value, eta);
    }
  }

//END SESSION//////////////////////////////////////////////////////////////////
  endSession(context) async {
    await Dialogs().sessionCancellation(
        context,
        () => Get.off(() => SessionCompleteScreen(
            session: _currentSession.value, sessionController: this)));
  }
}
