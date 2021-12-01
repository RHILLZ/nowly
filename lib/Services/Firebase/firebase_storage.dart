import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseStorage {
  final fs.FirebaseStorage _firebaseStorage = fs.FirebaseStorage.instance;

//TRAINER PROFILE IMAGE HANDLER
//UPLOAD A IMAGE
//CHANGE AN IMAGE
  // Future<bool> uploadTrainerProfileImage(File image, String trainerID) async {
  //   bool _isSuccessful = false;
  //   try {
  //     var imageName = image.path.split('/').last;
  //     await _firebaseStorage
  //         .ref('TrainerProfileImages/$trainerID/$imageName')
  //         .putFile(image);

  //     _isSuccessful = true;
  //   } on fs.FirebaseException catch (e) {
  //     Get.snackbar('Error uploading image', e.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }

  //   return _isSuccessful;
  // }

  // Future _loadTrainerProfileImage(String imageName, String trainerID) async {
  //   return await _firebaseStorage
  //       .ref('TrainerProfileImages/$trainerID/$imageName')
  //       .getDownloadURL();
  // }

  // Future<String> getTrainerProfileImageURL(
  //         String imageName, String trainerID) async =>
  //     await _loadTrainerProfileImage(imageName, trainerID)
  //         .then((url) => url.toString());

  // Future<bool> deleteTrainerProfileImage(String trainerID) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await _firebaseStorage.ref('TrainerProfileImages/$trainerID').delete();
  //     _isSuccessful = true;
  //   } on fs.FirebaseException catch (e) {
  //     Get.snackbar('Error deleting image', e.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  //   return _isSuccessful;
  // }

  // Future<bool> changeTrainerProfileImage(File image, String trainerID) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await deleteTrainerProfileImage(trainerID);
  //     await uploadTrainerProfileImage(image, trainerID);
  //     _isSuccessful = true;
  //   } on fs.FirebaseException catch (e) {
  //     Get.snackbar('Error uploading new profile image', e.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  //   return _isSuccessful;
  // }

  //USER PROFILE IMAGE HANDLER
  //UPLOAD A IMAGE
  //GET DL URL
  //REPLACE IMAGE
  Future<bool> uploadUserProfileImage(File image, String userID) async {
    bool _isSuccessful = false;
    try {
      var imageName = image.path.split('/').last;
      await _firebaseStorage
          .ref('UserProfileImages/$userID/$imageName')
          .putFile(image);

      _isSuccessful = true;
    } on fs.FirebaseException catch (e) {
      Get.snackbar('Error uploading image', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }

    return _isSuccessful;
  }

  Future _loadUserProfileImage(String imageName, String userID) async {
    return await _firebaseStorage
        .ref('UserProfileImages/$userID/$imageName')
        .getDownloadURL();
  }

  Future<String> getUserProfileImageURL(
          String imageName, String userID) async =>
      await _loadUserProfileImage(imageName, userID)
          .then((url) => url.toString());

  Future<bool> deleteUserProfileImage(String userID) async {
    bool _isSuccessful = false;
    try {
      await _firebaseStorage.ref('UserProfileImages/$userID').delete();
      _isSuccessful = true;
    } on fs.FirebaseException catch (e) {
      Get.snackbar('Error deleting image', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    return _isSuccessful;
  }

  Future<bool> changeUserProfileImage(File image, String userID) async {
    bool _isSuccessful = false;
    try {
      await deleteUserProfileImage(userID);
      await uploadUserProfileImage(image, userID);
      _isSuccessful = true;
    } on fs.FirebaseException catch (e) {
      Get.snackbar('Error uploading new profile image', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    return _isSuccessful;
  }

  Future getLegalDoc(String filename) async {
    final bytes = _firebaseStorage.ref().child(filename).getData();

    return bytes;
  }

  //DOCUMENTS CRUD
  // Future<bool> uploadTrainerDoc(File doc, String trainerID) async {
  //   bool _isSuccessful = false;
  //   try {
  //     var docName = doc.path.split('/').last;
  //     await _firebaseStorage
  //         .ref('TrainerDocuments/$trainerID/$docName')
  //         .putFile(doc);

  //     _isSuccessful = true;
  //   } on fs.FirebaseException catch (e) {
  //     Get.snackbar('Error uploading document', e.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }

  //   return _isSuccessful;
  // }

  // Future _loadTrainerDoc(String docName, String trainerID) async {
  //   return await _firebaseStorage
  //       .ref('TrainerDocuments/$trainerID/$docName')
  //       .getDownloadURL();
  // }

  // Future<String> getDocumentURL(String docName, String trainerID) async =>
  //     await _loadTrainerDoc(docName, trainerID).then((url) => url.toString());

  // Future<bool> deleteTrainerDocuments(String trainerID) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await _firebaseStorage.ref('TrainerDocuments/$trainerID').delete();
  //     _isSuccessful = true;
  //   } on fs.FirebaseException catch (e) {
  //     Get.snackbar('Error deleting documents', e.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  //   return _isSuccessful;
  // }

  // Future<bool> changeTrainerDocument(File doc, String trainerID) async {
  //   bool _isSuccessful = false;
  //   try {
  //     await deleteTrainerDocuments(trainerID);
  //     await uploadTrainerDoc(doc, trainerID);
  //     _isSuccessful = true;
  //   } on fs.FirebaseException catch (e) {
  //     Get.snackbar('Error uploading new document', e.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  //   return _isSuccessful;
  // }
}
