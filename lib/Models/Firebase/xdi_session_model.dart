import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  String? sessionID;
  String? trainerID;
  String? userID;
  String? userName;
  String? userStripeID;
  String? userPaymentMethodID;
  String? userProfilePicURL;
  String? trainerProfilePicURL;
  String? trainerName;
  String? trainerStripeID;
  String? trainerGenderPref;
  Timestamp? sessionCreatedAt;
  Timestamp? sessionStartTime;
  Timestamp? sessionEndTime;
  double? timeRangeReference;
  bool isAccepted;
  bool isFutureSession;
  String? futureSessionDate;
  String? futureSessionDay;
  String? futureSessionTime;
  String? sessionDuration;
  bool? reportedIssue;
  String? trainerIssueContent;
  String? userIssueContent;
  String? sessionMode;
  String? sessionWorkoutType;
  String? sessionWorkoutTypeImagePath;
  int? sessionChargedAmount;
  String? sessionLocationName;
  List? sessionCoordinates;

  SessionModel(
      {this.sessionID,
      this.trainerID,
      this.userID,
      this.userName,
      this.userStripeID,
      this.userPaymentMethodID,
      this.userProfilePicURL,
      this.trainerProfilePicURL,
      this.trainerName,
      this.trainerStripeID,
      this.trainerGenderPref,
      this.sessionCreatedAt,
      this.sessionStartTime,
      this.sessionEndTime,
      this.timeRangeReference,
      this.isAccepted = false,
      this.isFutureSession = false,
      this.futureSessionDate,
      this.futureSessionDay,
      this.futureSessionTime,
      this.sessionDuration,
      this.reportedIssue = false,
      this.trainerIssueContent,
      this.userIssueContent,
      this.sessionMode,
      this.sessionWorkoutType,
      this.sessionWorkoutTypeImagePath,
      this.sessionChargedAmount,
      this.sessionLocationName,
      this.sessionCoordinates});

  factory SessionModel.fromDocumentSnapshot(
      Map<String, dynamic>? document, String id) {
    final doc = document!;
    return SessionModel(
        sessionID: id,
        trainerID: doc['trainerID'],
        userID: doc['userID'],
        userName: doc['userName'],
        userStripeID: doc['userStripeID'],
        userPaymentMethodID: doc['userPaymentMethodID'],
        userProfilePicURL: doc['userProfilePicURL'],
        trainerProfilePicURL: doc['trainerProfilePicURL'],
        trainerName: doc['trainerName'],
        trainerStripeID: doc['trainerStripeID'],
        trainerGenderPref: doc['trainerGenderPref'],
        sessionCreatedAt: doc['sessionCreatedAt'],
        sessionStartTime: doc['sessionStartTime'],
        sessionEndTime: doc['sessionEndTime'],
        timeRangeReference: doc['timeRangeReference'],
        isAccepted: doc['isAccepted'],
        isFutureSession: doc['isFutureSession'],
        futureSessionDate: doc['futureSessionDate'],
        futureSessionDay: doc['futureSessionDay'],
        futureSessionTime: doc['futureSessionTime'],
        sessionDuration: doc['sessionDuration'],
        reportedIssue: doc['reportedIssue']!,
        trainerIssueContent: doc['trainerIssueContent'],
        userIssueContent: doc['userIssueContent'],
        sessionMode: doc['sessionMode'],
        sessionWorkoutType: doc['sessionWorkoutType'],
        sessionWorkoutTypeImagePath: doc['sessionWorkoutTypeImagePath'],
        sessionChargedAmount: doc['sessionChargedAmount'],
        sessionCoordinates: doc['sessionCoordinates'],
        sessionLocationName: doc['sessionLocationName']);
  }

  Map<String, dynamic> toMap(SessionModel session) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionID'] = session.sessionID;
    data['trainerID'] = session.trainerID;
    data['userID'] = session.userID;
    data['userName'] = session.userName;
    data['userStripeID'] = session.userStripeID;
    data['userPaymentMethodID'] = session.userPaymentMethodID;
    data['userProfilePicURL'] = session.userProfilePicURL;
    data['trainerProfilePicURL'] = session.trainerProfilePicURL;
    data['trainerStripeID'] = session.trainerStripeID;
    data['trainerName'] = session.trainerName;
    data['trainerGenderPref'] = session.trainerGenderPref;
    data['sessionCreated'] = session.sessionCreatedAt;
    data['sessionStartTime'] = session.sessionStartTime;
    data['sessionEndTime'] = session.sessionEndTime;
    data['timeRangeReference'] = session.timeRangeReference;
    data['isAccepted'] = session.isAccepted;
    data['isFutureSession'] = session.isFutureSession;
    data['futureSessionDate'] = session.futureSessionDate;
    data['futureSessionDay'] = session.futureSessionDay;
    data['futureSessionTime'] = session.futureSessionTime;
    data['sessionDuration'] = session.sessionDuration;
    data['reportedIssue'] = session.reportedIssue;
    data['userIssueContent'] = session.userIssueContent;
    data['trainerIssueContent'] = session.trainerIssueContent;
    data['sessionMode'] = session.sessionMode;
    data['sessionWorkoutType'] = session.sessionWorkoutType;
    data['sessionWorkoutTypeImagePath'] = session.sessionWorkoutTypeImagePath;
    data['sessionChargedAmount'] = session.sessionChargedAmount;
    data['sessionCoordinates'] = session.sessionCoordinates;
    data['sessionLocationName'] = session.sessionLocationName;

    return data;
  }

  static final dummySessionModel = SessionModel(
      sessionLocationName: 'James J. Braddock North Hudson County Park',
      sessionCoordinates: [40.8037, -74.0014],
      futureSessionTime: '5:30 PM',
      timeRangeReference: 17.3,
      userName: 'Peggy. C',
      futureSessionDay: 'WED',
      futureSessionDate: 'OCT 7TH',
      sessionChargedAmount: 1000,
      sessionDuration: '30MIN',
      sessionWorkoutType: 'Boxing',
      sessionWorkoutTypeImagePath: 'assets/images/workout/boxing.svg');
}
