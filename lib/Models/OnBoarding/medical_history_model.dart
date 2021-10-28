import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';

class MedicalHistoryQModel extends QuestionnaireModel {
  MedicalHistoryQModel()
      : super(
            title: 'Medical History',
            header: "Well, hope this didn't get awkward...") {
    generateQA();
  }

  List<String> questions = [
    "any reason why you shouldn't perform physical activity?",
    "are you taking any medication that may be relevant to physical activity?",
    "do you have any current or past injuries/surgeries we should know of?",
    "do you experience an irregular or racing heart rate?",
    "ever have a heart condition and should only do doctor recommended exercises?",
    "are you taking any doctor prescribed drugs for blood pressure or heart condition?",
    "do you lose your balance because of dizziness or ever lose consciousness?",
    "any bone or joint problem that could get worse by change in activity?",
    "are you over 65 and not accustomed to vigorous exercise?",
    "are you diabetic?",
    "are you pregnant?",
    "any exercise or movement that cause pain as a result?"
  ];

  final medicalQA = <Rx<MedicalQA>>[].obs;
  final info = ''.obs;

  List<Rx<MedicalQA>> generateQA() {
    final qa = questions
        .map((question) =>
            Rx(MedicalQA(answer: yesNoAnswer.notAnswered, question: question)))
        .toList();
    medicalQA.addAll(qa);
    return medicalQA;
  }

  void makeAllNegative() {
    for (final q in medicalQA) {
      q.update((val) {
        val!.answer = yesNoAnswer.no;
      });
    }
  }

  @override
  void toogleFilled() {
    filled.value = false;

    final bool anyNotAnswered =
        medicalQA.any((q) => q.value.answer == yesNoAnswer.notAnswered);
    final bool isAnyYes =
        medicalQA.any((q) => q.value.answer == yesNoAnswer.yes);

    if (isAnyYes && info.isEmpty) {
      return;
    }
    if (anyNotAnswered) {
      return;
    }

    filled.value = true;
  }
}

class MedicalQA {
  final String question;
  late yesNoAnswer answer;

  MedicalQA({required this.question, required this.answer});
}
