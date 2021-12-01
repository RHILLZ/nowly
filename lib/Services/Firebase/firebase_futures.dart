// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nowly/Configs/Constants/constants.dart';
import 'package:nowly/Models/models_exporter.dart';

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

  Future<bool> setUserOneSignalId(String uid, String oneSignalId) async {
    bool _isSuccessful = false;
    try {
      await _firestore
          .collection(USERSCOLLECTION)
          .doc(uid)
          .update({'oneSignalId': oneSignalId});
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

//TRAINER CRUD METHODS
//CREATE
//READ
//UPDATE
//DELETE
  // Future<bool> createTrainerInFirestore(TrainerModel trainer) async {
  //   bool isSuccessful = false;
  //   try {
  //     var data = TrainerModel().toMap(trainer);
  //     await _firestore.collection(TRAINERSCOLLECTION).doc(trainer.id).set(data);
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  // // UPDATE TRAINER LAST LOCATION COORDINATES
  // Future<bool> updateTrainerLastLocation(String uid, GeoPoint location) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(uid)
  //         .update({'lastLocation': location});
  //     _isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return _isSuccessful;
  // }

  // Future<bool> updateTrainerAvailability(
  //     TrainerModel trainer, List slots, context) async {
  //   bool _isSuccessful = false;
  //   try {
  //     var data = slots
  //         .map((e) => {
  //               e.day: {
  //                 'timeRange': e.availability,
  //                 'formatted': e.formattedAvailability
  //               },
  //             })
  //         .toList();

  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(trainer.id)
  //         .update({'availability': data});
  //     // }
  //     _isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return _isSuccessful;
  // }

  // //UPDATE TRAINERS SKILLSET
  // Future<bool> updateTrainerSkillSet(String uid, List skills) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(uid)
  //         .update({'skillSet': skills});
  //     _isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return _isSuccessful;
  // }

  // // ACCEPT SCHEDULED SESSION
  // // CREATE SESSION
  // Future<bool> acceptFutureSession(SessionModel session) async {
  //   bool _isSuccessful = false;

  //   final sessionData = SessionModel().toMap(session);
  //   try {
  //     //UPDATE SESSION TO ACCEPTED
  //     print('SESSION ID ${session.sessionID}');
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(session.userID)
  //         .collection(FUTURESESSIONCOLLECTION)
  //         .doc(session.sessionID)
  //         .update(sessionData);
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(session.trainerID)
  //         .collection(FUTURESESSIONCOLLECTION)
  //         .doc(session.sessionID)
  //         .set(sessionData);
  //     //CREATE SESSION IN USER SCHEDULE
  //     //CREATE SESSION IN TRAINER SCHEDULE
  //     _isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return _isSuccessful;
  // }

  // Future<TrainerModel> getTrainerInFirestore(String uid) async =>
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(uid)
  //         .get()
  //         .then((doc) => TrainerModel.fromDocumentSnapshot(doc.data(), doc.id));

  // Future<bool> setTrainerOneSignalId(String uid, String oneSignalId) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(uid)
  //         .update({'oneSignalId': oneSignalId});
  //     _isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return _isSuccessful;
  // }

  // Future<bool> updateTrainerInFirestore(TrainerModel trainer) async {
  //   bool isSuccessful = false;
  //   try {
  //     var data = TrainerModel().toMap(trainer);
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(trainer.id)
  //         .update(data);
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  // Future<bool> updateTrainerStripeAccountId(
  //     String uid, String stripeAccountId) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(uid)
  //         .update({'stripeAccountId': stripeAccountId});
  //     _isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return _isSuccessful;
  // }

  // Future<bool> deleteTrainerInFirestore(String uid) async {
  //   bool isSuccessful = false;
  //   try {
  //     await _firestore.collection(TRAINERSCOLLECTION).doc(uid).delete();
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  //SESSION CRUD METHODS
  //CREATE
  //READ
  //UPDATE
  //DELETE
  Future<bool> createNewSession(SessionModel session) async {
    bool isSuccessful = false;
    try {
      var data = SessionModel().toMap(session);
      await _firestore.collection(SESSIONCOLLECTION).doc().set(data);

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

  //USER REVIEW CUD METHODS
  //CREATE
  //UPDATE
  //DELETE
  // Future<bool> createUserReview(ReviewModel review) async {
  //   bool isSuccessful = false;
  //   try {
  //     var data = ReviewModel().toMap(review);
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(review.userID)
  //         .collection(REVIEWS)
  //         .doc(review.reviewID)
  //         .set(data);
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  // Future<bool> updateUserReview(ReviewModel review) async {
  //   bool isSuccessful = false;
  //   try {
  //     var data = ReviewModel().toMap(review);
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(review.userID)
  //         .collection(REVIEWS)
  //         .doc(review.reviewID)
  //         .update(data);
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  // Future<bool> deleteUserReview(ReviewModel review) async {
  //   bool isSuccessful = false;
  //   try {
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(review.userID)
  //         .collection(REVIEWS)
  //         .doc(review.reviewID)
  //         .delete();
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

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

  // Future<bool> updateTrainerReview(ReviewModel review) async {
  //   bool isSuccessful = false;
  //   try {
  //     var data = ReviewModel().toMap(review);
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(review.trainerID)
  //         .collection(REVIEWS)
  //         .doc(review.reviewID)
  //         .update(data);
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  // Future<bool> deleteTrainerReview(ReviewModel review) async {
  //   bool isSuccessful = false;
  //   try {
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(review.trainerID)
  //         .collection(REVIEWS)
  //         .doc(review.reviewID)
  //         .delete();
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

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

  // Future<bool> createTrainerSessionReceipt(SessionReceiptModel receipt) async {
  //   bool isSuccessful = false;
  //   try {
  //     var data = SessionReceiptModel().toMap(receipt);
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(receipt.trainerID)
  //         .collection(SESSIONRECEIPTS)
  //         .doc(receipt.sessionID)
  //         .set(data);
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

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
          .get()
          .then((query) => query.docs
              .map((doc) =>
                  SessionReceiptModel.fromDocumentSnapshot(doc.data(), doc.id))
              .toList());

  // Future<SessionReceiptModel> getTrainerSessionReceipt(
  //         String sessionId, String trainerId) async =>
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(trainerId)
  //         .collection(SESSIONRECEIPTS)
  //         .doc(sessionId)
  //         .get()
  //         .then((doc) =>
  //             SessionReceiptModel.fromDocumentSnapshot(doc.data(), doc.id));

  // Future<List<SessionReceiptModel>> getTrainerSessionReceipts(
  //         String trainerId) async =>
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(trainerId)
  //         .collection(SESSIONRECEIPTS)
  //         .get()
  //         .then((query) => query.docs
  //             .map((doc) =>
  //                 SessionReceiptModel.fromDocumentSnapshot(doc.data(), doc.id))
  //             .toList());

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

//APPOINTMENT CRUD METHODS
//CREATE
//RETRIEVE SINGLE APPOINTMENT
//RETRIEVE ALL APPOINTMENTS
//UPDATE
//DELETE
  // Future<bool> createNewAppointment(AppointmentModel appointment) async {
  //   bool isSuccessful = false;
  //   try {
  //     var data = AppointmentModel().toMap(appointment);
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(appointment.userID)
  //         .collection(APPOINTMENTS)
  //         .doc(appointment.appointmentID)
  //         .set(data);
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(appointment.trainerID)
  //         .collection(APPOINTMENTS)
  //         .doc(appointment.appointmentID)
  //         .set(data);
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  // Future<AppointmentModel> getUserAppointment(
  //         String appontmentId, String userId) async =>
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(userId)
  //         .collection(APPOINTMENTS)
  //         .doc(appontmentId)
  //         .get()
  //         .then((doc) =>
  //             AppointmentModel.fromDocumentSnapshot(doc.data(), doc.id));

  // Future<List<AppointmentModel>> getUserAppoinments(String userId) async =>
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(userId)
  //         .collection(APPOINTMENTS)
  //         .get()
  //         .then((query) => query.docs
  //             .map((doc) =>
  //                 AppointmentModel.fromDocumentSnapshot(doc.data(), doc.id))
  //             .toList());

  // Future<AppointmentModel> getTrainerAppointment(
  //         String appontmentId, String trainerId) async =>
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(trainerId)
  //         .collection(APPOINTMENTS)
  //         .doc(appontmentId)
  //         .get()
  //         .then((doc) =>
  //             AppointmentModel.fromDocumentSnapshot(doc.data(), doc.id));

  // Future<List<AppointmentModel>> getTrainerAppoinments(
  //         String trainerId) async =>
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(trainerId)
  //         .collection(APPOINTMENTS)
  //         .get()
  //         .then((query) => query.docs
  //             .map((doc) =>
  //                 AppointmentModel.fromDocumentSnapshot(doc.data(), doc.id))
  //             .toList());

  // Future<bool> updateAppointment(AppointmentModel appointment) async {
  //   bool isSuccessful = false;
  //   try {
  //     var data = AppointmentModel().toMap(appointment);
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(appointment.userID)
  //         .collection(APPOINTMENTS)
  //         .doc(appointment.appointmentID)
  //         .update(data);
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(appointment.trainerID)
  //         .collection(APPOINTMENTS)
  //         .doc(appointment.appointmentID)
  //         .update(data);
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  // Future<bool> deleteAppointment(AppointmentModel appointment) async {
  //   bool isSuccessful = false;
  //   try {
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(appointment.userID)
  //         .collection(APPOINTMENTS)
  //         .doc(appointment.appointmentID)
  //         .delete();
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(appointment.trainerID)
  //         .collection(APPOINTMENTS)
  //         .doc(appointment.appointmentID)
  //         .delete();
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  // Future<bool> updateUserRating(String userId, double rating) async {
  //   bool isSuccessful = false;
  //   try {
  //     List<int> stars = [];
  //     double totalStars = stars.fold(
  //         rating, (previousValue, element) => previousValue + element);
  //     int numOfratings = await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(userId)
  //         .collection(REVIEWS)
  //         .get()
  //         .then((value) => value.docs.length);
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(userId)
  //         .collection(REVIEWS)
  //         .get()
  //         .then((QuerySnapshot query) => query.docs
  //             .map((DocumentSnapshot doc) => stars.add(doc['rating'])));

  //     var score = ((20 * totalStars) / numOfratings) / 20;
  //     await _firestore
  //         .collection(USERSCOLLECTION)
  //         .doc(userId)
  //         .update({'rating': score});
  //     isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return isSuccessful;
  // }

  Future<bool> updateTrainerRating(String trainerId, double rating) async {
    bool isSuccessful = false;
    try {
      List<int> stars = [];
      double totalStars = stars.fold(
          rating, (previousValue, element) => previousValue + element);
      int numOfratings = await _firestore
          .collection(TRAINERSCOLLECTION)
          .doc(trainerId)
          .collection(REVIEWS)
          .get()
          .then((value) => value.docs.length);
      await _firestore
          .collection(TRAINERSCOLLECTION)
          .doc(trainerId)
          .collection(REVIEWS)
          .get()
          .then((QuerySnapshot query) => query.docs
              .map((DocumentSnapshot doc) => stars.add(doc['rating'])));

      var score = ((20 * totalStars) / numOfratings) / 20;
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

  // Future<bool> updateTrainerActiveMode(String uid, String mode) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await _firestore
  //         .collection(TRAINERSCOLLECTION)
  //         .doc(uid)
  //         .update({'activeMode': mode});

  //     _isSuccessful = true;
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  //   return _isSuccessful;
  // }

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

  // //INCREMENT SESSION COUNT ON SESSION COMPLETETION
  // void incrementTrainerSessionCount(String uid, String sessionMode) async {
  //   bool _isSuccessful = false;
  //   DocumentReference docRef =
  //       _firestore.collection(TRAINERSCOLLECTION).doc(uid);
  //   _firestore
  //       .runTransaction((transaction) async {
  //         DocumentSnapshot snapshot = await transaction.get(docRef);
  //         if (!snapshot.exists) {
  //           throw Exception('User does not exist!');
  //         }
  //         final mode = {
  //           'VIRTUAL': 'virtualSessionsCompleted',
  //           'IN PERSON': 'inPersonSessionsCompleted'
  //         };

  //         int newSessionModeCount = snapshot.get(mode[sessionMode]!) + 1;
  //         int newSessionCount = snapshot.get('totalSessionsCompleted') + 1;

  //         transaction.update(docRef, {
  //           'totalSessionsCompleted': newSessionCount,
  //           mode[sessionMode]!: newSessionModeCount
  //         });
  //         _isSuccessful = true;
  //         return _isSuccessful;
  //       })
  //       .then((value) => print(value))
  //       .catchError((e) => Get.snackbar('Error', '${e.message}',
  //           backgroundColor: Colors.red, colorText: Colors.white));
  // }

  // void incrementTrainerCancellations(String uid) async {
  //   bool _isSuccessful = false;
  //   DocumentReference docRef =
  //       _firestore.collection(TRAINERSCOLLECTION).doc(uid);
  //   _firestore
  //       .runTransaction((transaction) async {
  //         DocumentSnapshot snapshot = await transaction.get(docRef);
  //         if (!snapshot.exists) {
  //           throw Exception('User does not exist!');
  //         }
  //         int newCancellationCount = snapshot.get('declinedSessions') + 1;
  //         transaction
  //             .update(docRef, {'declinedSessions': newCancellationCount});
  //         _isSuccessful = true;
  //         return _isSuccessful;
  //       })
  //       .then((value) => print(value))
  //       .catchError((e) => Get.snackbar('Error', '${e.message}',
  //           backgroundColor: Colors.red, colorText: Colors.white));
  // }

  // // UPDATE TRAINER RANKING
  // void updateTrainerRank(String uid, int currentIndex) async {
  //   DocumentReference trainerDocRef =
  //       _firestore.collection(TRAINERSCOLLECTION).doc(uid);
  //   final numOfTrainers = await _firestore.collection(TRAINERSCOLLECTION).get();
  //   _firestore
  //       .runTransaction((transaction) async {
  //         DocumentSnapshot trainerSnapshot =
  //             await transaction.get(trainerDocRef);
  //         int trainers = numOfTrainers.docs.length;
  //         int newRanking =
  //             trainerSnapshot.get('totalSessionsCompleted') / trainers;
  //         transaction.update(trainerDocRef, {'ranking': newRanking});
  //         return newRanking;
  //       })
  //       .then((value) => null)
  //       .catchError((e) => null);
  // }
}
