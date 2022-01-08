import 'package:cloud_firestore/cloud_firestore.dart';

class SessionReceiptModel {
  String? sessionID;
  String? trainerID;
  String? userID;
  String? trainerName;
  String? userProfilePicURL;
  String? trainerProfilePicURL;
  String? userName;
  String? paymentMethod;
  String? paidTo;
  String? sessionStatus;
  Timestamp? sessionTimestamp;
  Timestamp? sessionStartTime;
  Timestamp? sessionEndTime;
  String? sessionDuration;
  String? sessionCharged;
  String? sessionBookingFee;
  String? sessionSalesTax;
  String? sessionMode;
  String? sessionWorkoutType;

  SessionReceiptModel(
      {this.sessionID,
      this.trainerID,
      this.userID,
      this.trainerName,
      this.userName,
      this.userProfilePicURL,
      this.trainerProfilePicURL,
      this.paymentMethod,
      this.paidTo,
      this.sessionStatus,
      this.sessionTimestamp,
      this.sessionStartTime,
      this.sessionEndTime,
      this.sessionDuration,
      this.sessionCharged,
      this.sessionBookingFee,
      this.sessionSalesTax,
      this.sessionMode,
      this.sessionWorkoutType});

  factory SessionReceiptModel.fromDocumentSnapshot(
      Map<String, dynamic>? document, String id) {
    final doc = document!;
    return SessionReceiptModel(
      sessionID: id,
      trainerID: doc['trainerID'],
      userID: doc['userID'],
      trainerName: doc['trainerName'],
      userName: doc['userName'],
      userProfilePicURL: doc['userProfilePicURL'],
      trainerProfilePicURL: doc['trainerProfilePicURL'],
      paymentMethod: doc['paymentMethod'],
      paidTo: doc['paidTo'],
      sessionTimestamp: doc['sessionTimestamp'],
      sessionCharged: doc['sessionCharged'],
      sessionBookingFee: doc['sessionBookingFee'],
      sessionSalesTax: doc['sessionSalesTax'],
      sessionStartTime: doc['sessionStartTime'],
      sessionEndTime: doc['sessionEndTime'],
      sessionDuration: doc['sessionDuration'],
      sessionMode: doc['sessionMode'],
      sessionWorkoutType: doc['sessionWorkoutType'],
      sessionStatus: doc['sessionStatus'],
    );
  }

  Map<String, dynamic> toMap(SessionReceiptModel receipt) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionID'] = receipt.sessionID;
    data['trainerID'] = receipt.trainerID;
    data['userID'] = receipt.userID;
    data['trainerName'] = receipt.trainerName;
    data['userName'] = receipt.userName;
    data['trainerProfilePicURL'] = receipt.trainerProfilePicURL;
    data['userProfilePicURL'] = receipt.userProfilePicURL;
    data['paymentMethod'] = receipt.paymentMethod;
    data['paidTo'] = receipt.paidTo;
    data['sessionTimestamp'] = receipt.sessionTimestamp;
    data['sessionCharged'] = receipt.sessionCharged;
    data['sessionBookingFee'] = receipt.sessionBookingFee;
    data['sessionSalesTax'] = receipt.sessionSalesTax;
    data['sessionStartTime'] = receipt.sessionStartTime;
    data['sessionEndTime'] = receipt.sessionEndTime;
    data['sessionDuration'] = receipt.sessionDuration;
    data['sessionMode'] = receipt.sessionMode;
    data['sessionWorkoutType'] = receipt.sessionWorkoutType;
    data['sessionStatus'] = receipt.sessionStatus;
    return data;
  }
}
