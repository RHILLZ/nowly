// ignore_for_file: unused_field, avoid_print

import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Sessions/session_complete_screen.dart';
import 'package:nowly/Screens/Sessions/virtual_session_view.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/env.dart';
import 'package:nowly/Utils/app_logger.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:nowly/root.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class AgoraController extends GetxController {
  Timer? _timer;
  late RtcEngine _engine;
  final _channel = ''.obs;
  final Rx<UserModel> _user = UserModel().obs;
  final Rx<SessionModel> _currentVirtualSession = SessionModel().obs;
  final RxBool _isJoined = false.obs;
  final _sessionTimer = 0.obs;
  Duration _sessionDuration = const Duration(minutes: 30);
  String? _token;
  int? _sessionAmount;
  String? _sessionDescription;
  String? _connectId;
  final _sessionController = SessionController().obs;
  final _isSearching = false.obs;
  final _localUserJoined = false.obs;
  int? _remoteUid;
  BuildContext? _context;
  final _isMuted = false.obs;
  final _cameraOff = false.obs;
  final _infoWindowHidden = false.obs;

//GETTERS AND SETTERS////////////////////////////////////////////////////////////
  get isSearching => _isSearching.value;
  get isJoined => _isJoined.value;
  get sessionTimer => _sessionTimer.value;
  get currentVirtualSession => _currentVirtualSession.value;
  get user => _user.value;
  get trainer => trainer.value;
  get remoteUid => _remoteUid;
  get localUserJoined => _localUserJoined.value;
  get isMuted => _isMuted.value;
  get cameraOff => _cameraOff.value;
  get infoWindowHidden => _infoWindowHidden.value;

  set token(value) => _token = value;
  set user(value) => _user.value = value;
  set currentVirtualSession(value) => _currentVirtualSession.value = value;
  set sessionDuration(value) => _sessionDuration = value;
  set sessionAmount(value) => _sessionAmount = value;
  set sessionDescription(value) => _sessionDescription = value;
  set connectId(value) => _connectId = value;
  set sessionTimer(value) => _sessionTimer.value = value;
  set sessionController(value) => _sessionController.value = value;
  set isMuted(value) => _isMuted.value = value;
  set cameraOff(value) => _cameraOff.value = value;
  set context(value) => _context = value;

  toggleInfoWindow() {
    _infoWindowHidden.toggle();
  }

  @override
  void onInit() async {
    super.onInit();
    AppLogger.info('WE Live');
    ever(_sessionTimer, (callback) => checkSessionTimer());
    _sessionController.value = Get.find<SessionController>();
    ever(_currentVirtualSession, (callback) => isAccepted(_context));
  }

//STREAM SESSION AND LISTEN FFOR CHANGES///////////////////////////////////////
  updateSession() async {
    AppLogger.info('UPDATING SESSION');
    _currentVirtualSession.bindStream(FirebaseStreams()
        .streamSession(_currentVirtualSession.value.sessionID!));
  }

//INIT THE AGORA CLIENT////////////////////////////////////////////////////////
  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();
    //create the engine
    _engine = await RtcEngine.create(Env.agoraId);
    await _engine.enableVideo();
    AppLogger.info('CREATED ENGINE');
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          AppLogger.info("local user $uid joined");
          _localUserJoined.value = true;
        },
        userJoined: (int uid, int elapsed) {
          AppLogger.info("remote user $uid joined");
          _remoteUid = uid;
          trainerJoin();
        },
        userOffline: (int uid, UserOfflineReason reason) {
          AppLogger.info("remote user $uid left channel");
          _remoteUid = null;
        },
        remoteVideoStateChanged: (uid, state, reason, elapsed) {
          state == VideoRemoteState.Stopped ? kill() : null;
        },
        leaveChannel: (stats) => kill(),
      ),
    );
    _token = await AgoraService()
        .generateAgoraToken(currentVirtualSession.sessionID!);
    await _engine.joinChannel(_token, _channel.value, null, 0);
  }

////////////////////////////////////////////////////////////////////////////

