import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'questionnaire_model.dart';

class PscoreQModel extends QuestionnaireModel {
  PscoreQModel()
      : super(
            title: 'Personality',
            header:
                'In order to connect you with someone that best suits you, we kind of need to know you.') {
    generateQA();
  }

  List<String> personalityQuestions = [
    'I consider myself a very open minded individual.',
    'I prefer pizza and beer over a salad anyday.',
    'I consider myself an introvert.',
    'I am the life of the party at any event.',
    'My ideal vacation is on a beach in a warm location.'
  ];

  final answerOptions = <String>[
    'strongly disagree',
    'disagree',
    'nuetral',
    'agreed',
    'strongly agreed'
  ];

  final pscoreQA = <Rx<PscoreQA>>[].obs;

  List<Rx<PscoreQA>> generateQA() {
    final qa = personalityQuestions
        .map((question) => Rx(PscoreQA(answer: 2.obs, question: question)))
        .toList();
    pscoreQA.addAll(qa);
    return pscoreQA;
  }

  @override
  void toogleFilled() {
    filled.value = true;
  }
}

class PscoreQA {
  final String question;
  RxInt answer;

  PscoreQA({required this.question, required this.answer});
}
