import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nowly/Configs/Constants/constants.dart';
import 'package:nowly/Models/models_exporter.dart';

class FirebaseStreams {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //USER STREAMS
  Stream<UserModel> streamUser(String uid) => _firestore
      .collection(USERSCOLLECTION)
      .doc(uid)
      .snapshots()
      .map((doc) => UserModel.fromDocumentSnapshot(doc.data(), doc.id));

  Stream<List<ReviewModel>> streamUserReviews(String uid) => _firestore
      .collection(USERSCOLLECTION)
      .doc(uid)
      .collection(REVIEWS)
      .snapshots()
      .map((query) => query.docs
          .map((doc) => ReviewModel.fromDocumentSnapshot(doc.data(), doc.id))
          .toList());
  Stream<SessionModel> streamSession(String sessionId) => _firestore
      .collection(SESSIONCOLLECTION)
      .doc(sessionId)
      .snapshots()
      .map((doc) => SessionModel.fromDocumentSnapshot(doc.data(), doc.id));

  Stream<List<SessionReceiptModel>> streamUserReceipts(String uid) => _firestore
      .collection(USERSCOLLECTION)
      .doc(uid)
      .collection(SESSIONRECEIPTS)
      .orderBy('sessionTimestamp', descending: true)
      .snapshots()
      .map((query) => query.docs
          .map((doc) =>
              SessionReceiptModel.fromDocumentSnapshot(doc.data(), doc.id))
          .toList());

  Stream<List> streamChat(String sessionId) => _firestore
      .collection(SESSIONCOLLECTION)
      .doc(sessionId)
      .collection(SESSIONCHAT)
      .doc(sessionId)
      .snapshots()
      .map((doc) => doc
          .data()!['chat']
          .map((doc) => MessageModel.fromDocumentSnapshot(doc))
          .toList());

  Stream<List<TrainerInPersonSessionModel>> streamOnlineTrainers(
          sessionOptions) =>
      _firestore
          .collection(TRAINERSCOLLECTION)
          .where('showOnMap', isEqualTo: true)
          .snapshots()
          .map((query) => query.docs
              .map((doc) => TrainerInPersonSessionModel(
                  trainer:
                      TrainerModel.fromDocumentSnapshot(doc.data(), doc.id),
                  sessionLengths: sessionOptions,
                  locationDetailsModel: LocationDetailsModel(
                      id: doc.id,
                      longitude: doc.data()['lastLocation'].longitude,
                      latitude: doc.data()['lastLocation'].latitude)))
              .toList());

// TRAINER STREAMS
  // Stream streamAvailability(String uid) => _firestore
  //     .collection(TRAINERSCOLLECTION)
  //     .doc(uid)
  //     .snapshots()
  //     .map((doc) => doc
  //         .data()!['availability']
  //         .map((slot) => AvailableTimeModel.fromDocumentSnapshot(slot)))
  //     .map((event) => event.map((m) => m).toList());

  // Stream<TrainerModel> streamTrainer(String uid) => _firestore
  //     .collection(TRAINERSCOLLECTION)
  //     .doc(uid)
  //     .snapshots()
  //     .map((doc) => TrainerModel.fromDocumentSnapshot(doc.data(), doc.id));

  // Stream<List<TrainerModel>> streamOnlineTrainers() => _firestore
  //     .collection(TRAINERSCOLLECTION)
  //     .where('activeMode', isEqualTo: 'IN PERSON')
  //     .snapshots()
  //     .map((query) => query.docs
  //         .map((doc) => TrainerModel.fromDocumentSnapshot(doc.data(), doc.id))
  //         .toList());

  // Stream<List<ReviewModel>> streamTrainerReviews(String uid) => _firestore
  //     .collection(TRAINERSCOLLECTION)
  //     .doc(uid)
  //     .collection(REVIEWS)
  //     .snapshots()
  //     .map((query) => query.docs
  //         .map((doc) => ReviewModel.fromDocumentSnapshot(doc.data(), doc.id))
  //         .toList());

  // Stream<List<SessionModel>> streamTrainerAppointments(String uid) => _firestore
  //     .collection(TRAINERSCOLLECTION)
  //     .doc(uid)
  //     .collection(FUTURESESSIONCOLLECTION)
  //     .snapshots()
  //     .map((query) => query.docs
  //         .map((doc) => SessionModel.fromDocumentSnapshot(doc.data(), doc.id))
  //         .toList());

  // Stream<List<TrainerModel>> streamTrainersByRank() => _firestore
  //     .collection(TRAINERSCOLLECTION)
  //     .orderBy('ranking', descending: true)
  //     .snapshots()
  //     .map((query) => query.docs
  //         .map((doc) => TrainerModel.fromDocumentSnapshot(doc.data(), doc.id))
  //         .toList());
}
