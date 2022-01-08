// ignore_for_file: unused_field, avoid_print

import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Sessions/session_complete_screen.dart';
import 'package:nowly/Screens/Sessions/virtual_session_view.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:nowly/keys.dart';
import 'package:nowly/root.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class AgoraController extends GetxController {
  Timer? _timer;
  late RtcEngine _engine;
  final _channel = ''.obs;
  final Rx<UserModel> _user = UserModel().obs;
  final Rx<SessionModel> _currentSession = SessionModel().obs;
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
  get currentSession => _currentSession.value;
  get user => _user.value;
  get trainer => trainer.value;
  get remoteUid => _remoteUid;
  get localUserJoined => _localUserJoined.value;
  get isMuted => _isMuted.value;
  get cameraOff => _cameraOff.value;
  get infoWindowHidden => _infoWindowHidden.value;

  set token(value) => _token = value;
  set user(value) => _user.value = value;
  set currentSession(value) => _currentSession.value = value;
  set sessionDuration(value) => _sessionDuration = value;
  set sessionAmount(value) => _sessionAmount = value;
  set sessionDescription(value) => _sessionDescription = value;
  set connectId(value) => _connectId = value;
  set sessionTimer(value) => _sessionTimer.value = value;
  set sessionController(value) => _sessionController.value = value;
  set isMuted(value) => _isMuted.value = value;
  set cameraOff(value) => _cameraOff.value = value;

  toggleInfoWindow() {
    _infoWindowHidden.toggle();
  }

  @override
  void onInit() async {
    super.onInit();
    AppLogger.i('WE Live');
    ever(_sessionTimer, (callback) => checkSessionTimer());
    _sessionController.value = Get.find<SessionController>();
    ever(_currentSession, (callback) => isAccepted(_context));
  }

//STREAM SESSION AND LISTEN FFOR CHANGES///////////////////////////////////////
  updateSession() async {
    AppLogger.i('UPDATING SESSION');
    _currentSession.bindStream(
        FirebaseStreams().streamSession(_currentSession.value.sessionID!));
  }

//INIT THE AGORA CLIENT////////////////////////////////////////////////////////
  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();
    //create the engine
    _engine = await RtcEngine.create(AGORA_ID);
    await _engine.enableVideo();
    AppLogger.i('CREATED ENGINE');
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          AppLogger.i("local user $uid joined");
          _localUserJoined.value = true;
        },
        userJoined: (int uid, int elapsed) {
          AppLogger.i("remote user $uid joined");
          _remoteUid = uid;
          trainerJoin();
        },
        userOffline: (int uid, UserOfflineReason reason) {
          AppLogger.i("remote user $uid left channel");
          _remoteUid = null;
        },
        remoteVideoStateChanged: (uid, state, reason, elapsed) {
          state == VideoRemoteState.Stopped ? kill() : null;
        },
        leaveChannel: (stats) => kill(),
      ),
    );
    _token = await AgoraService().generateAgoraToken(currentSession.sessionID!);
    await _engine.joinChannel(_token, _channel.value, null, 0);
  }

////////////////////////////////////////////////////////////////////////////

//START A VIRTUAL SESSION/////////////////////////////////////////////////////
  void startSession(
      BuildContext context, SessionModel session, AgoraController agora) async {
    _context = context;
    _isSearching.toggle();
    // String _agoraToken =
    //     await AgoraService().generateAgoraToken(session.sessionID!);
    // _token = _agoraToken;
    _channel.value = session.sessionID!;
    // ignore: unused_local_variable
    final sess = SessionModel().toMap(session);
    final sessionCreated = await initTrainerSearch('', session, context);
    if (sessionCreated) {
      updateSession();
    }
  }

  //////////////////////////////////////////////////////////////////////////
//LISTENING FOR SESSION TO BE ACCEPTED///////////////////////////////////////
  isAccepted(_context) async {
    if (_currentSession.value.isAccepted) {
      // await initAgora();
      _isSearching.toggle();
      Get.to(() => VideoCallView(
            agoraController: this,
          ));
    }
    if (_currentSession.value.sessionStatus == 'unanswered') {
      _isSearching.toggle();
      final result = Dialogs().noTrainersUnavailable(_context);
      AppLogger.i(result);
    }
  }

////////////////////////////////////////////////////////////////////////////
  initTrainerSearch(
      String agoraToken, SessionModel session, BuildContext context) async {
    final uid = session.userID!;
    final sessionData = SessionModel().toMap(session);
    final result = await SessionServices()
        .findVirtualTrainer(uid, agoraToken, sessionData);

    return result;
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }

  void kill() async {
    AppLogger.i('KILL INITIATED!!!');
    _isJoined.toggle();
    _timer!.cancel();
    _engine.destroy();

    Future.delayed(
        const Duration(seconds: 1),
        () => Get.off(() => SessionCompleteScreen(
              session: _currentSession.value,
              sessionController: _sessionController.value,
            )));
  }

//CANCEL A SESSION
  cancel(context) async {
    final cancelled =
        await FirebaseFutures().cancelSession(_currentSession.value);
    _isSearching.toggle();
    await Dialogs().sessionCancelled(context);
    Get.off(() => const Root());
  }

  void userJoin() {
    AppLogger.i('USER JOINED!!!');
    Get.bottomSheet(VirtualSessionInitSearch(),
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent);
  }

  void trainerJoin() async {
    AppLogger.i('TRAINER JOINED!!!');
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
