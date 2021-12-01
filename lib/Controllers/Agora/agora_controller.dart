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
import 'package:nowly/keys.dart';
import 'package:sizer/sizer.dart';

class AgoraController extends GetxController {
  Timer? _timer;
  final Rxn<AgoraClient> _client = Rxn<AgoraClient>();
  final _channel = ''.obs;
  final Rx<UserModel> _user = UserModel().obs;
  // final Rx<TrainerModel> _trainer = TrainerModel().obs;
  final Rx<SessionModel> _session = SessionModel().obs;
  final RxBool _isJoined = false.obs;
  final _sessionTimer = 60.obs;
  Duration _sessionDuration = const Duration(minutes: 30);
  String? _token;
  int? _sessionAmount;
  String? _sessionDescription;
  String? _connectId;
  final _sessionController = SessionController().obs;

  get client => _client.value;
  get isJoined => _isJoined.value;
  get sessionTime => _sessionTimer.value;
  get session => _session.value;
  get user => _user.value;
  get trainer => trainer.value;
  get channel => _channel.value;

  set channel(value) => _channel.value = value;
  set token(value) => _token = value;
  set user(value) => _user.value = value;
  // set trainer(value) => _trainer.value = value;
  set session(value) => _session.value = value;
  set sessionDuration(value) => _sessionDuration = value;
  set sessionAmount(value) => _sessionAmount = value;
  set sessionDescription(value) => _sessionDescription = value;
  set connectId(value) => _connectId = value;
  set sessionTimer(value) => _sessionTimer.value = value;
  set sessionController(value) => _sessionController.value = value;

  final tempToken =
      '00650efca7fe96a4631b60918eaa56caa6bIADtsNwnBGGsqKDOEKBoKJ6HGF2eZFKZa+DgqLwVEnrZEYJKSjIAAAAAEACpCW2YeaejYQEAAQB5p6Nh';
  // // final agoraAppId = 'd1353733bdf44f40b7f784942624a8de';
  final tempChannelName = 'nowly';

  @override
  void onInit() async {
    super.onInit();
    AppLogger.i('WE Live');
    // once(_sessionTimer, (callback) => updateSession());
    ever(_sessionTimer, (callback) => checkSessionTimer());
    _sessionController.value = Get.find<SessionController>();
  }

  updateSession() async {
    _session
        .bindStream(FirebaseStreams().streamSession(_session.value.sessionID!));
  }

//  AgoraConnectionData agoraConnectionData = AgoraConnectionData(
//         appId: AGORA_ID, channelName: 'nowly', tempToken: '00650efca7fe96a4631b60918eaa56caa6bIADtsNwnBGGsqKDOEKBoKJ6HGF2eZFKZa+DgqLwVEnrZEYJKSjIAAAAAEACpCW2YeaejYQEAAQB5p6Nh');
// var enabledPermission = [Permission.microphone, Permission.camera];
  initAgora(context) async {
    _client.value = AgoraClient(
        agoraEventHandlers: AgoraEventHandlers(
          joinChannelSuccess: (channel, uid, elapsed) => userJoin(context),
          userJoined: (uid, elapsed) => trainerJoin(),
          leaveChannel: (stats) => kill(),
          localVideoStateChanged: (state, err) =>
              state == LocalVideoStreamState.Stopped ? kill() : null,
          remoteVideoStateChanged: (uid, state, reason, elapsed) =>
              state == VideoRemoteState.Stopped ? kill() : null,
        ),
        agoraConnectionData:
            AgoraConnectionData(appId: AGORA_ID, channelName: _channel.value),
        enabledPermission: [Permission.microphone, Permission.camera]);

    _client.value!.sessionController.value.generatedToken = _token;
    await client.initialize();
  }

  void startSession(
      BuildContext context, SessionModel session, AgoraController agora) async {
    final _agoraToken =
        await AgoraService().generateAgoraToken(session.sessionID!);
    AppLogger.i(_agoraToken);
    _token = _agoraToken;
    _channel.value = session.sessionID!;
    // ignore: unused_local_variable
    final sess = SessionModel().toMap(session);
    AppLogger.i(_token);
    initTrainerSearch(_agoraToken, session);
    await initAgora(context);
    Get.to(() => VideoCallView(
          agoraController: agora,
        ));
  }

  initTrainerSearch(String agoraToken, SessionModel session) async {
    final uid = session.userID!;
    AppLogger.i(uid);
    final sessionData = SessionModel().toMap(session);
    SessionServices().findVirtualTrainer(uid, agoraToken, sessionData);
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
    _sessionTimer.value = 0;
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
              session: _session.value,
              sessionController: _sessionController.value,
            )));
  }

  void userJoin(context) {
    AppLogger.i('USER JOINED!!!');
    Get.bottomSheet(const VirtualSessionInitSearch(),
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent);
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
        style: TextStyle(fontSize: 18.sp, color: Colors.blue));
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
