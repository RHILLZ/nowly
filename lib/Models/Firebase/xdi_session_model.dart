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
  bool isAccepted;
  String? sessionDuration;
  bool? reportedIssue;
  String? trainerIssueContent;
  String? userIssueContent;
  String? sessionMode;
  String? sessionWorkoutType;
  String? sessionWorkoutTypeImagePath;
  int? sessionChargedAmount;
  List? sessionCoordinates;
  String sessionStatus;
  String? eta;
  bool isScanned;

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
      this.isAccepted = false,
      this.sessionDuration,
      this.reportedIssue = false,
      this.trainerIssueContent,
      this.userIssueContent,
      this.sessionMode,
      this.sessionWorkoutType,
      this.sessionWorkoutTypeImagePath,
      this.sessionChargedAmount,
      this.sessionCoordinates,
      this.eta,
      this.isScanned = false,
      this.sessionStatus = 'created'});

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
        isAccepted: doc['isAccepted'],
        sessionDuration: doc['sessionDuration'],
        reportedIssue: doc['reportedIssue']!,
        trainerIssueContent: doc['trainerIssueContent'],
        userIssueContent: doc['userIssueContent'],
        sessionMode: doc['sessionMode'],
        sessionWorkoutType: doc['sessionWorkoutType'],
        sessionWorkoutTypeImagePath: doc['sessionWorkoutTypeImagePath'],
        sessionChargedAmount: doc['sessionChargedAmount'],
        sessionCoordinates: doc['sessionCoordinates'],
        eta: doc['eta'],
        isScanned: doc['isScanned'],
        sessionStatus: doc['sessionStatus']);
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
    data['isAccepted'] = session.isAccepted;
    data['sessionDuration'] = session.sessionDuration;
    data['reportedIssue'] = session.reportedIssue;
    data['userIssueContent'] = session.userIssueContent;
    data['trainerIssueContent'] = session.trainerIssueContent;
    data['sessionMode'] = session.sessionMode;
    data['sessionWorkoutType'] = session.sessionWorkoutType;
    data['sessionWorkoutTypeImagePath'] = session.sessionWorkoutTypeImagePath;
    data['sessionChargedAmount'] = session.sessionChargedAmount;
    data['sessionCoordinates'] = session.sessionCoordinates;
    data['eta'] = session.eta;
    data['isScanned'] = session.isScanned;
    data['sessionStatus'] = session.sessionStatus;

    return data;
  }

  static final dummySessionModel = SessionModel(
      sessionCoordinates: [40.8037, -74.0014],
      userName: 'Natasha Rominoff',
      userID: '5fi0cvSLG4eS0MAk75AJM9dfTKd2',
      userProfilePicURL:
          'https://firebasestorage.googleapis.com/v0/b/nowly-c6733.appspot.com/o/UserProfileImages%2FdTi8OYktXmRpP8qtR2ODbSaEvuv1%2Fimage_picker2711134377801591087.jpg?alt=media&token=5892b8fe-7532-4d24-bcdf-7ba27a1122a0',
      trainerProfilePicURL:
          'https://firebasestorage.googleapis.com/v0/b/nowly-c6733.appspot.com/o/TrainerProfileImages%2FI1gXTNzFktcqcH40YYPC0uhEod42%2Fimage_picker5269482261367775599.jpg?alt=media&token=84bc57e0-29c0-49d7-98aa-f1d281cfe591',
      trainerName: 'Bruce Banner',
      trainerID: 'I1gXTNzFktcqcH40YYPC0uhEod42',
      sessionChargedAmount: 1000,
      sessionDuration: '30MIN',
      sessionMode: 'Virtual',
      sessionWorkoutType: 'Boxing',
      sessionWorkoutTypeImagePath: 'assets/images/workout/boxing.svg');
}
