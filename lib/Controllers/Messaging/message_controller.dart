import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nowly/Controllers/Auth/auth_controller.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/logger.dart';

class MessagingController extends GetxController {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final _message = ''.obs;

  get message => _message.value;

  set message(value) => _message.value = value;

  GlobalKey<AnimatedListState> get listKey => _listKey;

  final isFinishedLoading = false.obs;

  // var chat = <MessageModel>[].obs;
  final _chatx = [].obs;
  SessionModel session = SessionModel();

  get chatx => _chatx.reversed.toList();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chatx.bindStream(FirebaseStreams().streamChat('123456789'));
  }

  @override
  void onReady() {
    super.onReady();
    fetchChat();
  }

  fetchChat() async {
    await Future.delayed(const Duration(seconds: 2));
    isFinishedLoading.toggle();
  }

  sendMessage() async {
    final message = MessageModel(
        senderId: Get.find<AuthController>().firebaseUser.uid,
        message: _message.value,
        timestamp: Timestamp.now());
    final sent = await FirebaseFutures().sendMessage('123456789', message);

    if (sent) {
      _message.value = '';
    } else {
      Get.snackbar('Something wrong', 'Message not sent');
    }
  }
}
