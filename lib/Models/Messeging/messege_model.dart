import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? senderId;
  String? message;
  Timestamp? timestamp;

  MessageModel({this.senderId, this.message, this.timestamp});

  factory MessageModel.fromDocumentSnapshot(Map<String, dynamic>? document) {
    final doc = document!;
    return MessageModel(
        senderId: doc['senderId'],
        message: doc['message'],
        timestamp: doc['timestamp']);
  }

  Map<String, dynamic> toMap(MessageModel message) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = message.senderId;
    data['message'] = message.message;
    data['timestamp'] = message.timestamp;
    return data;
  }

  List<MessageModel> chat() {
    var chat = <MessageModel>[
      MessageModel(
          senderId: 'trainer', message: 'hello', timestamp: Timestamp.now()),
      MessageModel(
          senderId: 'user', message: 'hey', timestamp: Timestamp.now()),
      MessageModel(
          senderId: 'trainer',
          message: 'im by the restrooms',
          timestamp: Timestamp.now()),
      MessageModel(
          senderId: 'user',
          message: 'ok im parking',
          timestamp: Timestamp.now()),
      MessageModel(
          senderId: 'trainer', message: 'awesome', timestamp: Timestamp.now()),
    ];

    return chat;
  }
}
