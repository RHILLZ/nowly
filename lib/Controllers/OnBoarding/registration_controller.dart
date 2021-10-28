import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:nowly/root.dart';

class RegistrationController extends GetxController {
  final NameAndInfoQModel nameAndInfoQModel = NameAndInfoQModel();
  final GoalsQModel goalsQModel = GoalsQModel();
  final InjuryHistoryQModel injuryHistoryQModel = InjuryHistoryQModel();
  final MedicalHistoryQModel medicalHistoryQModel = MedicalHistoryQModel();
  final ExerciseHistoryQModel exerciseHistoryQModel = ExerciseHistoryQModel();
  final PscoreQModel pscoreQModel = PscoreQModel();
  final Rx<UserModel> _user = UserModel().obs;

  final selectedQuestionnaire = QuestionnaireModel(
          title: '',
          header:
              'Our goal is to provide you the best fit trainer \n for your needs. Please take a moment and \n provide this info, help us help you!')
      .obs;

  final RxList _yesToMedHistoryQuestions = [].obs;

  createUser() async {
    AuthController _auth = Get.find<AuthController>();
    //USER INFO
    _user.value.id = _auth.firebaseUser.uid;
    _user.value.email = _auth.firebaseUser.email;
    _user.value.firstName = nameAndInfoQModel.firstName;
    _user.value.lastName = nameAndInfoQModel.lastName;
    _user.value.height = nameAndInfoQModel.height.toString();
    _user.value.weight = nameAndInfoQModel.weight.toString();
    _user.value.sex = nameAndInfoQModel.gender.toString();
    _user.value.birthYear = nameAndInfoQModel.birthYear.toString();
    //USER GOAL INFO
    _user.value.goals = goalsQModel.selectedFitnessGoals;
    _user.value.goalTimeFrame =
        goalsQModel.timeFrames[goalsQModel.selectedTimeFrameIndex.toInt()];
    _user.value.primaryGoal = goalsQModel.selectedPrimaryGoal.toString();
    //USER EXERCISE HISTORY
    _user.value.fitnessLevel =
        exerciseHistoryQModel.selectedFitnessLevel.toString();
    _user.value.activeDaysWeekly = exerciseHistoryQModel
        .workOutDays[exerciseHistoryQModel.selectedWorkOutIndex.toInt()];
    _user.value.hadPastTrainer =
        // ignore: unrelated_type_equality_checks
        exerciseHistoryQModel.trainedWithACoach == yesNoAnswer.yes
            ? true
            : false;
    _user.value.experienceWithPastTrainer =
        exerciseHistoryQModel.howWasIt.toString();
    //INJURY HISTORY
    _user.value.hasInjury = injuryHistoryQModel.hasInjury;
    _user.value.injuryDetails = injuryHistoryQModel.injuryDetail;

    //MEDICAL HISTORY
    _user.value.hasMedicalHistory = checkMedHistory();
    _user.value.yesToMedHistoryQuestions = _yesToMedHistoryQuestions;
    _user.value.medicalHistoryDetails = medicalHistoryQModel.info.toString();

    //pScore
    _user.value.pScore = pscore();
    //
    _user.value.createdAt = Timestamp.now();

    var result = await FirebaseFutures().createUserInFirestore(_user.value);
    if (result == true) {
      Get.off(const Root());
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
    if (sections.isNotEmpty) {
      showValidationDialog(sections);
    }
  }
}
