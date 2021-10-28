import 'package:get/get.dart';
import 'package:nowly/Models/OnBoarding/questionnaire_model.dart';

class ExerciseHistoryQModel extends QuestionnaireModel {
  ExerciseHistoryQModel()
      : super(
            title: 'Exercise History',
            header:
                'No, running late does not count as having an exercise history.');

  final fitnessLevels = <String>[
    'novice',
    'intermediate',
    'advanced',
  ];

  final workOutDays = <String>[
    '1 Day',
    '2 Days',
    '3 Days',
    '4 Days',
    '5 Days',
    '6 Days',
    '7 Days',
  ];

  final howWasItAnswers = <String>[
    'intimidating',
    'motivating',
    'educational',
    'negative experience',
    'positive experience'
  ];

  final selectedFitnessLevel = ''.obs;
  final selectedWorkOutIndex = 2.obs;
  final trainedWithACoach = yesNoAnswer.notAnswered.obs;
  final howWasIt = ''.obs;

  @override
  void toogleFilled() {
    filled.value = false;
    if (selectedFitnessLevel.isEmpty) {
      return;
    }
    if (trainedWithACoach.value == yesNoAnswer.notAnswered) {
      return;
    }
    filled.value = true;
  }
}
