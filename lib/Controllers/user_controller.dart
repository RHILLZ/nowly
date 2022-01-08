import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/Firebase/firebase_futures.dart';
import 'package:nowly/Services/Firebase/firebase_streams.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'controller_exporter.dart';

class UserController extends GetxController {
  final _fcm = FirebaseMessaging.instance;
  final Rx<UserModel> _user = UserModel().obs;
  final _myWeight = ''.obs;
  RxList<SessionReceiptModel> sessionReceipts = <SessionReceiptModel>[].obs;
  RxList<SessionModel> scheduledSessions = <SessionModel>[].obs;
  final visibleAppointIndex = 0.obs;
  final _isUploading = false.obs;

  //FROM MYFITNESSGOALSCONTROLLER
  final _allFitnessGoals = <FitnessGoals>[].obs;
  final _myFavoriteWorkouts = <WorkoutType>[].obs;
  final _isChanged = false.obs;
  final _selectedGoals = <String>[].obs;

  get user => _user.value;
  get allFitnessGoals => _allFitnessGoals;
  get myFavoriteWorkouts => _myFavoriteWorkouts;
  get selectedGoals => _selectedGoals;
  get isChanged => _isChanged.value;
  get isUploading => _isUploading.value;

  set myWeight(value) => _myWeight.value = value;
  set isChanged(value) => _isChanged.value = value;

  @override
  void onInit() async {
    super.onInit();
    final uid = Get.put(AuthController()).firebaseUser.uid;
    _user.bindStream(FirebaseStreams().streamUser(uid));
    _getAllFitnessGoals();
    Future.delayed(const Duration(seconds: 2), () => checkTokenId());
    sessionReceipts.value = await FirebaseFutures().getSessionReceipts(uid);
    _fcm.onTokenRefresh.listen((token) => checkTokenId());
  }

//USER PROFILE METHODS AMD CONFIG//////////////////////////////////////////////////////
  updateGoals() async {
    _isUploading.toggle();
    final result =
        await FirebaseFutures().updateGoals(_user.value.id!, selectedGoals);
    if (result) {
      _isUploading.toggle();
      _isChanged.value = false;
      Get.snackbar('Goals Uploaded Successfully', '',
          backgroundColor: kActiveColor);
    } else {
      _isUploading.toggle();
      Get.snackbar('Something went wrong',
          'could not upload goals at the moment. Please try again.',
          backgroundColor: kerroreColor, colorText: Colors.white);
    }
  }

  @override
  void onReady() {
    super.onReady();
    once(_user, (callback) => setGoals());
  }

  setGoals() {
    for (var goal in _user.value.goals!) {
      _selectedGoals.add(goal);
    }
  }

  changed() {
    _isChanged.value = true;
  }

// CHECK FOR ONESIGNAL ID AND SET IF NONE FOUND
  Future<void> checkTokenId() async {
    final currentTokenId = _user.value.tokenId ?? '';
    final tokenId = await FirebaseMessaging.instance.getToken();

    if (currentTokenId != tokenId) {
      FirebaseFutures().setUserTokenId(_user.value.id!, tokenId!);
    }
  }

  //GET FITNESS GOALS
  _getAllFitnessGoals() => _allFitnessGoals.addAll(FitnessGoals.fitnessGoals);

  //PROFILE IMAGE
  final ImagePicker _picker = ImagePicker();
  final Rx<XFile> _image = XFile('').obs;
  final _isLoadingPic = false.obs;

  get image => _image.value;
  get isLoadingPic => _isLoadingPic.value;

  chooseProfilePic() async {
    _isLoadingPic.toggle();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _isLoadingPic.toggle();
      _image.value = image;
      AppLogger.i(image.path);
    } else {
      _isLoadingPic.toggle();
      Get.snackbar('Ooops!', 'Error loading image. Please Try Again.');
    }
  }

  setProfileImage() async {
    _isLoadingPic.toggle();
    final uid = _user.value.id;
    final uploaded = await FirebaseStorage()
        .uploadUserProfileImage(File(_image.value.path), uid!);
    if (uploaded) {
      _isLoadingPic.toggle();
      var imageName = image.path.split('/').last;
      final trainer = _user.value;
      trainer.profilePicURL =
          await FirebaseStorage().getUserProfileImageURL(imageName, uid);
      await FirebaseFutures().updateUserInFirestore(trainer);
      _image.value = XFile('');
      Get.back();
    } else {
      _isLoadingPic.toggle();
      Get.snackbar(
          'Uh Oh!', 'Cannot Set image at this time. Please Try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  //FEEDBACK CONTROL
  final _feedBack = ''.obs;
  final _isSubmitting = false.obs;
  final _submitted = false.obs;

  set feedBack(value) => _feedBack.value = value;
  set submitted(value) => _submitted.value = value;
  get isSubmitting => _isSubmitting.value;
  get submitted => _submitted.value;
  get feedBack => _feedBack.value;

  submitFeedback() async {
    _isSubmitting.toggle();
    FeedbackModel feedback = FeedbackModel();
    feedback.id = _user.value.id;
    feedback.name = '${user.firstName} ${user.lastName}';
    feedback.message = _feedBack.value;
    feedback.timestamp = Timestamp.now();

    var sub = await FirebaseFutures().submitSuggestion(feedback);
    // Future.delayed(const Duration(seconds: 3));
    if (sub) {
      _feedBack.value = '';
      _isSubmitting.toggle();
      _submitted.value = true;
    }
  }
}
