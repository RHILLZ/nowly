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
  String? sessionDate;
  String? sessionDay;
  GeoPoint? sessionCoordinates;
  String? sessionLocationName;
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
      this.sessionCoordinates,
      this.sessionLocationName,
      this.sessionDate,
      this.sessionDay,
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
      sessionStartTime: doc['sessionStartTime'],
      sessionEndTime: doc['sessionEndTime'],
      sessionDuration: doc['sessionDuration'],
      sessionLocationName: doc['sessionLocationName'],
      sessionCoordinates: doc['sessionCoordinates'],
      sessionMode: doc['sessionMode'],
      sessionDate: doc['sessionDate'],
      sessionDay: doc['sessionDay'],
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
    data['sessionStartTime'] = receipt.sessionStartTime;
    data['sessionEndTime'] = receipt.sessionEndTime;
    data['sessionDuration'] = receipt.sessionDuration;
    data['sessionLocationName'] = receipt.sessionLocationName;
    data['sessionMode'] = receipt.sessionMode;
    data['sessionDate'] = receipt.sessionDate;
    data['sessionDay'] = receipt.sessionDay;
    data['sessionCoordinates'] = receipt.sessionCoordinates;
    data['sessionWorkoutType'] = receipt.sessionWorkoutType;
    data['sessionStatus'] = receipt.sessionStatus;

    return data;
  }
}
