import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  String? id;
  String? name;
  String? message;
  Timestamp? timestamp;

  FeedbackModel({this.id, this.name, this.message, this.timestamp});

  Map<String, dynamic> toMap(FeedbackModel feedback) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = feedback.id;
    data['name'] = feedback.name;
    data['message'] = feedback.message;
    data['timestamp'] = feedback.timestamp;
    return data;
  }
}
