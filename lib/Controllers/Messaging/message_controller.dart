import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nowly/Models/models_exporter.dart';

class MessagingController extends GetxController {
  final UserModel me = UserModel(id: '1');

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  final chat = <MessageModel>[].obs;
  final isFinishedLoading = false.obs;

  @override
  void onReady() {
    fetchMessages();
    super.onReady();
  }

  Future<void> fetchMessages() async {
    await Future.delayed(const Duration(seconds: 2));
    final List<MessageModel> allMessages = MessageModel.getMesseges();
    chat.addAll(allMessages);
    isFinishedLoading.value = true;
  }

  GlobalKey<AnimatedListState> get listKey => _listKey;

  void addMessage(String messege) {
    const position = 0;

    chat.insert(position, MessageModel(ChatUserModel(id: ''), messege));
    _listKey.currentState!.insertItem(position);

    //sample message
    chat.insert(
        position,
        MessageModel(
            ChatUserModel(
                id: '2',
                profileImage:
                    'https://i.pinimg.com/236x/7f/7c/35/7f7c35749870fd4be3eadb4e7c681c69.jpg'),
            'Okay'));
    _listKey.currentState!.insertItem(position);
  }
}
