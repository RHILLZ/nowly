// ignore_for_file: unused_field, avoid_print

import 'dart:async';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Sessions/session_complete_screen.dart';
import 'package:nowly/Screens/Sessions/virtual_session_view.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/BottomSheets/virtual_session_search_bottomsheet.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:nowly/keys.dart';
import 'package:nowly/root.dart';
import 'package:sizer/sizer.dart';

class AgoraController extends GetxController {
  Timer? _timer;
  final Rxn<AgoraClient> _client = Rxn<AgoraClient>();
  final _channel = ''.obs;
  final Rx<UserModel> _user = UserModel().obs;
  // final Rx<TrainerModel> _trainer = TrainerModel().obs;
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

  get isSearching => _isSearching.value;
  get client => _client.value;
  get isJoined => _isJoined.value;
  get sessionTime => _sessionTimer.value;
  get currentSession => _currentSession.value;
  get user => _user.value;
  get trainer => trainer.value;

  set token(value) => _token = value;
  set user(value) => _user.value = value;
  // set trainer(value) => _trainer.value = value;
  set currentSession(value) => _currentSession.value = value;
  set sessionDuration(value) => _sessionDuration = value;
  set sessionAmount(value) => _sessionAmount = value;
  set sessionDescription(value) => _sessionDescription = value;
  set connectId(value) => _connectId = value;
  set sessionTimer(value) => _sessionTimer.value = value;
  set sessionController(value) => _sessionController.value = value;

  @override
  void onInit() async {
    super.onInit();
    AppLogger.i('WE Live');
    ever(_sessionTimer, (callback) => checkSessionTimer());
    _sessionController.value = Get.find<SessionController>();
    ever(_currentSession, (callback) => isAccepted(_context));
  }

  updateSession() async {
    AppLogger.i('UPDATING SESSION');
    _currentSession.bindStream(
        FirebaseStreams().streamSession(_currentSession.value.sessionID!));
  }

  initAgora() async {
    AppLogger.i('HERE!!');
    final agoraConnectionData =
        AgoraConnectionData(appId: AGORA_ID, channelName: _channel.value);
    final enabledPermission = [Permission.microphone, Permission.camera];
    _client.value = AgoraClient(
        agoraEventHandlers: AgoraEventHandlers(
          joinChannelSuccess: (channel, uid, elapsed) => userJoin(),
          userJoined: (uid, elapsed) => trainerJoin(),
          leaveChannel: (stats) => kill(),
          localVideoStateChanged: (state, err) =>
              state == LocalVideoStreamState.Stopped ? kill() : null,
          remoteVideoStateChanged: (uid, state, reason, elapsed) =>
              state == VideoRemoteState.Stopped ? kill() : null,
        ),
        agoraConnectionData: agoraConnectionData,
        enabledPermission: enabledPermission);
    _client.value!.sessionController.value.generatedToken = _token;
    await client.initialize();
  }

  BuildContext? _context;

  void startSession(
      BuildContext context, SessionModel session, AgoraController agora) async {
    _context = context;
    _isSearching.toggle();
    String _agoraToken =
        await AgoraService().generateAgoraToken(session.sessionID!);
    _token = _agoraToken;
    _channel.value = session.sessionID!;
    // ignore: unused_local_variable
    final sess = SessionModel().toMap(session);
    final sessionCreated =
        await initTrainerSearch(_agoraToken, session, context);
    if (sessionCreated) {
      updateSession();
    }
  }

  isAccepted(_context) async {
    if (_currentSession.value.isAccepted) {
      await initAgora();
      _isSearching.toggle();
      Get.off(() => VideoCallView(
            agoraController: this,
          ));
    }
    if (_currentSession.value.sessionStatus == 'unanswered') {
      _isSearching.toggle();
      Get.dialog(Dialogs().noTrainersUnavailable(_context));
    }
  }

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
    _client.value?.sessionController.dispose();
    _client.value?.sessionController.endCall();

    Future.delayed(
        const Duration(seconds: 1),
        () => Get.off(() => SessionCompleteScreen(
              session: _currentSession.value,
              sessionController: _sessionController.value,
            )));
  }

  cancel() {
    Get.back();
    _timer!.cancel();
    _client.value?.sessionController.dispose();
    _client.value?.sessionController.endCall();
    Get.off(() => const Root());
  }

  void userJoin() {
    AppLogger.i('USER JOINED!!!');
    // Get.bottomSheet(VirtualSessionInitSearch(),
    //     isDismissible: false,
    //     enableDrag: false,
    //     backgroundColor: Colors.transparent);
  }

  void trainerJoin() async {
    AppLogger.i('TRAINER JOINED!!!');
    startSessionTimer();
    updateSession();
    _isJoined.toggle();
    Get.isBottomSheetOpen != null ? Get.back() : null;
  }

  void startSessionTimer() {
    const sec = Duration(seconds: 1);
    _timer = Timer.periodic(sec, (timer) => _sessionTimer.value--);
  }

  buildTimer() {
    final String minutes = _formatNumber(_sessionTimer.value ~/ 60);
    final String seconds = _formatNumber(_sessionTimer.value % 60);
    return Text('$minutes : $seconds',
        style: TextStyle(
            fontSize: 18.sp,
            color: Get.isDarkMode ? Colors.blue : Colors.white));
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }

  void checkSessionTimer() {
    var check = _sessionTimer.value == 0;
    if (check) {
      _timer!.cancel();
      kill();
    }
  }
}
