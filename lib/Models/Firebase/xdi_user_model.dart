import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? height;
  String? weight;
  String? birthYear;
  String? sex;
  String? email;
  List? pScore;
  String? profilePicURL;
  late bool isReady;
  late double rating;
  String? oneSignalId;
  String? stripeCustomerId;
  String? activePaymentMethodId;
  List? stripePaymentMethodIds;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  late bool agreedToTerms;
  List? goals;
  String? goalTimeFrame;
  String? primaryGoal;
  String? fitnessLevel;
  String? activeDaysWeekly;
  late bool hadPastTrainer;
  String? experienceWithPastTrainer;
  late bool hasInjury;
  String? injuryDetails;
  late bool hasMedicalHistory;
  List? yesToMedHistoryQuestions;
  String? medicalHistoryDetails;
  List? favoriteWorkouts;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.height,
      this.weight,
      this.birthYear,
      this.sex,
      this.email,
      this.pScore,
      this.profilePicURL,
      this.isReady = false,
      this.oneSignalId,
      this.stripeCustomerId,
      this.activePaymentMethodId,
      this.stripePaymentMethodIds,
      this.createdAt,
      this.updatedAt,
      this.agreedToTerms = false,
      this.goals,
      this.goalTimeFrame,
      this.primaryGoal,
      this.fitnessLevel,
      this.activeDaysWeekly,
      this.hadPastTrainer = false,
      this.experienceWithPastTrainer,
      this.hasInjury = false,
      this.injuryDetails,
      this.hasMedicalHistory = false,
      this.yesToMedHistoryQuestions,
      this.medicalHistoryDetails,
      this.favoriteWorkouts,
      this.rating = 4.9});

  factory UserModel.fromDocumentSnapshot(
      Map<String, dynamic>? document, String id) {
    final doc = document!;
    return UserModel(
      id: id,
      firstName: doc['firstName'],
      lastName: doc['lastName'],
      height: doc['height'],
      weight: doc['weight'],
      birthYear: doc['birthYear'],
      sex: doc['sex'],
      email: doc['email'],
      pScore: doc['pScore'],
      profilePicURL: doc['profilePicURL'],
      isReady: doc['isReady']!,
      oneSignalId: doc['oneSignalId'],
      stripeCustomerId: doc['stripeCustomerId'],
      activePaymentMethodId: doc['activePaymentMethodId'],
      stripePaymentMethodIds: doc['stripePaymentMethodIds'],
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
      agreedToTerms: doc['agreedToTerms']!,
      goals: doc['goals'],
      goalTimeFrame: doc['goalTimeFrame'],
      primaryGoal: doc['primaryGoal'],
      fitnessLevel: doc['fitnessLevel'],
      activeDaysWeekly: doc['activeDaysWeekly'],
      hadPastTrainer: doc['hadPastTrainer'],
      experienceWithPastTrainer: doc['experienceWithPastTrainer'],
      hasInjury: doc['hasInjury']!,
      injuryDetails: doc['injuryDetails'],
      hasMedicalHistory: doc['hasMedicalHistory']!,
      yesToMedHistoryQuestions: doc['yesToMedHistoryQuestions'],
      medicalHistoryDetails: doc['medicalHistoryDetails'],
      favoriteWorkouts: doc['favoriteWorkouts'],
      rating: doc['rating']!,
    );
  }

  Map<String, dynamic> toMap(UserModel user) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = user.id;
    data['firstName'] = user.firstName;
    data['lastName'] = user.lastName;
    data['email'] = user.email;
    data['pScore'] = user.pScore;
    data['height'] = user.height;
    data['weight'] = user.weight;
    data['birthYear'] = user.birthYear;
    data['sex'] = user.sex;
    data['profilePicURL'] = user.profilePicURL;
    data['isReady'] = user.isReady;
    data['oneSignalId'] = user.oneSignalId;
    data['stripeCustomerId'] = user.stripeCustomerId;
    data['activePaymentMethodId'] = user.activePaymentMethodId;
    data['stripePaymentMethodIds'] = user.stripePaymentMethodIds;
    data['createdAt'] = user.createdAt;
    data['updatedAt'] = user.updatedAt;
    data['agreedToTerms'] = user.agreedToTerms;
    data['goals'] = user.goals;
    data['goalTimeFrame'] = user.goalTimeFrame;
    data['primaryGoal'] = user.primaryGoal;
    data['fitnessLevel'] = user.fitnessLevel;
    data['activeDaysWeekly'] = user.activeDaysWeekly;
    data['hadPastTrainer'] = user.hadPastTrainer;
    data['experienceWithPastTrainer'] = user.experienceWithPastTrainer;
    data['hasInjury'] = user.hasInjury;
    data['injuryDetails'] = user.injuryDetails;
    data['hasMedicalHistory'] = user.hasMedicalHistory;
    data['yesToMedHistoryQuestions'] = user.yesToMedHistoryQuestions;
    data['medicalHistoryDetails'] = user.medicalHistoryDetails;
    data['favoriteWorkouts'] = user.favoriteWorkouts;
    data['rating'] = user.rating;
    return data;
  }
}
