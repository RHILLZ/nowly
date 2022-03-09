import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Utils/app_logger.dart';

class NameAndInfoQModel extends QuestionnaireModel {
  NameAndInfoQModel()
      : super(
            title: 'Name & Info',
            header:
                "Your name is the best pick-up line. Not that we're trying to pick you up or anything. #friendzone");

  final RxString _firstName = ''.obs;
  final RxString _lastName = ''.obs;
  final height = 5.8.obs;
  final weight = 150.obs;
  final gender = ''.obs;
  final birthYear = DateTime(DateTime.now().year).obs;

  set firstName(value) => _firstName.value = value;
  set lastName(value) => _lastName.value = value;

  get firstName => _firstName.value;
  get lastName => _lastName.value;

  @override
  void toogleFilled() {
    filled.value = false;
    if (firstName == null || firstName!.isEmpty) {
      return;
    }
    if (lastName == null || lastName!.isEmpty) {
      return;
    }
    if (gender.isEmpty) {
      return;
    }
    if (birthYear.value == DateTime(DateTime.now().year)) {
      return;
    }

    filled.value = true;
    AppLogger.info('Name & Info - $filled');
  }
}