//START A VIRTUAL SESSION/////////////////////////////////////////////////////
  void startSession(BuildContext context, SessionModel session) async {
    // TODO: Init Stripe Intent here
    _context = context;
    _isSearching.toggle();
    _channel.value = session.sessionID!;
    // ignore: unused_local_variable
    final sess = SessionModel().toMap(session);
    final sessionCreated = await initTrainerSearch(session, context);
    if (sessionCreated) {
      updateSession();
    }
  }

  //////////////////////////////////////////////////////////////////////////
//LISTENING FOR SESSION TO BE ACCEPTED///////////////////////////////////////
  isAccepted(_context) async {
    if (_currentVirtualSession.value.isAccepted &&
        _currentVirtualSession.value.sessionStatus == 'created') {
      // await initAgora();
      try {
        await Stripe.instance
        .confirmPaymentSheetPayment();

        Get.snackbar(
          'Success', 
          'Payment Complete',
        );

        _isSearching.toggle();
        unawaited(Get.to(() => VideoCallView(
              agoraController: this,
            ),),
        );
      } on StripeException catch (e) {
        Get.snackbar(
          'Payment Issue',
          'Error: ${e.error}',
        );
        //TODO: Implement user being sent back to find another trainer due to failing a transaction
      }
    }
    if (_currentVirtualSession.value.sessionStatus == 'unanswered') {
      _isSearching.toggle();
      Dialogs().noTrainersUnavailable(_context);
      _currentVirtualSession.close();
    }
  }

////////////////////////////////////////////////////////////////////////////
  initTrainerSearch(SessionModel session, BuildContext context) async {
    final uid = session.userID!;
    final sessionData = SessionModel().toMap(session);
    final result = await SessionServices().findVirtualTrainer(uid, sessionData);
    return result;
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }

  void kill() async {
    AppLogger.info('KILL INITIATED!!!');
    _isJoined.toggle();
    _timer!.cancel();
    _engine.destroy();

    Future.delayed(
        const Duration(seconds: 1),
        () => Get.off(() => SessionCompleteScreen(
              session: _currentVirtualSession.value,
              sessionController: _sessionController.value,
            )));
  }

//CANCEL A SESSION
  cancel(context) async {
    final cancelled =
        await FirebaseFutures().cancelSession(_currentVirtualSession.value);
    if (cancelled) {
      _isSearching.toggle();
      await Dialogs().sessionCancelled(context);
      _currentVirtualSession.close();
      Get.off(() => const Root());
      Phoenix.rebirth(context);
    }
  }

  void trainerJoin() async {
    AppLogger.info('TRAINER JOINED!!!');
    startSessionTimer();
    updateSession();
    _isJoined.toggle();
    // Get.isBottomSheetOpen != null ? Get.back() : null;
  }

//VIRTUAL SESSION TIMER/////////////////////////////////////////////////////////
  void startSessionTimer() {
    const sec = Duration(seconds: 1);
    _timer = Timer.periodic(sec, (timer) => _sessionTimer.value--);
  }

  buildTimer() {
    final String minutes = _formatNumber(_sessionTimer.value ~/ 60);
    final String seconds = _formatNumber(_sessionTimer.value % 60);
    return Text('$minutes : $seconds',
        style: TextStyle(
            fontSize: 16.sp,
            color: Get.isDarkMode ? Colors.blue : Colors.white));
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }

//////////////////////////////////////////////////////////////////////////////
//CHECK FOR END OF SESSION////////////////////////////////////////////////
  void checkSessionTimer() {
    var check = _sessionTimer.value == 0;
    if (check) {
      _timer!.cancel();
      kill();
    }
  }

  void toggleAudio() {
    _isMuted.toggle();
    if (isMuted) {
      _engine.enableAudio();
    } else {
      _engine.disableAudio();
    }
  }

  void toggleVideo() {
    _cameraOff.toggle();
    if (cameraOff) {
      _engine.enableVideo();
    } else {
      _engine.disableVideo();
    }
  }
}
