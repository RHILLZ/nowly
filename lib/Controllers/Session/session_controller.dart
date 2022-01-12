import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Sessions/current_session_details_screen.dart';
import 'package:nowly/Screens/Sessions/session_complete_screen.dart';
import 'package:nowly/Services/Firebase/fcm.dart';
import 'package:nowly/Services/Firebase/firebase_futures.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:nowly/root.dart';
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
      SessionDurationAndCostModel(duration: '', cost: 0, bookingFee: 0).obs;
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

  buildSessionFee() => ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: const Text('Session Fee:'),
      trailing: Text(
          '\$' + (sessionDurationAndCost.cost / 100).toString().split('.')[0])
      // Text('\$$_sessionFee'.split('.')[0]),
      );

  buildBookingFee() {
    final num _sessionFee = (sessionDurationAndCost.cost / 100);
    final num _bookingFee = (_sessionFee * sessionDurationAndCost.bookingFee);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: const Text('Booking Fee:'),
      trailing: Text('\$' + _bookingFee.toStringAsFixed(2)),
    );
  }

  buildSalesTax() {
    final num _sessionFee = (sessionDurationAndCost.cost / 100);
    final num _bookingFee = (_sessionFee * sessionDurationAndCost.bookingFee);
    final sb = _sessionFee + _bookingFee;
    final _city = Get.find<MapController>().city;
    final st = SessionDurationAndCostModel.salesTaxByLoc[_city] ?? 0.0;
    final _salesTax = sb * st;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: const Text('Sales Tax :'),
      trailing: Text('\$' + _salesTax.toStringAsFixed(2)),
    );
  }

  buildTotalCost() {
    final num _sessionFee = (sessionDurationAndCost.cost / 100);
    final num _bookingFee = (_sessionFee * sessionDurationAndCost.bookingFee);
    final sb = _sessionFee + _bookingFee;
    final _city = Get.find<MapController>().city;
    final st = SessionDurationAndCostModel.salesTaxByLoc[_city] ?? 0.0;
    final _salesTax = sb * st;
    final _totalCost = _sessionFee + _bookingFee + _salesTax;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: const Text(
        'Total Cost :',
        style: k20BoldTS,
      ),
      trailing: Text(
        '\$' + _totalCost.toStringAsFixed(2),
        style: k20BoldTS,
      ),
    );
  }

  bool applySalesTax() {
    final num _sessionFee = (sessionDurationAndCost.cost / 100);
    final num _bookingFee = (_sessionFee * sessionDurationAndCost.bookingFee);
    final sb = _sessionFee + _bookingFee;
    final _city = Get.find<MapController>().city;
    final st = SessionDurationAndCostModel.salesTaxByLoc[_city] ?? 0.0;
    final _salesTax = sb * st;
    return _salesTax != 0.0;
  }

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
  set currentSession(value) => _currentSession.value = value;
  set context(value) => _context = value;
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
    final num _sessionFee = (sessionDurationAndCost.cost / 100);
    final num _bookingFee = (_sessionFee * sessionDurationAndCost.bookingFee);
    final sb = _sessionFee + _bookingFee;
    final _city = Get.find<MapController>().city;
    final st = SessionDurationAndCostModel.salesTaxByLoc[_city] ?? 0.0;
    final _salesTax = sb * st;
    final _totalCost = _sessionFee + _bookingFee + _salesTax;
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
      sessionBookingFee: '\$' + _bookingFee.toStringAsFixed(2),
      sessionSalesTax: '\$' + _salesTax.toStringAsFixed(2),
      sessionCharged: '\$' + _totalCost.toStringAsFixed(2),
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

  //SKIP REVIEW
  skip(SessionModel session, context) async {
    final status = session.reportedIssue! ? 'Complete With ISSUE' : 'Completed';
    final num _sessionFee = (sessionDurationAndCost.cost / 100);
    final num _bookingFee = (_sessionFee * sessionDurationAndCost.bookingFee);
    final sb = _sessionFee + _bookingFee;
    final _city = Get.find<MapController>().city;
    final st = SessionDurationAndCostModel.salesTaxByLoc[_city] ?? 0.0;
    final _salesTax = sb * st;
    final _totalCost = _sessionFee + _bookingFee + _salesTax;
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
      sessionBookingFee: '\$' + _bookingFee.toStringAsFixed(2),
      sessionSalesTax: '\$' + _salesTax.toStringAsFixed(2),
      sessionCharged: '\$' + _totalCost.toStringAsFixed(2),
      sessionMode: session.sessionMode,
      sessionStatus: status,
      sessionDuration: session.sessionDuration,
      sessionWorkoutType: session.sessionWorkoutType,
    );
    await FirebaseFutures().incrementSessionCount(session.userID!);
    await FirebaseFutures().createSessionReceipt(receipt);
    Get.to(() => const Root());
    Phoenix.rebirth(context);
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
      ever(_currentSession, (callback) => checkSessionStatus());
      //SEND SIGNAL HEREfire
      AppLogger.i(session);
      FCM().sendInPersonSessionSignal(session, tokenId);
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

  checkSessionStatus() async {
    if (_currentSession.value.sessionStatus == 'cancelled') {
      _currentSession.close();
      Get.off(() => const Root());
      Dialogs().sessionCancelledByOther(_context);
      Phoenix.rebirth(_context!);
      return;
    }
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

//CANCEL SESSION///////////////////////////////////////////////////////////////
  cancel(context) async {
    await FirebaseFutures().cancelSession(_currentSession.value);
    _timer!.isActive ? _timer!.cancel() : null;
    // if (cancelled) {
    //   _currentSession.close();
    //   Get.to(() => const Root());
    //   Dialogs().sessionCancelledByOther(context);
    // }
  }

//END SESSION//////////////////////////////////////////////////////////////////
  endSession(context) async {
    _timer!.cancel();
    Get.off(() => SessionCompleteScreen(
        session: _currentSession.value, sessionController: this));
  }
}
