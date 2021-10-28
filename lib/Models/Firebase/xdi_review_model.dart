import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? reviewID;
  String? trainerID;
  String? userID;
  String? trainerName;
  String? userName;
  List? reviewContent;
  double? rating;
  Timestamp? createdAt;

  ReviewModel(
      {this.reviewID,
      this.trainerID,
      this.userID,
      this.trainerName,
      this.userName,
      this.reviewContent,
      this.rating,
      this.createdAt});

  factory ReviewModel.fromDocumentSnapshot(
      Map<String, dynamic>? document, String id) {
    final doc = document!;
    return ReviewModel(
      reviewID: id,
      trainerID: doc['trainerID'],
      userID: doc['userID'],
      trainerName: doc['trainerName'],
      userName: doc['userName'],
      reviewContent: doc['reviewContent'],
      rating: doc['rating'],
      createdAt: doc['createdAt'],
    );
  }

  Map<String, dynamic> toMap(ReviewModel review) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewID'] = review.reviewID;
    data['userID'] = review.userID;
    data['trainerName'] = review.trainerName;
    data['userName'] = review.userName;
    data['reviewContent'] = review.reviewContent;
    data['rating'] = review.rating;
    data['createdAt'] = review.createdAt;
    return data;
  }
}
