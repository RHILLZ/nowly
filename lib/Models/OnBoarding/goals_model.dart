import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';

class FitnessGoals {
  final String goal;
  final String imagePath;
  FitnessGoals({required this.goal, required this.imagePath});

  static final fitnessGoals = <FitnessGoals>[
    FitnessGoals(goal: 'Improve overall health', imagePath: ''),
    FitnessGoals(goal: 'Cardiovascular fitness', imagePath: ''),
    FitnessGoals(goal: 'Sport event', imagePath: ''),
    FitnessGoals(goal: 'Gain lean muscle mass', imagePath: ''),
    FitnessGoals(goal: 'Recover from an injury', imagePath: ''),
    FitnessGoals(goal: 'Increase flexibility', imagePath: ''),
    FitnessGoals(goal: 'Increase overall strength', imagePath: ''),
    FitnessGoals(goal: 'Prepare for life event', imagePath: ''),
    FitnessGoals(goal: 'Learn a new movement/tool', imagePath: ''),
    FitnessGoals(goal: 'Get toned', imagePath: ''),
  ];
}

class GoalsQModel extends QuestionnaireModel {
  GoalsQModel()
      : super(
            title: 'Goals',
            header: "No, we're not talking about Bae goals\n🥯🥯");

  final fitnessGoals = <String>[
    'Sport event',
    'Prepare for life event',
    'Improve overall health',
    'Get toned',
    'Cardiovascular fitness',
    'Recover from an injury',
    'Gain lean muscle mass',
    'Increase overall strength',
    'Increase flexibility',
    'Learn a new movement/tool',
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
