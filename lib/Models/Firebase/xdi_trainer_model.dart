import 'package:cloud_firestore/cloud_firestore.dart';

class TrainerModel {
  String? id;
  String? firstName;
  String? lastName;
  String? birthYear;
  String? sex;
  String? stripeAccountId;
  String? email;
  List? pScore;
  String? bio;
  String? profilePicURL;
  String? tokenId;
  late bool agreedToTerms;
  late String activeMode;
  late double rating;
  double? ranking;
  int? rankIndex;
  int? prevRankIndex;
  List? skillSet;
  GeoPoint? lastLocation;
  bool showOnMap;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String certificationType;
  late bool validInsurance;
  late int virtualSessionsCompleted;
  late int inPersonSessionsCompleted;
  int? totalSessionsCompleted;
  late int declinedSessions;
  bool inActiveSession;

  TrainerModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.pScore,
      this.bio,
      this.birthYear,
      this.sex,
      this.stripeAccountId,
      this.profilePicURL,
      this.tokenId,
      this.agreedToTerms = false,
      this.activeMode = 'Not Available',
      this.skillSet,
      this.lastLocation,
      this.showOnMap = false,
      this.createdAt,
      this.updatedAt,
      this.certificationType = '',
      this.validInsurance = false,
      this.virtualSessionsCompleted = 0,
      this.inPersonSessionsCompleted = 0,
      this.totalSessionsCompleted = 0,
      this.declinedSessions = 0,
      this.ranking = 0,
      this.rankIndex,
      this.prevRankIndex,
      this.rating = 4.9,
      this.inActiveSession = false});

  factory TrainerModel.fromDocumentSnapshot(
      Map<String, dynamic>? document, String id) {
    final doc = document!;
    return TrainerModel(
        id: id,
        firstName: doc['firstName'],
        lastName: doc['lastName'],
        email: doc['email'],
        pScore: doc['pScore'],
        bio: doc['bio'],
        birthYear: doc['birthYear'],
        sex: doc['sex'],
        profilePicURL: doc['profilePicURL'],
        tokenId: doc['tokenId'],
        stripeAccountId: doc['stripeAccountId'],
        createdAt: doc['createdAt'],
        updatedAt: doc['updatedAt'],
        agreedToTerms: doc['agreedToTerms'],
        activeMode: doc['activeMode'],
        skillSet: doc['skillSet'],
        lastLocation: doc['lastLoction'],
        showOnMap: doc['showOnMap'],
        validInsurance: doc['validInsurance'],
        virtualSessionsCompleted: doc['virtualSessionsCompleted'],
        certificationType: doc['certificationType'],
        inPersonSessionsCompleted: doc['inPersonSessionsCompleted'],
        totalSessionsCompleted: doc['totalSessionsCompleted'],
        declinedSessions: doc['declinedSessions'],
        ranking: doc['ranking'],
        rankIndex: doc['rankIndex'],
        prevRankIndex: doc['prevRankIndex'],
        rating: doc['rating'],
        inActiveSession: doc['inActiveSession']);
  }

  Map<String, dynamic> toMap(TrainerModel trainer) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = trainer.id;
    data['firstName'] = trainer.firstName;
    data['lastName'] = trainer.lastName;
    data['email'] = trainer.email;
    data['pScore'] = trainer.pScore;
    data['bio'] = trainer.bio;
    data['birthYear'] = trainer.birthYear;
    data['sex'] = trainer.sex;
    data['profilePicURL'] = trainer.profilePicURL;
    data['tokenId'] = trainer.tokenId;
    data['stripeAccountId'] = trainer.stripeAccountId;
    data['createdAt'] = trainer.createdAt;
    data['updatedAt'] = trainer.updatedAt;
    data['agreedToTerms'] = trainer.agreedToTerms;
    data['activeMode'] = trainer.activeMode;
    data['skillSet'] = trainer.skillSet;
    data['lastLocation'] = trainer.lastLocation;
    data['showOnMap'] = trainer.showOnMap;
    data['certificationType'] = trainer.certificationType;
    data['validInsurance'] = trainer.validInsurance;
    data['virtualSessionsCompleted'] = trainer.virtualSessionsCompleted;
    data['inPersonSessionsCompleted'] = trainer.inPersonSessionsCompleted;
    data['totalSessionsCompleted'] = trainer.totalSessionsCompleted;
    data['declinedSessions'] = trainer.declinedSessions;
    data['ranking'] = trainer.ranking;
    data['rankIndex'] = trainer.rankIndex;
    data['prevRankIndex'] = trainer.prevRankIndex;
    data['rating'] = trainer.rating;
    data['inActiveSession'] = trainer.inActiveSession;
    return data;
  }
}
