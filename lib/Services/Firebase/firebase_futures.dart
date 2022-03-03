// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nowly/Configs/Constants/constants.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Utils/methods.dart';

class FirebaseFutures {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//USER CRUD METHODS
//CREATE
//READ
//UPDATE
//DELETE
  Future<bool> createUserInFirestore(UserModel user) async {
    bool isSuccessful = false;
    try {
      var data = UserModel().toMap(user);
      await _firestore.collection(USERSCOLLECTION).doc(user.id).set(data);
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> incrementSessionCount(String userID) async {
    bool _isSuccessful = false;
    try {
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(userID)
          .update({'sessionsCompleted': FieldValue.increment(1)});
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }

  // SET USER STRIPE CUSTOMER ID
  Future<bool> setUserStripeCustomerId(
      String uid, String stripeCustomerId) async {
    bool _isSuccessful = false;
    try {
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(uid)
          .update({'stripeCustomerId': stripeCustomerId});
      _isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }

  // SET USER STRIPE CUSTOMER ID
  Future<bool> setUserStripePaymentMethodId(
      String uid, String stripePaymentMethodId) async {
    bool _isSuccessful = false;
    try {
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(uid)
          .update({'stripePaymentMethodId': stripePaymentMethodId});
      _isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }
  //UPDATE USER ACTIVE PAYMENT METHOD

  Future<bool> setUserActiveStripePaymentMethodId(
      String uid, String stripePaymentMethodId) async {
    bool _isSuccessful = false;
    try {
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(uid)
          .update({'activePaymentMethodId': stripePaymentMethodId});
      _isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }

  Future<UserModel> getUserInFirestore(String uid) async => await _firestore
      .collection(USERSCOLLECTION)
      .doc(uid)
      .get()
      .then((doc) => UserModel.fromDocumentSnapshot(doc.data(), doc.id));

  Future<DocumentSnapshot> getUserInFirestoreInstance(String uid) async => await _firestore
      .collection(USERSCOLLECTION)
      .doc(uid)
      .get();

  Future<bool> setUserTokenId(String uid, String tokenId) async {
    bool _isSuccessful = false;
    try {
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(uid)
          .update({'tokenId': tokenId});
      _isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }

  Future<bool> updateUserInFirestore(UserModel user) async {
    bool isSuccessful = false;
    try {
      var data = UserModel().toMap(user);
      await _firestore.collection(USERSCOLLECTION).doc(user.id).update(data);
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> deleteUserInFirestore(String uid) async {
    bool isSuccessful = false;
    try {
      await _firestore.collection(USERSCOLLECTION).doc(uid).delete();
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> sendMessage(String sessionId, MessageModel message) async {
    bool _isSuccessful = false;
    try {
      final data = MessageModel().toMap(message);
      await _firestore
          .collection(SESSIONCOLLECTION)
          .doc(sessionId)
          .collection(SESSIONCHAT)
          .doc(sessionId)
          .set({
        'chat': FieldValue.arrayUnion([data])
      }, SetOptions(merge: true));
      _isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }

  Future<bool> submitSuggestion(FeedbackModel feedback) async {
    bool _isSuccessful = false;
    try {
      var data = FeedbackModel().toMap(feedback);
      await _firestore.collection(FEEDBACK).add(data);
      _isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }

  //SESSION CRUD METHODS
  //CREATE
  //READ
  //UPDATE
  //DELETE
  Future<bool> createNewSession(SessionModel session) async {
    bool isSuccessful = false;
    try {
      var data = SessionModel().toMap(session);
      await _firestore
          .collection(SESSIONCOLLECTION)
          .doc(session.sessionID)
          .set(data);

      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<SessionModel> getSession(String sessionId) async => await _firestore
      .collection(SESSIONCOLLECTION)
      .doc(sessionId)
      .get()
      .then((doc) => SessionModel.fromDocumentSnapshot(doc.data(), doc.id));

  Future<bool> acceptSession(SessionModel session) async {
    bool _isSuccessful = false;
    final data = SessionModel().toMap(session);
    try {
      await _firestore
          .collection(SESSIONCOLLECTION)
          .doc(session.sessionID)
          .update(data);
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(session.userID)
          .collection(USERSESSIONCOLLECTION)
          .doc(session.sessionID)
          .set(data);
      // await _firestore
      //     .collection(TRAINERSCOLLECTION)
      //     .doc(session.trainerID)
      //     .collection(TRAINERSESSIONCOLLECTION)
      //     .doc(session.sessionID)
      //     .set(data);
      _isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }

  Future<bool> updateSession(SessionModel session) async {
    bool isSuccessful = false;
    try {
      var data = SessionModel().toMap(session);
      await _firestore
          .collection(SESSIONCOLLECTION)
          .doc(session.sessionID)
          .update(data);
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> cancelSession(SessionModel session) async {
    bool isSuccessful = false;
    try {
      await _firestore
          .collection(SESSIONCOLLECTION)
          .doc(session.sessionID)
          .update({'sessionStatus': 'cancelled'});
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> deleteSession(SessionModel session) async {
    bool isSuccessful = false;
    try {
      await _firestore
          .collection(SESSIONCOLLECTION)
          .doc(session.sessionID)
          .delete();
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> updateETA(SessionModel session, String eta) async {
    bool isSuccessful = false;
    try {
      await _firestore
          .collection(SESSIONCOLLECTION)
          .doc(session.sessionID)
          .update({'eta': eta});
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> updateGoals(String userId, List goals) async {
    bool isSuccessful = false;
    List _goals = [];
    try {
      for (var element in goals) {
        _goals.add(element);
      }
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(userId)
          .update({'goals': goals});
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  //TRAINER CUD METHODS
  //CREATE
  //UPDATE
  //DELETE
  Future<bool> createTrainerReview(ReviewModel review) async {
    bool isSuccessful = false;
    try {
      var data = ReviewModel().toMap(review);
      await _firestore
          .collection(TRAINERSCOLLECTION)
          .doc(review.trainerID)
          .collection(REVIEWS)
          .doc(review.reviewID)
          .set(data);
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  //SESSION RECEIPT CRUD METHODS
  //CREATE
  //RETRIEVE SINGLE RECIEPT
  //RETRIEVE ALL RECIEPTS
  //UPDATE
  //DELETE
  Future<bool> createSessionReceipt(SessionReceiptModel receipt) async {
    bool isSuccessful = false;
    try {
      var data = SessionReceiptModel().toMap(receipt);
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(receipt.userID)
          .collection(SESSIONRECEIPTS)
          .doc(receipt.sessionID)
          .set(data);
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<SessionReceiptModel> getSessionReceipt(
          String sessionId, String userId) async =>
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(userId)
          .collection(SESSIONRECEIPTS)
          .doc(sessionId)
          .get()
          .then((doc) =>
              SessionReceiptModel.fromDocumentSnapshot(doc.data(), doc.id));

  Future<List<SessionReceiptModel>> getSessionReceipts(String userId) async =>
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(userId)
          .collection(SESSIONRECEIPTS)
          .orderBy('sessionTimestamp', descending: true)
          .get()
          .then((query) => query.docs
              .map((doc) =>
                  SessionReceiptModel.fromDocumentSnapshot(doc.data(), doc.id))
              .toList());

  Future<bool> updateSessionReceipt(SessionReceiptModel receipt) async {
    bool isSuccessful = false;
    try {
      var data = SessionReceiptModel().toMap(receipt);
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(receipt.userID)
          .collection(SESSIONRECEIPTS)
          .doc(receipt.sessionID)
          .update(data);
      // await _firestore
      //     .collection(TRAINERSCOLLECTION)
      //     .doc(receipt.trainerID)
      //     .collection(SESSIONRECEIPTS)
      //     .doc(receipt.sessionID)
      //     .update(data);
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> deleteSessionReceipt(SessionReceiptModel receipt) async {
    bool isSuccessful = false;
    try {
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(receipt.userID)
          .collection(SESSIONRECEIPTS)
          .doc(receipt.sessionID)
          .delete();
      // await _firestore
      //     .collection(TRAINERSCOLLECTION)
      //     .doc(receipt.trainerID)
      //     .collection(SESSIONRECEIPTS)
      //     .doc(receipt.sessionID)
      //     .delete();
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> updateTrainerRating(String trainerId, double rating) async {
    bool isSuccessful = false;
    try {
      double stars = rating;
      int totalReviews = await _firestore
              .collection(TRAINERSCOLLECTION)
              .doc(trainerId)
              .collection(REVIEWS)
              .get()
              .then((value) => value.docs.length + 1) ??
          2;

      await _firestore
          .collection(TRAINERSCOLLECTION)
          .doc(trainerId)
          .collection(REVIEWS)
          .get()
          // ignore: avoid_function_literals_in_foreach_calls
          .then((QuerySnapshot query) => query.docs.forEach((doc) {
                stars += doc['rating'];
              }));
      // .map((DocumentSnapshot doc) => stars + doc.get('rating')));
      AppLogger.i('TOTAL STARS $stars');
      AppLogger.i('TOTAL REVIEWS $totalReviews');

      var score = Methods.calculateRating(stars, totalReviews);
      AppLogger.i(score);
      await _firestore
          .collection(TRAINERSCOLLECTION)
          .doc(trainerId)
          .update({'rating': score});
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return isSuccessful;
  }

  Future<bool> reportIssueWithSession(SessionModel session, bool isUser) async {
    bool _isSuccessful = false;
    final collectionType =
        isUser ? TRAINERREPORTEDESSIONCOLLECTION : USERREPORTEDESSIONCOLLECTION;
    try {
      final _session = await getSession(session.sessionID!);
      final data = SessionModel().toMap(_session);
      data['reportedIssue'] = true;
      isUser
          ? data['trainerIssueContent'] = session.trainerIssueContent
          : data['userIssueContent'] = session.userIssueContent;
      await _firestore
          .collection(SESSIONCOLLECTION)
          .doc(session.sessionID)
          .update(data);
      await _firestore
          .collection(collectionType)
          .doc(session.sessionID)
          .set(data);
      _isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
    }
    return _isSuccessful;
  }

  Future getOnlineTrainers(sessionLengths) async {
    List<TrainerInPersonSessionModel> trainers = await _firestore
        .collection(TRAINERSCOLLECTION)
        .where('activeMode', isEqualTo: 'Physical')
        .get()
        .then((query) => query.docs
            .map((doc) => TrainerInPersonSessionModel(
                trainer: TrainerModel.fromDocumentSnapshot(
                  doc.data(),
                  doc.id,
                ),
                sessionLengths: sessionLengths,
                locationDetailsModel: LocationDetailsModel(
                    id: doc.id,
                    longitude: doc.data()['lastLocation'].longitude,
                    latitude: doc.data()['lastLocation'].latitude)))
            .toList());

    return trainers;
  }
}
