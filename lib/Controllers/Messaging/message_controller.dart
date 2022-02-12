import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/service_exporter.dart';

class MessagingController extends GetxController {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final AudioCache _player = AudioCache(prefix: 'assets/audio/');
  final _message = ''.obs;
  final _sessionId = ''.obs;
  final _showBadge = false.obs;

  get showBadge => _showBadge.value;
  set showBadge(value) => _showBadge.value = value;
  get message => _message.value;
  set message(value) => _message.value = value;
  set sessionId(value) => _sessionId.value = value;

  GlobalKey<AnimatedListState> get listKey => _listKey;

  final isFinishedLoading = false.obs;

  // var chat = <MessageModel>[].obs;
  final _chatx = [].obs;
  SessionModel session = SessionModel();

  get chatx => _chatx.reversed.toList();

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    _sessionId.value = Get.find<SessionController>().currentSession.sessionID!;
    ever(_chatx, (callback) => shouldShowBadge());
  }

  @override
  void onReady() {
    super.onReady();
    _chatx.bindStream(FirebaseStreams().streamChat(_sessionId.value));
    ever(_chatx, (callback) => shouldShowBadge());
    fetchChat();
  }

  fetchChat() async {
    // _chatx.bindStream(FirebaseStreams().streamChat(_sessionId.value));
    await Future.delayed(const Duration(seconds: 2));
    isFinishedLoading.toggle();
  }

  sendMessage() async {
    final message = MessageModel(
        senderId: Get.find<AuthController>().firebaseUser.uid,
        message: _message.value,
        timestamp: Timestamp.now());
    final sent = await FirebaseFutures().sendMessage(_sessionId.value, message);

    if (sent) {
      _message.value = '';
    } else {
      Get.snackbar('Something wrong', 'Message not sent');
    }
  }

  shouldShowBadge() {
    if (_chatx.last.senderId == Get.find<AuthController>().firebaseUser.uid) {
      return;
    }
    _showBadge.value = true;
    _player.load('message.wav');
    _player.play('message.wav');
  }
}
