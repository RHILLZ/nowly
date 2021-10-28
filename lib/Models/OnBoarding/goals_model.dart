import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';

class FitnessGoals {
  final String goal;
  final String imagePath;
  FitnessGoals({required this.goal, required this.imagePath});

  static final fitnessGoals = <FitnessGoals>[
    FitnessGoals(goal: 'improve overall health', imagePath: ''),
    FitnessGoals(goal: 'cardiovascular fitness', imagePath: ''),
    FitnessGoals(goal: 'sport event', imagePath: ''),
    FitnessGoals(goal: 'gain lean muscle mass', imagePath: ''),
    FitnessGoals(goal: 'recover from an injury', imagePath: ''),
    FitnessGoals(goal: 'increase flexibility', imagePath: ''),
    FitnessGoals(goal: 'increase overall strength', imagePath: ''),
    FitnessGoals(goal: 'prepare for life event', imagePath: ''),
    FitnessGoals(goal: 'learn a new movement/tool', imagePath: ''),
    FitnessGoals(goal: 'get toned', imagePath: ''),
  ];
}

class GoalsQModel extends QuestionnaireModel {
  GoalsQModel()
      : super(
            title: 'Goals',
            header: "No, we're not talking about Bae goals\n🥯🥯");

  final fitnessGoals = <String>[
    'sport event',
    'prepare for life event',
    'improve overall health',
    'get toned',
    'cardiovascular fitness',
    'recover from an injury',
    'gain lean muscle mass',
    'increase overall strength',
    'increase flexibility',
    'learn a new movement/tool',
  ];

  final primaryGoals = <String>[
    'gain lean muscle mass',
    'improve overall health',
    'increase overall strength',
    'get toned',
  ];

  final timeFrames = <String>[
    '4 Weeks',
    '2 Months',
    '3 Months',
    '6 Months',
    '1 Year'
  ];

  final selectedFitnessGoals = <String>[].obs;
  RxString selectedPrimaryGoal = ''.obs;
  RxInt selectedTimeFrameIndex = 1.obs;

  @override
  void toogleFilled() {
    filled.value = false;
    if (selectedFitnessGoals.isEmpty) {
      return;
    }
    if (selectedPrimaryGoal.isEmpty) {
      return;
    }
    filled.value = true;
  }
}
