import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/Auth/preferences_controller.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/root.dart';

class RegistrationController extends GetxController {
  final NameAndInfoQModel nameAndInfoQModel = NameAndInfoQModel();
  final GoalsQModel goalsQModel = GoalsQModel();
  final InjuryHistoryQModel injuryHistoryQModel = InjuryHistoryQModel();
  final MedicalHistoryQModel medicalHistoryQModel = MedicalHistoryQModel();
  final ExerciseHistoryQModel exerciseHistoryQModel = ExerciseHistoryQModel();
  final PscoreQModel pscoreQModel = PscoreQModel();
  final Rx<UserModel> _user = UserModel().obs;
  final _isProcessing = false.obs;
  final _isOver18 = false.obs;
  final _profileReady = false.obs;

  get isOver18 => _isOver18.value;
  get profileReady => _profileReady.value;
  set isOver18(value) => _isOver18.value = value;

  get isProcessing => _isProcessing.value;

  final selectedQuestionnaire = QuestionnaireModel(
          title: '',
          header:
              'Our goal is to provide you the best fit trainer \n for your needs. Please take a moment and \n provide this info, help us help you!')
      .obs;

  final RxList _yesToMedHistoryQuestions = [].obs;

  createUser() async {
    _isProcessing.toggle();
    // final _preferences = Get.put(PreferencesController());
    final _preferences = Get.find<PreferencesController>();
    AuthController _auth = Get.find<AuthController>();
    final uid = _auth.firebaseUser.uid;
    final email = _auth.firebaseUser.email;
    //USER INFO
    UserModel user = _user.value;
    user.id = uid;
    user.email = email;
    user.firstName = nameAndInfoQModel.firstName;
    user.lastName = nameAndInfoQModel.lastName;
    user.height = nameAndInfoQModel.height.toString();
    user.weight = nameAndInfoQModel.weight.toString();
    user.sex = nameAndInfoQModel.gender.toString();
    user.birthYear = nameAndInfoQModel.birthYear.toString();
    //USER GOAL INFO
    user.goals = goalsQModel.selectedFitnessGoals;
    user.goalTimeFrame =
        goalsQModel.timeFrames[goalsQModel.selectedTimeFrameIndex.toInt()];
    user.primaryGoal = goalsQModel.selectedPrimaryGoal.toString();
    //USER EXERCISE HISTORY
    user.fitnessLevel = exerciseHistoryQModel.selectedFitnessLevel.toString();
    user.activeDaysWeekly = exerciseHistoryQModel
        .workOutDays[exerciseHistoryQModel.selectedWorkOutIndex.toInt()];
    user.hadPastTrainer =
        // ignore: unrelated_type_equality_checks
        exerciseHistoryQModel.trainedWithACoach == yesNoAnswer.yes
            ? true
            : false;
    user.experienceWithPastTrainer = exerciseHistoryQModel.howWasIt.toString();
    //INJURY HISTORY
    user.hasInjury = injuryHistoryQModel.hasInjury;
    user.injuryDetails = injuryHistoryQModel.injuryDetail;
    //MEDICAL HISTORY
    user.hasMedicalHistory = checkMedHistory();
    user.yesToMedHistoryQuestions = _yesToMedHistoryQuestions;
    user.medicalHistoryDetails = medicalHistoryQModel.info.toString();
    //PSCORE
    user.pScore = pscore();
    user.createdAt = Timestamp.now();
    var result = await FirebaseFutures().createUserInFirestore(user);
    if (result == true) {
      _isProcessing.toggle();
      await _preferences.prefs?.setBool('register', true);
      Get.to(() => const Root());
      // change to Get.off
      
    } else {
      _isProcessing.toggle();
      Get.snackbar('Something went wrong.',
          'Could not create profile at this time. Please try agian later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  bool checkMedHistory() {
    _yesToMedHistoryQuestions.clear();
    bool medHistory = false;
    for (var element in medicalHistoryQModel.medicalQA) {
      if (element().answer == yesNoAnswer.yes) {
        medHistory = true;
        _yesToMedHistoryQuestions.add(element().question);
      }
    }
    return medHistory;
  }

  pscore() {
    final RxList _pscore = [].obs;
    _pscore.clear();
    for (var element in pscoreQModel.pscoreQA) {
      final score = element().answer.value + 1;
      _pscore.add(score);
    }
    return _pscore;
  }

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    // selectedQuestionnaire.value = nameAndInfoQModel;
    super.onInit();
  }

  Future<void> isEveryRequirmentsFilled() async {
    final List<String> sections = [];

    if (!nameAndInfoQModel.filled.value) {
      sections.add('Name and info');
    }
    if (!goalsQModel.filled.value) {
      sections.add('Goals');
    }
    if (!pscoreQModel.filled.value) {
      sections.add('Personality');
    }
    if (!exerciseHistoryQModel.filled.value) {
      sections.add('Exercise History');
    }
    if (!injuryHistoryQModel.filled.value) {
      sections.add('Injury History');
    }
    if (!medicalHistoryQModel.filled.value) {
      sections.add('Medical History');
    }

    if (sections.isEmpty) {
      _profileReady.value = true;
    }
  }
}
