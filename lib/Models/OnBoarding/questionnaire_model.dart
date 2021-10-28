import 'package:get/get.dart';

enum yesNoAnswer{
  yes, no, notAnswered
}

class QuestionnaireModel {
  String title;
  String header;
  var filled = false.obs;
  void toogleFilled() {}

  QuestionnaireModel({required this.title, required this.header});
}







